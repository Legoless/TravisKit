//
//  TKClient.m
//  TravisKit
//
//  Created by Dal Rupnik on 17/06/14.
//  Copyright (c) 2014 arvystate.net. All rights reserved.
//

NSString* const TKOpenSourceServer = @"https://api.travis-ci.org/";
NSString* const TKPrivateServer = @"https://api.travis-ci.com/";

#import <AFNetworking/AFNetworking.h>

#import "TKClient.h"

@interface TKClient ()

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
    [self accountsWithAdmin:false success:success failure:failure];
}

- (void)accountsWithAdmin:(BOOL)admin success:(void (^)(NSArray* accounts))success failure:(void (^)(NSError* error))failure
{
    NSDictionary *parameters = nil;

    if (admin)
    {
        parameters = @{ @"all" : @"true" };
    }

    [self.manager GET:@"accounts" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSError* error;

        NSArray* objects = [TKAccount arrayOfModelsFromDictionaries:responseObject[@"accounts"] error:&error];

        if (!error && success)
        {
            success(objects);
        }
        else if (error && failure)
        {
            failure(error);
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failure)
        {
            failure(error);
        }
    }];
}

#pragma mark Annotations

- (void)annotationsWithJobId:(NSInteger)jobId success:(void (^)(NSArray* annotations))success failure:(void (^)(NSError* error))failure
{
    [self.manager GET:[NSString stringWithFormat:@"jobs/%ld/annotations", (long)jobId] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSError* error;

        NSArray* objects = [TKAnnotation arrayOfModelsFromDictionaries:responseObject[@"annotations"] error:&error];

        if (!error && success)
        {
            success(objects);
        }
        else if (error && failure)
        {
            failure(error);
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failure)
        {
            failure(error);
        }
    }];
}

- (void)createAnnotation:(TKAnnotation *)annotation withJobId:(NSInteger)jobId success:(void (^)())success failure:(void (^)(NSError* error))failure
{
    NSDictionary *annotationDictionary = [annotation toDictionary];

    [self.manager POST:[NSString stringWithFormat:@"jobs/%ld/annotations", (long)jobId] parameters:annotationDictionary success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        if (success)
        {
            success();
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failure)
        {
            failure(error);
        }
    }];
}

#pragma mark Branches

- (void)branchesWithRepositoryId:(NSInteger)repositoryId success:(void (^)(NSArray* branches))success failure:(void (^)(NSError* error))failure
{
    [self.manager GET:[NSString stringWithFormat:@"repos/%ld/branches", (long)repositoryId] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSError* error;

        NSArray* objects = [TKBranch arrayOfModelsFromDictionaries:responseObject[@"branches"] error:&error];

        if (!error && success)
        {
            success(objects);
        }
        else if (error && failure)
        {
            failure(error);
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failure)
        {
            failure(error);
        }
    }];
}

- (void)branchesWithSlug:(NSString *)slug success:(void (^)(NSArray* branches))success failure:(void (^)(NSError* error))failure
{
    [self.manager GET:[NSString stringWithFormat:@"repos/%@/branches", slug] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSError* error;

        NSArray* objects = [TKBranch arrayOfModelsFromDictionaries:responseObject[@"branches"] error:&error];

        if (!error && success)
        {
            success(objects);
        }
        else if (error && failure)
        {
            failure(error);
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failure)
        {
            failure(error);
        }
    }];
}

#pragma mark Broadcasts

- (void)broadcastsWithSuccess:(void (^)(NSArray* broadcasts))success failure:(void (^)(NSError* error))failure
{
    [self.manager GET:@"broadcasts" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSError* error;

        NSArray* objects = [TKBroadcast arrayOfModelsFromDictionaries:responseObject[@"broadcasts"] error:&error];

        if (!error && success)
        {
            success(objects);
        }
        else if (error && failure)
        {
            failure(error);
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failure)
        {
            failure(error);
        }
    }];
}

#pragma mark Builds

