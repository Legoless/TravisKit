//
//  TKClient.h
//  TravisKit
//
//  Created by Dal Rupnik on 17/06/14.
//  Copyright (c) 2014 arvystate.net. All rights reserved.
//

#import "TKBuildPayload.h"
#import "TKLog.h"
#import "TKPermissions.h"
#import "TKRepository.h"
#import "TKDefines.h"
#import "TKRequest.h"
#import "TKUser.h"
#import "TKSettings.h"

extern NSString* const TKOpenSourceServer;
extern NSString* const TKPrivateServer;

@interface TKClient : NSObject

@property (nonatomic, readonly) BOOL isAuthenticated;

//
// Initialize
//

- (id)initWithServer:(NSString *)server;

//
// Authenticate
//

- (void)authenticateWithGitHubToken:(NSString *)token success:(void (^)())success failure:(void (^)(NSError* error))failure;

//
// Accounts
//

- (void)accountsWithSuccess:(void (^)(NSArray* accounts))success failure:(void (^)(NSError* error))failure;

- (void)accountsWithAdmin:(BOOL)admin success:(void (^)(NSArray* accounts))success failure:(void (^)(NSError* error))failure;

//
// Builds
//
- (void)buildsWithIds:(NSArray *)ids success:(void (^)(TKBuildPayload* builds))success failure:(void (^)(NSError* error))failure;
- (void)buildsWithIds:(NSArray *)ids eventType:(TKEventType)eventType success:(void (^)(TKBuildPayload* builds))success failure:(void (^)(NSError* error))failure;

- (void)buildsWithRepositoryId:(NSInteger)repositoryId success:(void (^)(TKBuildPayload* builds))success failure:(void (^)(NSError* error))failure;
- (void)buildsWithRepositoryId:(NSInteger)repositoryId buildNumber:(NSInteger)buildNumber afterNumber:(NSInteger)afterNumber success:(void (^)(TKBuildPayload* builds))success failure:(void (^)(NSError* error))failure;

- (void)buildsWithSlug:(NSString *)slug success:(void (^)(TKBuildPayload* builds))success failure:(void (^)(NSError* error))failure;
- (void)buildsWithSlug:(NSString *)slug buildNumber:(NSInteger)buildNumber afterNumber:(NSInteger)afterNumber success:(void (^)(TKBuildPayload* builds))success failure:(void (^)(NSError* error))failure;

- (void)buildWithId:(NSInteger)buildId success:(void (^)(TKBuild* build))success failure:(void (^)(NSError* error))failure;

- (void)cancelBuildWithId:(NSInteger)buildId success:(void (^)())success failure:(void (^)(NSError* error))failure;
- (void)restartBuildWithId:(NSInteger)buildId success:(void (^)())success failure:(void (^)(NSError* error))failure;

//
// Caches
//

- (void)cachesWithRepositoryId:(NSInteger)repositoryId success:(void (^)(NSArray* caches))success failure:(void (^)(NSError* error))failure;
- (void)cachesWithRepositoryId:(NSInteger)repositoryId branch:(NSString *)branch match:(NSString *)match success:(void (^)(NSArray* caches))success failure:(void (^)(NSError* error))failure;

- (void)cachesWithSlug:(NSString *)slug success:(void (^)(NSArray* caches))success failure:(void (^)(NSError* error))failure;
- (void)cachesWithSlug:(NSString *)slug branch:(NSString *)branch match:(NSString *)match success:(void (^)(NSArray* caches))success failure:(void (^)(NSError* error))failure;

- (void)deleteCachesWithRepositoryId:(NSInteger)repositoryId success:(void (^)())success failure:(void (^)(NSError* error))failure;
- (void)deleteCachesWithRepositoryId:(NSInteger)repositoryId branch:(NSString *)branch match:(NSString *)match success:(void (^)())success failure:(void (^)(NSError* error))failure;

- (void)deleteCachesWithSlug:(NSString *)slug success:(void (^)())success failure:(void (^)(NSError* error))failure;
- (void)deleteCachesWithSlug:(NSString *)slug branch:(NSString *)branch match:(NSString *)match success:(void (^)())success failure:(void (^)(NSError* error))failure;

//
// Hooks
//

//
// Jobs
//

- (void)jobWithId:(NSInteger)jobId success:(void (^)(TKJob* job))success failure:(void (^)(NSError* error))failure;
- (void)cancelJobWithId:(NSInteger)jobId success:(void (^)())success failure:(void (^)(NSError* error))failure;
- (void)restartJobWithId:(NSInteger)jobId success:(void (^)())success failure:(void (^)(NSError* error))failure;

//
// Logs
//

- (void)logWithJobId:(NSInteger)jobId success:(void (^)(NSString* log))success failure:(void (^)(NSError* error))failure;
- (void)logWithId:(NSInteger)logId success:(void (^)(TKLog* log))success failure:(void (^)(NSError* error))failure;
//- (void)subscribeToLogWithId:(NSInteger)jobId;

//
// Permissions
//

- (void)permissionsWithSuccess:(void (^)(TKPermissions* log))success failure:(void (^)(NSError* error))failure;

//
// Repositories
//

- (void)repositoriesWithIds:(NSArray *)ids success:(void (^)(NSArray* repositories))success failure:(void (^)(NSError* error))failure;
- (void)searchRepositoriesByTerm:(NSString *)term member:(NSString *)member ownerName:(NSString *)ownerName slug:(NSString *)slug active:(BOOL)active success:(void (^)(NSArray* repositories))success failure:(void (^)(NSError* error))failure;

- (void)repositoryWithId:(NSInteger)repositoryId success:(void (^)(TKRepository* repository))success failure:(void (^)(NSError* error))failure;
- (void)repositoryWithSlug:(NSString *)slug success:(void (^)(TKRepository* repository))success failure:(void (^)(NSError* error))failure;

//
// Requests
//

- (void)requestsWithRepositoryId:(NSInteger)repositoryId success:(void (^)(NSArray* requests))success failure:(void (^)(NSError* error))failure;
- (void)requestsWithRepositoryId:(NSInteger)repositoryId limit:(NSInteger)limit olderThan:(NSDate *)olderThan success:(void (^)(NSArray* requests))success failure:(void (^)(NSError* error))failure;

- (void)requestsWithSlug:(NSString *)slug success:(void (^)(NSArray* requests))success failure:(void (^)(NSError* error))failure;
- (void)requestsWithSlug:(NSString *)slug limit:(NSInteger)limit olderThan:(NSDate *)olderThan success:(void (^)(NSArray* requests))success failure:(void (^)(NSError* error))failure;

- (void)requestWithId:(NSInteger)requestId success:(void (^)(TKRequest* request))success failure:(void (^)(NSError* error))failure;

//
// Settings
//

- (void)settingsForRepositoryId:(NSInteger)repositoryId success:(void (^)(TKSettings* settings))success failure:(void (^)(NSError* error))failure;
- (void)updateSettingsForRepositoryId:(NSInteger)repositoryId settings:(TKSettings *)settings success:(void (^)())success failure:(void (^)(NSError* error))failure;

//
// Users
//

- (void)usersWithSuccess:(void (^)(NSArray* users))success failure:(void (^)(NSError* error))failure;
- (void)userWithId:(NSInteger)userId success:(void (^)(TKUser* user))success failure:(void (^)(NSError* error))failure;
- (void)userTriggerSyncWithSuccess:(void (^)())success failure:(void (^)(NSError* error))failure;

@end
