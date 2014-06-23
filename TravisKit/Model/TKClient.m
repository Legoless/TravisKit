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

+ (instancetype)clientWithServer:(NSString *)server
{
    return [[self alloc] initWithServer:server];
}

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

#pragma mark Authentication

- (void)authenticateWithGitHubToken:(NSString *)token success:(void (^)())success failure:(void (^)(NSError* error))failure
{
    [self.manager POST:@"auth/github" parameters:@{ @"github_token" : token } success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        self.accessToken = responseObject[@"access_token"];

        [self setupAuthorizationToken];
        
        if (success)
        {
            success();
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        [self setupAuthorizationToken];

        if (failure)
        {
            failure (error);
        }
    }];
}

#pragma mark Accounts

- (void)accountsWithSuccess:(void (^) (NSArray *accounts))success failure:(void (^) (NSError *error))failure
{
    [self.manager GET:@"accounts" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        //TKAcc
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {

    }];
}

- (void)accountsWithAdmin:(BOOL)admin success:(void (^)(NSArray* accounts))success failure:(void (^)(NSError* error))failure
{

}

#pragma mark Annotations

- (void)annotationsWithJobId:(NSInteger)jobId success:(void (^)(NSArray* annotations))success failure:(void (^)(NSError* error))failure
{

}

- (void)createAnnotation:(TKAnnotation *)annotation withJobId:(NSInteger)jobId success:(void (^)())success failure:(void (^)(NSError* error))failure
{

}


#pragma mark Builds

- (void)buildsWithIds:(NSArray *)ids success:(void (^)(TKBuildPayload* builds))success failure:(void (^)(NSError* error))failure
{

}

- (void)buildsWithIds:(NSArray *)ids eventType:(TKEventType)eventType success:(void (^)(TKBuildPayload* builds))success failure:(void (^)(NSError* error))failure
{

}

- (void)buildsWithRepositoryId:(NSInteger)repositoryId success:(void (^)(TKBuildPayload* builds))success failure:(void (^)(NSError* error))failure
{

}

- (void)buildsWithRepositoryId:(NSInteger)repositoryId buildNumber:(NSInteger)buildNumber afterNumber:(NSInteger)afterNumber success:(void (^)(TKBuildPayload* builds))success failure:(void (^)(NSError* error))failure
{

}

- (void)buildsWithSlug:(NSString *)slug success:(void (^)(TKBuildPayload* builds))success failure:(void (^)(NSError* error))failure
{

}

- (void)buildsWithSlug:(NSString *)slug buildNumber:(NSInteger)buildNumber afterNumber:(NSInteger)afterNumber success:(void (^)(TKBuildPayload* builds))success failure:(void (^)(NSError* error))failure
{

}

- (void)buildWithId:(NSInteger)buildId success:(void (^)(TKBuild* build))success failure:(void (^)(NSError* error))failure
{

}

- (void)cancelBuildWithId:(NSInteger)buildId success:(void (^)())success failure:(void (^)(NSError* error))failure
{

}

- (void)restartBuildWithId:(NSInteger)buildId success:(void (^)())success failure:(void (^)(NSError* error))failure
{

}

#pragma mark Caches

- (void)cachesWithRepositoryId:(NSInteger)repositoryId success:(void (^)(NSArray* caches))success failure:(void (^)(NSError* error))failure
{

}

- (void)cachesWithRepositoryId:(NSInteger)repositoryId branch:(NSString *)branch match:(NSString *)match success:(void (^)(NSArray* caches))success failure:(void (^)(NSError* error))failure
{

}

- (void)cachesWithSlug:(NSString *)slug success:(void (^)(NSArray* caches))success failure:(void (^)(NSError* error))failure
{

}

- (void)cachesWithSlug:(NSString *)slug branch:(NSString *)branch match:(NSString *)match success:(void (^)(NSArray* caches))success failure:(void (^)(NSError* error))failure
{

}

- (void)deleteCachesWithRepositoryId:(NSInteger)repositoryId success:(void (^)())success failure:(void (^)(NSError* error))failure
{

}

- (void)deleteCachesWithRepositoryId:(NSInteger)repositoryId branch:(NSString *)branch match:(NSString *)match success:(void (^)())success failure:(void (^)(NSError* error))failure
{

}

- (void)deleteCachesWithSlug:(NSString *)slug success:(void (^)())success failure:(void (^)(NSError* error))failure
{

}

- (void)deleteCachesWithSlug:(NSString *)slug branch:(NSString *)branch match:(NSString *)match success:(void (^)())success failure:(void (^)(NSError* error))failure
{

}