- (void)buildsWithIds:(NSArray *)ids success:(void (^)(TKBuildPayload* builds))success failure:(void (^)(NSError* error))failure
{
    [self buildsWithIds:ids eventType:TKEventTypeAny success:success failure:failure];
}

- (void)buildsWithIds:(NSArray *)ids eventType:(TKEventType)eventType success:(void (^)(TKBuildPayload* builds))success failure:(void (^)(NSError* error))failure
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];

    parameters[@"ids"] = ids;

    if (eventType == TKEventTypePush)
    {
        parameters[@"event_type"] = @"push";
    }

    if (eventType == TKEventTypePullRequest)
    {
        parameters[@"event_type"] = @"pull_request";
    }

    [self.manager GET:@"builds" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSError* error;

        id object = [[TKBuildPayload alloc] initWithDictionary:responseObject error:&error];

        if (!error && success)
        {
            success (object);
        }
        else if (error && failure)
        {
            failure(error);
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failure)
        {
            failure(error);
        }
    }];
}

- (void)buildsWithRepositoryId:(NSInteger)repositoryId success:(void (^)(TKBuildPayload* builds))success failure:(void (^)(NSError* error))failure
{
    [self buildsWithRepositoryId:repositoryId buildNumber:0 afterNumber:0 eventType:TKEventTypeAny success:success failure:failure];
}

- (void)buildsWithRepositoryId:(NSInteger)repositoryId buildNumber:(NSInteger)buildNumber afterNumber:(NSInteger)afterNumber eventType:(TKEventType)eventType success:(void (^)(TKBuildPayload* builds))success failure:(void (^)(NSError* error))failure
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];

    if (buildNumber > 0)
    {
        parameters[@"number"] = @(buildNumber);
    }

    if (afterNumber > 0)
    {
        parameters[@"after_number"] = @(afterNumber);
    }

    if (eventType == TKEventTypePush)
    {
        parameters[@"event_type"] = @"push";
    }

    if (eventType == TKEventTypePullRequest)
    {
        parameters[@"event_type"] = @"pull_request";
    }

    [self.manager GET:[NSString stringWithFormat:@"repos/%ld/builds", (long)repositoryId] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSError* error;

        id object = [[TKBuildPayload alloc] initWithDictionary:responseObject error:&error];

        if (!error && success)
        {
            success (object);
        }
        else if (error && failure)
        {
            failure(error);
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failure)
        {
            failure(error);
        }
    }];
}

- (void)buildsWithSlug:(NSString *)slug success:(void (^)(TKBuildPayload* builds))success failure:(void (^)(NSError* error))failure
{
    [self buildsWithSlug:slug buildNumber:0 afterNumber:0 eventType:TKEventTypeAny success:success failure:failure];
}

- (void)buildsWithSlug:(NSString *)slug buildNumber:(NSInteger)buildNumber afterNumber:(NSInteger)afterNumber eventType:(TKEventType)eventType success:(void (^)(TKBuildPayload* builds))success failure:(void (^)(NSError* error))failure
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];

    if (buildNumber > 0)
    {
        parameters[@"number"] = @(buildNumber);
    }

    if (afterNumber > 0)
    {
        parameters[@"after_number"] = @(afterNumber);
    }

    if (eventType == TKEventTypePush)
    {
        parameters[@"event_type"] = @"push";
    }

    if (eventType == TKEventTypePullRequest)
    {
        parameters[@"event_type"] = @"pull_request";
    }

    [self.manager GET:[NSString stringWithFormat:@"repos/%@/builds", slug] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSError* error;

        id object = [[TKBuildPayload alloc] initWithDictionary:responseObject error:&error];

        if (!error && success)
        {
            success (object);
        }
        else if (error && failure)
        {
            failure(error);
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failure)
        {
            failure(error);
        }
    }];
}

- (void)buildWithId:(NSInteger)buildId success:(void (^)(TKBuild* build))success failure:(void (^)(NSError* error))failure
{
    [self.manager GET:[NSString stringWithFormat:@"builds/%ld", (long)buildId] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSError* error;

        id object = [[TKBuild alloc] initWithDictionary:responseObject error:&error];

        if (!error && success)
        {
            success (object);
        }
        else if (error && failure)
        {
            failure(error);
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failure)
        {
            failure(error);
        }
    }];
}

