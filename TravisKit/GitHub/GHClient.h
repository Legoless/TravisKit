//
//  TKLogClient.h
//  TravisKit
//
//  Created by Dal Rupnik on 18/06/14.
//  Copyright (c) 2014 arvystate.net. All rights reserved.
//

#import "TKLog.h"
#import "TKConfig.h"
#import "TKJob.h"

/*!
 * Travis CI Job log channel based on Pusher service, wraps PTPushercClient in a common, block syntax
 */
@interface TKLogClient : NSObject

@property (nonatomic, readonly) BOOL isConnected;
@property (nonatomic, strong) NSArray* activeJobIds;

+ (instancetype)logClientWithPusherKey:(NSString *)pusherKey;

- (id)initWithPusherKey:(NSString *)pusherKey;

- (void)connectWithSuccess:(void (^)())success failure:(void (^)(NSError * error))failure;

- (void)subscribeJobId:(NSInteger)jobId withMessageBlock:(void (^)(NSInteger jobId, NSString* message))messageBlock;
- (void)unsubscribeJobId:(NSInteger)jobId;

@end

/*!
 * Category adds convenience methods for TravisKit objects
 */
@interface TKLogClient (TravisObjects)

+ (instancetype)logClientWithConfig:(TKConfig *)config;

- (id)initWithConfig:(TKConfig *)config;

- (void)subscribeJob:(TKJob *)job withMessageBlock:(void (^)(NSInteger jobId, NSString* message))messageBlock;
- (void)unsubscribeJob:(TKJob *)job;

@end