#pragma mark Config

- (void)configWithSuccess:(void (^)(TKConfig * config))success failure:(void (^)(NSError* error))failure
{

}

#pragma mark Hooks

- (void)hooksWithSuccess:(void (^)(NSArray* hooks))success failure:(void (^)(NSError* error))failure
{

}

- (void)updateHook:(TKHook* *)hook success:(void (^)())success failure:(void (^)(NSError* error))failure
{

}

#pragma mark Jobs

- (void)jobWithId:(NSInteger)jobId success:(void (^)(TKJob* job))success failure:(void (^)(NSError* error))failure
{

}

- (void)cancelJobWithId:(NSInteger)jobId success:(void (^)())success failure:(void (^)(NSError* error))failure
{

}

- (void)restartJobWithId:(NSInteger)jobId success:(void (^)())success failure:(void (^)(NSError* error))failure
{

}

#pragma mark Logs

- (void)logWithJobId:(NSInteger)jobId success:(void (^)(NSString* log))success failure:(void (^)(NSError* error))failure
{

}

- (void)logWithId:(NSInteger)logId success:(void (^)(TKLog* log))success failure:(void (^)(NSError* error))failure
{

}

#pragma mark Permissions

- (void)permissionsWithSuccess:(void (^)(TKPermissions* log))success failure:(void (^)(NSError* error))failure
{

}

#pragma mark Repositories

- (void)repositoriesWithIds:(NSArray *)ids success:(void (^)(NSArray* repositories))success failure:(void (^)(NSError* error))failure
{

}

- (void)searchRepositoriesByTerm:(NSString *)term member:(NSString *)member ownerName:(NSString *)ownerName slug:(NSString *)slug active:(BOOL)active success:(void (^)(NSArray* repositories))success failure:(void (^)(NSError* error))failure
{

}

- (void)repositoryWithId:(NSInteger)repositoryId success:(void (^)(TKRepository* repository))success failure:(void (^)(NSError* error))failure
{

}

- (void)repositoryWithSlug:(NSString *)slug success:(void (^)(TKRepository* repository))success failure:(void (^)(NSError* error))failure
{

}

#pragma mark Repository Keys

- (void)repositoryKeyWithId:(NSInteger)repositoryId success:(void (^)(TKRepositoryKey* repositoryKey))success failure:(void (^)(NSError* error))failure
{

}

- (void)repositoryKeyWithSlug:(NSString *)slug success:(void (^)(TKRepositoryKey* repositoryKey))success failure:(void (^)(NSError* error))failure
{

}

- (void)invalidateRepositoryKeyWithId:(NSInteger)repositoryId success:(void (^)())success failure:(void (^)(NSError* error))failure
{

}

- (void)invalidateRepositoryKeyWithSlug:(NSString *)slug success:(void (^)())success failure:(void (^)(NSError* error))failure
{

}

#pragma mark Requests

- (void)requestsWithRepositoryId:(NSInteger)repositoryId success:(void (^)(NSArray* requests))success failure:(void (^)(NSError* error))failure
{

}

- (void)requestsWithRepositoryId:(NSInteger)repositoryId limit:(NSInteger)limit olderThan:(NSDate *)olderThan success:(void (^)(NSArray* requests))success failure:(void (^)(NSError* error))failure
{

}

- (void)requestsWithSlug:(NSString *)slug success:(void (^)(NSArray* requests))success failure:(void (^)(NSError* error))failure
{

}

- (void)requestsWithSlug:(NSString *)slug limit:(NSInteger)limit olderThan:(NSDate *)olderThan success:(void (^)(NSArray* requests))success failure:(void (^)(NSError* error))failure
{

}

- (void)requestWithId:(NSInteger)requestId success:(void (^)(TKRequest* request))success failure:(void (^)(NSError* error))failure
{

}

#pragma mark Settings

- (void)settingsForRepositoryId:(NSInteger)repositoryId success:(void (^)(TKSettings* settings))success failure:(void (^)(NSError* error))failure
{

}

- (void)updateSettingsForRepositoryId:(NSInteger)repositoryId settings:(TKSettings *)settings success:(void (^)())success failure:(void (^)(NSError* error))failure
{

}

#pragma mark Users

- (void)usersWithSuccess:(void (^)(NSArray* users))success failure:(void (^)(NSError* error))failure
{

}

- (void)userWithId:(NSInteger)userId success:(void (^)(TKUser* user))success failure:(void (^)(NSError* error))failure
{

}

- (void)userTriggerSyncWithSuccess:(void (^)())success failure:(void (^)(NSError* error))failure
{

}

@end