- (void)cancelBuildWithId:(NSInteger)buildId success:(void (^)())success failure:(void (^)(NSError* error))failure
{
    [self.manager POST:[NSString stringWithFormat:@"builds/%ld/cancel", (long)buildId] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        if (success)
        {
            success ();
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failure)
        {
            failure(error);
        }
    }];
}

- (void)restartBuildWithId:(NSInteger)buildId success:(void (^)())success failure:(void (^)(NSError* error))failure
{
    [self.manager POST:[NSString stringWithFormat:@"builds/%ld/restart", (long)buildId] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        if (success)
        {
            success ();
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failure)
        {
            failure(error);
        }
    }];
}

#pragma mark Caches

- (void)cachesWithRepositoryId:(NSInteger)repositoryId success:(void (^)(NSArray* caches))success failure:(void (^)(NSError* error))failure
{
    [self cachesWithRepositoryId:repositoryId branch:nil match:nil success:success failure:failure];
}

- (void)cachesWithRepositoryId:(NSInteger)repositoryId branch:(NSString *)branch match:(NSString *)match success:(void (^)(NSArray* caches))success failure:(void (^)(NSError* error))failure
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];

    if ([branch length])
    {
        parameters[@"branch"] = branch;
    }

    if ([match length])
    {
        parameters[@"match"] = match;
    }

    [self.manager GET:[NSString stringWithFormat:@"repos/%ld/caches", (long)repositoryId] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSError* error;

        NSArray* objects = [TKCache arrayOfModelsFromDictionaries:responseObject[@"caches"] error:&error];

        if (!error && success)
        {
            success(objects);
        }
        else if (error && failure)
        {
            failure(error);
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failure)
        {
            failure(error);
        }
    }];
}

- (void)cachesWithSlug:(NSString *)slug success:(void (^)(NSArray* caches))success failure:(void (^)(NSError* error))failure
{
    [self cachesWithSlug:slug branch:nil match:nil success:success failure:failure];
}

- (void)cachesWithSlug:(NSString *)slug branch:(NSString *)branch match:(NSString *)match success:(void (^)(NSArray* caches))success failure:(void (^)(NSError* error))failure
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];

    if ([branch length])
    {
        parameters[@"branch"] = branch;
    }

    if ([match length])
    {
        parameters[@"match"] = match;
    }

    [self.manager GET:[NSString stringWithFormat:@"repos/%@/caches", slug] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSError* error;

        NSArray* objects = [TKCache arrayOfModelsFromDictionaries:responseObject[@"caches"] error:&error];

        if (!error && success)
        {
            success(objects);
        }
        else if (error && failure)
        {
            failure(error);
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failure)
        {
            failure(error);
        }
    }];
}

- (void)deleteCachesWithRepositoryId:(NSInteger)repositoryId success:(void (^)())success failure:(void (^)(NSError* error))failure
{
    [self deleteCachesWithRepositoryId:repositoryId branch:nil match:nil success:success failure:failure];
}

- (void)deleteCachesWithRepositoryId:(NSInteger)repositoryId branch:(NSString *)branch match:(NSString *)match success:(void (^)())success failure:(void (^)(NSError* error))failure
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];

    if ([branch length])
    {
        parameters[@"branch"] = branch;
    }

    if ([match length])
    {
        parameters[@"match"] = match;
    }

    [self.manager DELETE:[NSString stringWithFormat:@"repos/%ld/caches", (long)repositoryId] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        if (success)
        {
            success();
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failure)
        {
            failure(error);
        }
    }];
}

- (void)deleteCachesWithSlug:(NSString *)slug success:(void (^)())success failure:(void (^)(NSError* error))failure
{
    [self deleteCachesWithSlug:slug branch:nil match:nil success:success failure:failure];
}

