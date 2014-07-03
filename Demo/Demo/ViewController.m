//
//  ViewController.m
//  Demo
//
//  Created by Dal Rupnik on 17/06/14.
//  Copyright (c) 2014 arvystate.net. All rights reserved.
//

#import <TravisKit/TravisKit.h>

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) TKClient* client;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.client = [[TKClient alloc] initWithServer:TKPrivateServer];
    
    [self.client authenticateWithGitHubToken:@"<GITHUB_TOKEN>" success:^
    {
        NSLog(@"SUCCESS!");
        
        [self testTravisData];
    }
    failure:^(NSError *error)
    {
        NSLog(@"ERROR: %@", error);
    }];
}

- (void)testTravisData
{
    //
    // Accounts
    //
    [self.client accountsWithSuccess:^(NSArray *accounts)
    {
        NSLog(@"Accounts: %@", accounts);
    }
    failure:^(NSError *error)
    {
        NSLog(@"Accounts error: %@", error);
    }];
    
    //
    // Broadcasts
    //
    
    [self.client broadcastsWithSuccess:^(NSArray *broadcasts)
    {
        NSLog(@"Broadcasts: %@", broadcasts);
    }
    failure:^(NSError *error)
    {
        NSLog(@"Broadcasts error: %@", error);
    }];
    
    //
    // Config
    //
    
    [self.client configWithSuccess:^(TKConfig *config)
    {
        NSLog(@"Config: %@", config);
    }
    failure:^(NSError *error)
    {
        NSLog(@"Config error: %@", error);
    }];
    
    //
    // Hooks
    //
    
    [self.client hooksWithSuccess:^(NSArray *hooks)
    {
        NSLog(@"Hooks: %@", hooks);
    }
    failure:^(NSError *error)
    {
        NSLog(@"Hooks error: %@", error);
    }];
    
    //
    // Permissions
    //
    
    [self.client permissionsWithSuccess:^(TKPermissions *permissions)
    {
        NSLog(@"Permissions: %@", permissions);
    }
    failure:^(NSError *error)
    {
        NSLog(@"Permissions error: %@", error);
    }];
    
    //
    // Repositories
    //
    
    [self.client recentRepositoriesWithSuccess:^(NSArray *repositories)
    {
        NSLog(@"Repositories: %@", repositories);
        
        TKRepository* repository = [repositories firstObject];
        
        //
        // Builds, jobs, commits
        //
        
        [self.client buildsWithSlug:repository.slug success:^(TKBuildPayload *builds)
        {
            NSLog(@"Builds: %@", builds);
        }
        failure:^(NSError *error)
        {
            NSLog(@"Builds error: %@", error);
        }];
        
        //
        // Branches
        //
        
        [self.client branchesWithSlug:repository.slug success:^(NSArray *branches)
        {
            NSLog(@"Branches: %@", branches);
        }
        failure:^(NSError *error)
        {
            NSLog(@"Branches error: %@", error);
        }];
        
        //
        // Caches
        //
        
        [self.client cachesWithSlug:repository.slug success:^(NSArray *caches)
        {
            NSLog(@"Caches: %@", caches);
        }
        failure:^(NSError *error)
        {
            NSLog(@"Caches error: %@", error);
        }];
        
        //
        // Repository keys
        //
        
        [self.client repositoryKeyWithSlug:repository.slug success:^(TKRepositoryKey *repositoryKey)
        {
            NSLog(@"Repository key: %@", repositoryKey);
        }
        failure:^(NSError *error)
        {
            NSLog(@"Repository key error: %@", error);
        }];
        
        //
        // Requests
        //
        
        [self.client requestsWithSlug:repository.slug success:^(NSArray *requests)
        {
            NSLog(@"Requests: %@", requests);
        }
        failure:^(NSError *error)
        {
            NSLog(@"Requests error: %@", error);
        }];
    
        //
        // Settings
        //
        
        [self.client settingsForRepositoryId:repository.id success:^(TKSettings *settings)
        {
            NSLog(@"Settings: %@", settings);
        }
        failure:^(NSError *error)
        {
            NSLog(@"Settings error: %@", error);
        }];
    }
    failure:^(NSError *error)
    {
        NSLog(@"Repositories error: %@", error);
    }];
    
    //
    // Users
    //
    
    [self.client usersWithSuccess:^(NSArray *users)
    {
        NSLog(@"Users: %@", users);
    }
    failure:^(NSError *error)
    {
        NSLog(@"Users error: %@", error);
    }];
}

@end
