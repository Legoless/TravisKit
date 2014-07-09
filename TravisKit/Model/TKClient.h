//
//  TKClient.h
//  TravisKit
//
//  Created by Dal Rupnik on 17/06/14.
//  Copyright (c) 2014 arvystate.net. All rights reserved.
//
#import "TKDefines.h"

#import "TKAccount.h"
#import "TKAnnotation.h"
#import "TKBranch.h"
#import "TKBroadcast.h"
#import "TKBuild.h"
#import "TKBuildPayload.h"
#import "TKCache.h"
#import "TKConfig.h"
#import "TKLog.h"
#import "TKPermissions.h"
#import "TKRepository.h"
#import "TKRequest.h"
#import "TKRequestPayload.h"
#import "TKUser.h"
#import "TKRepositoryKey.h"
#import "TKHook.h"
#import "TKSettings.h"

extern NSString* const TKOpenSourceServer;
extern NSString* const TKPrivateServer;

/*!
 * TravisKit client, wraps Travis CI API
 */
@interface TKClient : NSObject

/*!
 * Travis CI API access token
 */
@property (nonatomic, strong) NSString* accessToken;

/*!
 * YES when successfully authenticated
 */
@property (nonatomic, readonly) BOOL isAuthenticated;

/*!
 * Creates and initializes new Travis CI client with specified server
 */
+ (instancetype)clientWithServer:(NSString *)server;

/*!
 * Designated initializer
 */
- (id)initWithServer:(NSString *)server;

/*!
 * Authenticates Travis API with GitHub token, required for certain, user based requests
 */
- (void)authenticateWithGitHubToken:(NSString *)token success:(void (^)())success failure:(void (^)(NSError* error))failure;

/*!
 * Returns accounts available on Travis
 */
- (void)accountsWithSuccess:(void (^)(NSArray* accounts))success failure:(void (^)(NSError* error))failure;

/*!
 * Returns accounts filtered by admin parameter
 */
- (void)accountsWithAdmin:(BOOL)admin success:(void (^)(NSArray* accounts))success failure:(void (^)(NSError* error))failure;

/*!
 * Returns annotations for specific job
 */
- (void)annotationsWithJobId:(NSInteger)jobId success:(void (^)(NSArray* annotations))success failure:(void (^)(NSError* error))failure;

/*!
 * Creates new annotation for specific job
 */
- (void)createAnnotation:(TKAnnotation *)annotation withJobId:(NSInteger)jobId success:(void (^)())success failure:(void (^)(NSError* error))failure;

/*!
 * Returns branches for repository by ID
 */
- (void)branchesWithRepositoryId:(NSInteger)repositoryId success:(void (^)(NSArray* branches))success failure:(void (^)(NSError* error))failure;

/*!
 * Returns branches with repository slug
 */
- (void)branchesWithSlug:(NSString *)slug success:(void (^)(NSArray* branches))success failure:(void (^)(NSError* error))failure;

/*!
 * Returns system wide broadcasts
 */
- (void)broadcastsWithSuccess:(void (^)(NSArray* broadcasts))success failure:(void (^)(NSError* error))failure;

/*!
 * Returns builds for repository IDs
 */
- (void)buildsWithIds:(NSArray *)ids success:(void (^)(TKBuildPayload* builds))success failure:(void (^)(NSError* error))failure;

/*!
 * Returns builds for repository IDs filtered by event type
 */
- (void)buildsWithIds:(NSArray *)ids eventType:(TKEventType)eventType success:(void (^)(TKBuildPayload* builds))success failure:(void (^)(NSError* error))failure;

/*!
 * Returns builds for repository
 */
- (void)buildsWithRepositoryId:(NSInteger)repositoryId success:(void (^)(TKBuildPayload* builds))success failure:(void (^)(NSError* error))failure;

/*!
 * Returns builds for repository filtered by build number and event type
 */
- (void)buildsWithRepositoryId:(NSInteger)repositoryId buildNumber:(NSInteger)buildNumber afterNumber:(NSInteger)afterNumber eventType:(TKEventType)eventType success:(void (^)(TKBuildPayload* builds))success failure:(void (^)(NSError* error))failure;

/*!
 * Returns builds for repository with slug
 */
- (void)buildsWithSlug:(NSString *)slug success:(void (^)(TKBuildPayload* builds))success failure:(void (^)(NSError* error))failure;

/*!
 * Returns builds for repository with slug filtered by build number and event type
 */
- (void)buildsWithSlug:(NSString *)slug buildNumber:(NSInteger)buildNumber afterNumber:(NSInteger)afterNumber eventType:(TKEventType)eventType success:(void (^)(TKBuildPayload* builds))success failure:(void (^)(NSError* error))failure;

/*!
 * Returns specific build
 */
- (void)buildWithId:(NSInteger)buildId success:(void (^)(TKBuild* build))success failure:(void (^)(NSError* error))failure;

/*!
 * Cancels currently running build
 */
- (void)cancelBuildWithId:(NSInteger)buildId success:(void (^)())success failure:(void (^)(NSError* error))failure;