- (void)deleteCachesWithSlug:(NSString *)slug branch:(NSString *)branch match:(NSString *)match success:(void (^)())success failure:(void (^)(NSError* error))failure
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];

    if ([branch length])
    {
        parameters[@"branch"] = branch;
    }

    if ([match length])
    {
        parameters[@"match"] = match;
    }

    [self.manager DELETE:[NSString stringWithFormat:@"repos/%@/caches", slug] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        if (success)
        {
            success();
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failure)
        {
            failure(error);
        }
    }];
}

#pragma mark Config

- (void)configWithSuccess:(void (^)(TKConfig * config))success failure:(void (^)(NSError* error))failure
{
    [self.manager GET:@"config" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSError* error;

        id object = [[TKConfig alloc] initWithDictionary:responseObject[@"config"] error:&error];

        if (!error && success)
        {
            success (object);
        }
        else if (error && failure)
        {
            failure(error);
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failure)
        {
            failure(error);
        }
    }];
}

#pragma mark Hooks


- (void)hooksWithSuccess:(void (^)(NSArray* hooks))success failure:(void (^)(NSError* error))failure
{
    [self.manager GET:@"hooks" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSError* error;
        
        //
        // Fix array with hooks
        //
        
        NSArray* hooks = [self hooksFixActiveInArray:responseObject[@"hooks"]];
        
        NSArray* objects = [TKHook arrayOfModelsFromDictionaries:hooks error:&error];

        if (!error && success)
        {
            success(objects);
        }
        else if (error && failure)
        {
            failure(error);
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failure)
        {
            failure(error);
        }
    }];
}

/**
 *  Method returns a new array of uninitialized hooks that fixes issue when API 
 *  returns "<null>" string instead of a BOOL value for "active" field.
 *
 *  @param hooks property list of hooks
 *
 *  @return array of hooks with active value fixed
 */
- (NSArray *)hooksFixActiveInArray:(NSArray *)hooks
{
    NSMutableArray* hooksArray = [NSMutableArray array];
    
    for (NSDictionary* hook in hooks)
    {
        NSMutableDictionary* hookFix = [hook mutableCopy];
        
        if ([hookFix[@"active"] isKindOfClass:[NSNull class]])
        {
            hookFix[@"active"] = @NO;
        }
        else
        {
            hookFix[@"active"] = @YES;
        }
        
        [hooksArray addObject:hookFix];
    }

    return [hooksArray copy];
}


- (void)updateHook:(TKHook *)hook success:(void (^)())success failure:(void (^)(NSError* error))failure
{
    [self.manager GET:@"hooks" parameters:@{ @"hook" : [hook toDictionary] } success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        if (success)
        {
            success();
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failure)
        {
            failure(error);
        }
    }];
}

#pragma mark Jobs

- (void)jobsWithIds:(NSArray *)ids success:(void (^)(NSArray* jobs))success failure:(void (^)(NSError* error))failure
{
    [self.manager GET:@"jobs" parameters:@{ @"ids" : ids } success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSError* error;

        NSArray* objects = [TKJob arrayOfModelsFromDictionaries:responseObject[@"jobs"] error:&error];

        if (!error && success)
        {
            success(objects);
        }
        else if (error && failure)
        {
            failure(error);
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failure)
        {
            failure(error);
        }
    }];
}

- (void)jobsWithState:(NSString *)state success:(void (^)(NSArray* jobs))success failure:(void (^)(NSError* error))failure
{
    [self.manager GET:@"jobs" parameters:@{ @"state" : state } success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSError* error;

        NSArray* objects = [TKJob arrayOfModelsFromDictionaries:responseObject[@"jobs"] error:&error];

        if (!error && success)
        {
            success(objects);
        }
        else if (error && failure)
        {
            failure(error);
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failure)
        {
            failure(error);
        }
    }];
}

- (void)jobsWithQueue:(NSString *)queue success:(void (^)(NSArray* jobs))success failure:(void (^)(NSError* error))failure
{
    [self.manager GET:@"jobs" parameters:@{ @"queue" : queue } success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSError* error;

        NSArray* objects = [TKJob arrayOfModelsFromDictionaries:responseObject[@"jobs"] error:&error];

        if (!error && success)
        {
            success(objects);
        }
        else if (error && failure)
        {
            failure(error);
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failure)
        {
            failure(error);
        }
    }];
}

