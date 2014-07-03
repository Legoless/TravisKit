//
//  TKBuildPayload.h
//  Pods
//
//  Created by Dal Rupnik on 18/06/14.
//
//

#import "JSONModel.h"

#import "TKBuild.h"
#import "TKJob.h"
#import "TKCommit.h"

@interface TKBuildPayload : JSONModel

@property (nonatomic, strong) NSArray<TKBuild, Optional>* builds;
@property (nonatomic, strong) NSArray<TKJob, Optional>* jobs;
@property (nonatomic, strong) NSArray<TKCommit, Optional>* commits;

@end
