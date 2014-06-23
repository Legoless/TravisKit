//
//  TKUser.h
//  Pods
//
//  Created by Dal Rupnik on 18/06/14.
//
//

#import "JSONModel.h"

@interface TKUser : JSONModel

@property (nonatomic) NSInteger id;
@property (nonatomic, strong) NSString* login;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* email;
@property (nonatomic, strong) NSString* gravatar_id;
@property (nonatomic) BOOL is_syncing;
@property (nonatomic, strong) NSDate* synced_at;
@property (nonatomic) BOOL correct_scopes;
@property (nonatomic, strong) NSArray<Optional>* channels;

@end