- (void)jobWithId:(NSInteger)jobId success:(void (^)(TKJob* job))success failure:(void (^)(NSError* error))failure
{
    [self.manager GET:[NSString stringWithFormat:@"jobs/%ld", (long)jobId] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSError* error;

        id object = [[TKJob alloc] initWithDictionary:responseObject error:&error];

        if (!error && success)
        {
            success (object);
        }
        else if (error && failure)
        {
            failure(error);
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failure)
        {
            failure(error);
        }
    }];
}

- (void)cancelJobWithId:(NSInteger)jobId success:(void (^)())success failure:(void (^)(NSError* error))failure
{
    [self.manager POST:[NSString stringWithFormat:@"jobs/%ld/cancel", (long)jobId] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        if (success)
        {
            success ();
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failure)
        {
            failure(error);
        }
    }];
}

- (void)restartJobWithId:(NSInteger)jobId success:(void (^)())success failure:(void (^)(NSError* error))failure
{
    [self.manager POST:[NSString stringWithFormat:@"jobs/%ld/restart", (long)jobId] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        if (success)
        {
            success ();
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failure)
        {
            failure(error);
        }
    }];
}

#pragma mark Logs

- (void)logWithId:(NSInteger)logId success:(void (^)(TKLog* log))success failure:(void (^)(NSError* error))failure
{
    [self.manager GET:[NSString stringWithFormat:@"logs/%ld", (long)logId] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSError* error;

        id object = [[TKLog alloc] initWithDictionary:responseObject error:&error];

        if (!error && success)
        {
            success (object);
        }
        else if (error && failure)
        {
            failure(error);
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failure)
        {
            failure(error);
        }
    }];
}

#pragma mark Permissions

- (void)permissionsWithSuccess:(void (^)(TKPermissions* permissions))success failure:(void (^)(NSError* error))failure
{
    [self.manager GET:@"users/permissions" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSError* error;

        id object = [[TKPermissions alloc] initWithDictionary:responseObject error:&error];

        if (!error && success)
        {
            success (object);
        }
        else if (error && failure)
        {
            failure(error);
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failure)
        {
            failure(error);
        }
    }];
}

#pragma mark Repositories

- (void)recentRepositoriesWithSuccess:(void (^)(NSArray* repositories))success failure:(void (^)(NSError* error))failure
{
    [self.manager GET:@"repos" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSError* error;

        NSArray* objects = [TKRepository arrayOfModelsFromDictionaries:responseObject[@"repos"] error:&error];

        if (!error && success)
        {
            success(objects);
        }
        else if (error && failure)
        {
            failure(error);
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failure)
        {
            failure(error);
        }
    }];
}

- (void)repositoriesWithIds:(NSArray *)ids success:(void (^)(NSArray* repositories))success failure:(void (^)(NSError* error))failure
{
    [self.manager GET:@"repos" parameters:@{ @"ids" : ids } success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSError* error;

        NSArray* objects = [TKRepository arrayOfModelsFromDictionaries:responseObject[@"repos"] error:&error];

        if (!error && success)
        {
            success(objects);
        }
        else if (error && failure)
        {
            failure(error);
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failure)
        {
            failure(error);
        }
    }];
}

- (void)searchRepositoriesByTerm:(NSString *)term member:(NSString *)member ownerName:(NSString *)ownerName slug:(NSString *)slug active:(BOOL)active success:(void (^)(NSArray* repositories))success failure:(void (^)(NSError* error))failure
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];

    if ([term length])
    {
        parameters[@"search"] = term;
    }

    if ([member length])
    {
        parameters[@"member"] = member;
    }

    if ([ownerName length])
    {
        parameters[@"owner_name"] = ownerName;
    }

    if ([slug length])
    {
        parameters[@"slug"] = slug;
    }

    if (active)
    {
        parameters[@"active"] = @YES;
    }

    [self.manager GET:@"repos" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSError* error;

        NSArray* objects = [TKRepository arrayOfModelsFromDictionaries:responseObject[@"repos"] error:&error];

        if (!error && success)
        {
            success(objects);
        }
        else if (error && failure)
        {
            failure(error);
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failure)
        {
            failure(error);
        }
    }];
}

