//
//  TKRequest.h
//  Pods
//
//  Created by Dal Rupnik on 18/06/14.
//
//

#import "JSONModel.h"
#import "TKDefines.h"

@interface TKRequest : JSONModel

@property (nonatomic) NSInteger id;
@property (nonatomic) NSInteger commit_id;
@property (nonatomic) NSInteger repository_id;
@property (nonatomic, strong) NSDate* created_at;
@property (nonatomic) NSInteger owner_id;
@property (nonatomic) TKOwnerType owner_type;
@property (nonatomic) TKEventType event_type;
@property (nonatomic, strong) NSString<Optional>* base_commit;
@property (nonatomic, strong) NSString<Optional>* head_commit;
@property (nonatomic) TKResultType result;
@property (nonatomic, strong) NSString<Optional>* message;
@property (nonatomic) BOOL pull_request;
@property (nonatomic, strong) NSString<Optional>* pull_request_title;
@property (nonatomic, strong) NSNumber<Optional>* pull_request_number;
@property (nonatomic, strong) NSString<Optional>* branch;
@property (nonatomic, strong) NSString<Optional>* tag;

@end
