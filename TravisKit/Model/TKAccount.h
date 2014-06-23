//
//  TKAccount.h
//  Pods
//
//  Created by Dal Rupnik on 17/06/14.
//
//

#import "JSONModel.h"

@interface TKAccount : JSONModel

@property (nonatomic) NSInteger id;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* type;
@property (nonatomic, strong) NSString* login;
@property (nonatomic) NSInteger repos_count;

@property (nonatomic, strong) NSNumber<Optional>* subscribed;

@end
