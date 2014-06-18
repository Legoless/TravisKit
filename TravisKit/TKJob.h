//
//  TKJob.h
//  Pods
//
//  Created by Dal Rupnik on 18/06/14.
//
//

#import "JSONModel.h"

@protocol TKJob <NSObject>

@end

@interface TKJob : JSONModel

@property (nonatomic) NSInteger id;
@property (nonatomic) NSInteger build_id;
@property (nonatomic) NSInteger repository_id;
@property (nonatomic) NSInteger commit_id;
@property (nonatomic) NSInteger log_id;
@property (nonatomic, strong) NSString* number;
@property (nonatomic, strong) NSDictionary<Optional>* config;
@property (nonatomic, strong) NSString* state;
@property (nonatomic, strong) NSDate* started_at;
@property (nonatomic, strong) NSDate* finished_at;
@property (nonatomic, strong) NSNumber<Optional>* duration;
@property (nonatomic, strong) NSArray<Optional>* annotation_ids;

//
// Unknown types
//

@property (nonatomic) BOOL allow_failure;
@property (nonatomic, strong) NSString* queue;

@end
