//
//  TKClient.m
//  TravisKit
//
//  Created by Dal Rupnik on 17/06/14.
//  Copyright (c) 2014 arvystate.net. All rights reserved.
//

extern NSString* const TKOpenSourceServer = @"http://api.travis-ci.org/";
extern NSString* const TKPrivateServer = @"http://api.travis-ci.com/";

#import <AFNetworking/AFNetworking.h>

#import "TKClient.h"

@interface TKClient ()

@property (nonatomic, strong) NSString* accessToken;

@property (nonatomic, strong) AFHTTPRequestOperationManager* manager;

@end

@implementation TKClient

- (BOOL)isAuthenticated
{
    return ([self.accessToken length] > 0);
}

/*!
 * Do not allow initializing client without required parameters
 */
- (id)init
{
    return nil;
}

- (id)initWithServer:(NSString *)server
{
    self = [super init];
    
    if (self)
    {
        self.manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:server]];
        [self.manager.requestSerializer setValue:@"application/vnd.travis-ci.2+json" forHTTPHeaderField:@"Accept"];
    }
    
    return self;
}

- (void)setupAuthorizationToken
{
    if ([self.accessToken length])
    {
        [self.manager.requestSerializer setValue:[NSString stringWithFormat:@"token \"%@\"", self.accessToken] forHTTPHeaderField:@"Authorization"];
    }
    else
    {
        [self.manager.requestSerializer setValue:nil forHTTPHeaderField:@"Authorization"];
    }
}

- (void)authenticateWithGitHubToken:(NSString *)token success:(void (^)())success failure:(void (^)(NSError* error))failure
{
    [self.manager POST:@"auth/github" parameters:@{ @"github_token" : token } success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        self.accessToken = responseObject[@"access_token"];
        
        if (success)
        {
            success();
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failure)
        {
            failure (error);
        }
    }];
}

@end