/*!
 * Restarts specific build
 */
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
// Config
//

- (void)configWithSuccess:(void (^)(TKConfig * config))success failure:(void (^)(NSError* error))failure;

//
// Hooks
//

- (void)hooksWithSuccess:(void (^)(NSArray* hooks))success failure:(void (^)(NSError* error))failure;
- (void)updateHook:(TKHook *)hook success:(void (^)())success failure:(void (^)(NSError* error))failure;

//
// Jobs
//

- (void)jobsWithIds:(NSArray *)ids success:(void (^)(NSArray* jobs))success failure:(void (^)(NSError* error))failure;
- (void)jobsWithState:(NSString *)state success:(void (^)(NSArray* jobs))success failure:(void (^)(NSError* error))failure;
- (void)jobsWithQueue:(NSString *)queue success:(void (^)(NSArray* jobs))success failure:(void (^)(NSError* error))failure;

- (void)jobWithId:(NSInteger)jobId success:(void (^)(TKJob* job))success failure:(void (^)(NSError* error))failure;
- (void)cancelJobWithId:(NSInteger)jobId success:(void (^)())success failure:(void (^)(NSError* error))failure;
- (void)restartJobWithId:(NSInteger)jobId success:(void (^)())success failure:(void (^)(NSError* error))failure;

//
// Logs
//

- (void)logWithId:(NSInteger)logId success:(void (^)(TKLog* log))success failure:(void (^)(NSError* error))failure;

//
// Permissions
//

- (void)permissionsWithSuccess:(void (^)(TKPermissions* permissions))success failure:(void (^)(NSError* error))failure;

//
// Repositories
//

- (void)recentRepositoriesWithSuccess:(void (^)(NSArray* repositories))success failure:(void (^)(NSError* error))failure;

- (void)repositoriesWithIds:(NSArray *)ids success:(void (^)(NSArray* repositories))success failure:(void (^)(NSError* error))failure;
- (void)searchRepositoriesByTerm:(NSString *)term member:(NSString *)member ownerName:(NSString *)ownerName slug:(NSString *)slug active:(BOOL)active success:(void (^)(NSArray* repositories))success failure:(void (^)(NSError* error))failure;

- (void)repositoryWithId:(NSInteger)repositoryId success:(void (^)(TKRepository* repository))success failure:(void (^)(NSError* error))failure;
- (void)repositoryWithSlug:(NSString *)slug success:(void (^)(TKRepository* repository))success failure:(void (^)(NSError* error))failure;

//
// Repository keys
//

- (void)repositoryKeyWithId:(NSInteger)repositoryId success:(void (^)(TKRepositoryKey* repositoryKey))success failure:(void (^)(NSError* error))failure;
- (void)repositoryKeyWithSlug:(NSString *)slug success:(void (^)(TKRepositoryKey* repositoryKey))success failure:(void (^)(NSError* error))failure;

- (void)invalidateRepositoryKeyWithId:(NSInteger)repositoryId success:(void (^)())success failure:(void (^)(NSError* error))failure;
- (void)invalidateRepositoryKeyWithSlug:(NSString *)slug success:(void (^)())success failure:(void (^)(NSError* error))failure;

//
// Requests
//

- (void)requestsWithRepositoryId:(NSInteger)repositoryId success:(void (^)(NSArray* requests))success failure:(void (^)(NSError* error))failure;
- (void)requestsWithRepositoryId:(NSInteger)repositoryId limit:(NSInteger)limit olderThan:(NSInteger)olderThanId success:(void (^)(NSArray* requests))success failure:(void (^)(NSError* error))failure;

- (void)requestsWithSlug:(NSString *)slug success:(void (^)(NSArray* requests))success failure:(void (^)(NSError* error))failure;
- (void)requestsWithSlug:(NSString *)slug limit:(NSInteger)limit olderThan:(NSInteger)olderThanId success:(void (^)(NSArray* requests))success failure:(void (^)(NSError* error))failure;

- (void)requestWithId:(NSInteger)requestId success:(void (^)(TKRequestPayload* requestPayload))success failure:(void (^)(NSError* error))failure;

//
// Settings
//

- (void)settingsForRepositoryId:(NSInteger)repositoryId success:(void (^)(TKSettings* settings))success failure:(void (^)(NSError* error))failure;
- (void)updateSettings:(TKSettings *)settings forRepositoryId:(NSInteger)repositoryId success:(void (^)())success failure:(void (^)(NSError* error))failure;

//
// Users
//

- (void)usersWithSuccess:(void (^)(NSArray* users))success failure:(void (^)(NSError* error))failure;
- (void)userWithId:(NSInteger)userId success:(void (^)(TKUser* user))success failure:(void (^)(NSError* error))failure;
- (void)userTriggerSyncWithSuccess:(void (^)())success failure:(void (^)(NSError* error))failure;

@end

/*!
 * Wraps methods above with objects
 */
@interface TKClient (TravisObjects)

@end
