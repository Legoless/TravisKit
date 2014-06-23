//
//  TKLogClient.m
//  TravisKit
//
//  Created by Dal Rupnik on 18/06/14.
//  Copyright (c) 2014 arvystate.net. All rights reserved.
//

#import <Pusher/Pusher.h>

#import "TKLogClient.h"

@interface TKLogClient () <PTPusherDelegate>

/*!
 * Main pusher client connected to Pusher service
 */
@property (nonatomic, strong) PTPusher *client;

/*!
 * Connection blocks
 */
@property (nonatomic, copy) void (^successBlock)();
@property (nonatomic, copy) void (^failureBlock)(NSError* error);

@end

@implementation TKLogClient

+ (instancetype)logClientWithPusherKey:(NSString *)pusherKey
{
    return [[self alloc] initWithPusherKey:pusherKey];
}

- (BOOL)isConnected
{
    return self.client.connection.isConnected;
}
- (id)initWithPusherKey:(NSString *)pusherKey
{
    self = [super init];
    
    if (self && [pusherKey length])
    {
        self.client = [PTPusher pusherWithKey:pusherKey delegate:self encrypted:YES];
    }
    
    return self;
}

- (void)connectWithSuccess:(void (^) ())success failure:(void (^) (NSError *error))failure
{
    if (self.isConnected)
    {
        return;
    }

    self.successBlock = success;
    self.failureBlock = failure;

    //
    // Connect to Pusher
    //
    [self.client connect];
}

- (void)subscribeJobId:(NSInteger)jobId withMessageBlock:(void (^) (NSInteger jobId, NSString *message))messageBlock
{
    PTPusherChannel *channel = [self.client subscribeToChannelNamed:[self stringForJobId:jobId]];

    [channel bindToEventNamed:@"job:log" handleWithBlock:^(PTPusherEvent *channelEvent)
    {
        NSString *message = channelEvent.data;

        messageBlock(jobId, message);
    }];
}

- (void)unsubscribeJobId:(NSInteger)jobId
{
    PTPusherChannel *channel = [self.client channelNamed:[self stringForJobId:jobId]];
    [channel unsubscribe];
}

#pragma mark PTPusherDelegate

- (void)pusher:(PTPusher *)pusher connectionDidConnect:(PTPusherConnection *)connection
{
    if (self.successBlock)
    {
        self.successBlock();

        self.successBlock = nil;
        self.failureBlock = nil;
    }
}

- (void)pusher:(PTPusher *)pusher connection:(PTPusherConnection *)connection failedWithError:(NSError *)error
{
    if (self.failureBlock)
    {
        self.failureBlock(error);

        self.successBlock = nil;
        self.failureBlock = nil;
    }
}

#pragma mark Private utility methods

- (NSString *)stringForJobId:(NSInteger)jobId
{
    return [NSString stringWithFormat:@"job-%ld", (long)jobId];
}

@end

#ifdef _TRAVISKIT_

@implementation TKLogClient (TravisObjects)

+ (instancetype)logClientWithConfig:(TKConfig *)config
{
    return [self logClientWithPusherKey:config.pusher[@"key"]];
}

- (id)initWithConfig:(TKConfig *)config
{
    return [self initWithPusherKey:config.pusher[@"key"]];
}

- (void)subscribeJob:(TKJob *)job withMessageBlock:(void (^) (NSInteger jobId, NSString *message))messageBlock
{
    [self subscribeJobId:job.id withMessageBlock:messageBlock];
}

- (void)unsubscribeJob:(TKJob *)job
{
    [self unsubscribeJobId:job.id];
}

#endif

@end
