//
//  TKRepository.h
//  Pods
//
//  Created by Dal Rupnik on 17/06/14.
//
//

#import "JSONModel.h"

@interface TKRepository : JSONModel

@property (nonatomic) NSInteger id;
@property (nonatomic, strong) NSString* slug;
@property (nonatomic, strong) NSString* description;
@property (nonatomic) NSInteger last_build_id;
@property (nonatomic, strong) NSString<Optional>* last_build_number;
@property (nonatomic, strong) NSString<Optional>* last_build_state;
@property (nonatomic, strong) NSNumber<Optional>* last_build_duration;
@property (nonatomic, strong) NSDate<Optional>* last_build_started_at;
@property (nonatomic, strong) NSDate<Optional>* last_build_finished_at;
@property (nonatomic, strong) NSString<Optional>* github_language;

@end