- (void)repositoryWithId:(NSInteger)repositoryId success:(void (^)(TKRepository* repository))success failure:(void (^)(NSError* error))failure
{
    [self.manager GET:[NSString stringWithFormat:@"repos/%ld", (long)repositoryId] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSError* error;

        id object = [[TKRepository alloc] initWithDictionary:responseObject[@"repo"] error:&error];

        if (!error && success)
        {
            success (object);
        }
        else if (error && failure)
        {
            failure(error);
        }
    }
     failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failure)
        {
            failure(error);
        }
    }];
}

- (void)repositoryWithSlug:(NSString *)slug success:(void (^)(TKRepository* repository))success failure:(void (^)(NSError* error))failure
{
    [self.manager GET:[NSString stringWithFormat:@"repos/%@", slug] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSError* error;

        id object = [[TKRepository alloc] initWithDictionary:responseObject[@"repo"] error:&error];

        if (!error && success)
        {
            success (object);
        }
        else if (error && failure)
        {
            failure(error);
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failure)
        {
            failure(error);
        }
    }];
}

#pragma mark Repository Keys

- (void)repositoryKeyWithId:(NSInteger)repositoryId success:(void (^)(TKRepositoryKey* repositoryKey))success failure:(void (^)(NSError* error))failure
{
    [self.manager GET:[NSString stringWithFormat:@"repos/%ld/key", (long)repositoryId] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSError* error;

        id object = [[TKRepositoryKey alloc] initWithDictionary:responseObject error:&error];

        if (!error && success)
        {
            success (object);
        }
        else if (error && failure)
        {
            failure(error);
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failure)
        {
            failure(error);
        }
    }];
}

- (void)repositoryKeyWithSlug:(NSString *)slug success:(void (^)(TKRepositoryKey* repositoryKey))success failure:(void (^)(NSError* error))failure
{
    [self.manager GET:[NSString stringWithFormat:@"repos/%@/key", slug] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSError* error;

        id object = [[TKRepositoryKey alloc] initWithDictionary:responseObject error:&error];

        if (!error && success)
        {
            success (object);
        }
        else if (error && failure)
        {
            failure(error);
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failure)
        {
            failure(error);
        }
    }];
}

- (void)invalidateRepositoryKeyWithId:(NSInteger)repositoryId success:(void (^)())success failure:(void (^)(NSError* error))failure
{
    [self.manager POST:[NSString stringWithFormat:@"repos/%ld/key", (long)repositoryId] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        if (success)
        {
            success();
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failure)
        {
            failure(error);
        }
    }];
}

- (void)invalidateRepositoryKeyWithSlug:(NSString *)slug success:(void (^)())success failure:(void (^)(NSError* error))failure
{
    [self.manager POST:[NSString stringWithFormat:@"repos/%@/key", slug] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        if (success)
        {
            success();
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failure)
        {
            failure(error);
        }
    }];
}

#pragma mark Requests

- (void)requestsWithRepositoryId:(NSInteger)repositoryId success:(void (^)(NSArray* requests))success failure:(void (^)(NSError* error))failure
{
    [self requestsWithRepositoryId:repositoryId limit:0 olderThan:0 success:success failure:failure];
}

- (void)requestsWithRepositoryId:(NSInteger)repositoryId limit:(NSInteger)limit olderThan:(NSInteger)olderThanId success:(void (^)(NSArray* requests))success failure:(void (^)(NSError* error))failure
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];

    parameters[@"repository_id"] = @(repositoryId);

    if (limit > 0)
    {
        parameters[@"limit"] = @(limit);
    }

    if (olderThanId > 0)
    {
        parameters[@"older_than"] = @(olderThanId);
    }

    [self.manager GET:@"requests" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSError* error;

        NSArray* objects = [TKRequest arrayOfModelsFromDictionaries:responseObject[@"requests"] error:&error];

        if (!error && success)
        {
            success(objects);
        }
        else if (error && failure)
        {
            failure(error);
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failure)
        {
            failure(error);
        }
    }];
}

