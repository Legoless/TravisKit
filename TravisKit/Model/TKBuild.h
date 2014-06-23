//
//  TKBuild.h
//  Pods
//
//  Created by Dal Rupnik on 18/06/14.
//
//

#import "JSONModel.h"

@protocol TKBuild <NSObject>

@end

@interface TKBuild : JSONModel

@property (nonatomic) NSInteger id;
@property (nonatomic) NSInteger repository_id;
@property (nonatomic) NSInteger commit_id;
@property (nonatomic, strong) NSString* number;
@property (nonatomic) BOOL pull_request;
@property (nonatomic, strong) NSString<Optional>* pull_request_title;
@property (nonatomic, strong) NSNumber<Optional>* pull_request_number;
@property (nonatomic, strong) NSDictionary<Optional>* config;
@property (nonatomic, strong) NSString* state;
@property (nonatomic, strong) NSDate* started_at;
@property (nonatomic, strong) NSDate* finished_at;
@property (nonatomic, strong) NSNumber<Optional>* duration;

/*!
 * Array of NSNumbers that have job_ids
 */
@property (nonatomic, strong) NSArray<Optional>* job_ids;

@end
