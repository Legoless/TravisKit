//
//  TKCommit.h
//  Pods
//
//  Created by Dal Rupnik on 18/06/14.
//
//

#import "JSONModel.h"

@protocol TKCommit <NSObject>

@end

@interface TKCommit : JSONModel

@property (nonatomic) NSInteger id;
@property (nonatomic, strong) NSString* sha;
@property (nonatomic, strong) NSString* branch;
@property (nonatomic, strong) NSString* message;
@property (nonatomic, strong) NSDate<Optional>* commited_at;
@property (nonatomic, strong) NSString* author_name;
@property (nonatomic, strong) NSString* author_email;
@property (nonatomic, strong) NSString<Optional>* commiter_name;
@property (nonatomic, strong) NSString<Optional>* commiter_email;
@property (nonatomic, strong) NSString* compare_url;

@end