- (void)requestsWithSlug:(NSString *)slug success:(void (^)(NSArray* requests))success failure:(void (^)(NSError* error))failure
{
    [self requestsWithSlug:slug limit:0 olderThan:0 success:success failure:failure];
}

- (void)requestsWithSlug:(NSString *)slug limit:(NSInteger)limit olderThan:(NSInteger)olderThanId success:(void (^)(NSArray* requests))success failure:(void (^)(NSError* error))failure
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];

    parameters[@"slug"] = slug;

    if (limit > 0)
    {
        parameters[@"limit"] = @(limit);
    }

    if (olderThanId > 0)
    {
        parameters[@"older_than"] = @(olderThanId);
    }

    [self.manager GET:@"requests" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSError* error;

        NSArray* objects = [TKRequest arrayOfModelsFromDictionaries:responseObject[@"requests"] error:&error];

        if (!error && success)
        {
            success(objects);
        }
        else if (error && failure)
        {
            failure(error);
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failure)
        {
            failure(error);
        }
    }];
}

- (void)requestWithId:(NSInteger)requestId success:(void (^)(TKRequestPayload* requestPayload))success failure:(void (^)(NSError* error))failure
{
    [self.manager GET:[NSString stringWithFormat:@"requests/%ld", (long)requestId] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSError* error;

        id object = [[TKRequestPayload alloc] initWithDictionary:responseObject error:&error];

        if (!error && success)
        {
            success (object);
        }
        else if (error && failure)
        {
            failure(error);
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failure)
        {
            failure(error);
        }
    }];
}

#pragma mark Settings

- (void)settingsForRepositoryId:(NSInteger)repositoryId success:(void (^)(TKSettings* settings))success failure:(void (^)(NSError* error))failure
{
    [self.manager GET:[NSString stringWithFormat:@"repos/%ld/settings", (long)repositoryId] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSError* error;

        id object = [[TKSettings alloc] initWithDictionary:responseObject[@"settings"] error:&error];

        if (!error && success)
        {
            success (object);
        }
        else if (error && failure)
        {
            failure(error);
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failure)
        {
            failure(error);
        }
    }];
}

- (void)updateSettings:(TKSettings *)settings forRepositoryId:(NSInteger)repositoryId success:(void (^)())success failure:(void (^)(NSError* error))failure;
{
    [self.manager PATCH:[NSString stringWithFormat:@"repos/%ld/settings", (long)repositoryId] parameters:@{ @"settings" : [settings toDictionary] } success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        if (success)
        {
            success ();
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failure)
        {
            failure(error);
        }
    }];
}

#pragma mark Users

- (void)usersWithSuccess:(void (^)(NSArray* users))success failure:(void (^)(NSError* error))failure
{
    [self.manager GET:@"users" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSError* error;

        NSArray* objects = [TKUser arrayOfModelsFromDictionaries:responseObject[@"users"] error:&error];

        if (!error && success)
        {
            success(objects);
        }
        else if (error && failure)
        {
            failure(error);
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failure)
        {
            failure(error);
        }
    }];
}

- (void)userWithId:(NSInteger)userId success:(void (^)(TKUser* user))success failure:(void (^)(NSError* error))failure
{
    [self.manager GET:[NSString stringWithFormat:@"users/%ld", (long)userId] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSError* error;

        id object = [[TKUser alloc] initWithDictionary:responseObject[@"user"] error:&error];

        if (!error && success)
        {
            success (object);
        }
        else if (error && failure)
        {
            failure(error);
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failure)
        {
            failure(error);
        }
    }];
}

- (void)userTriggerSyncWithSuccess:(void (^)())success failure:(void (^)(NSError* error))failure
{
    [self.manager POST:@"users/sync" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        if (!success)
        {
            success();
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failure)
        {
            failure(error);
        }
    }];
}

@end
