//
//  TKPermissions.h
//  Pods
//
//  Created by Dal Rupnik on 18/06/14.
//
//

#import "JSONModel.h"

@interface TKPermissions : JSONModel

@property (nonatomic, strong) NSArray* permissions;
@property (nonatomic, strong) NSArray* admin;
@property (nonatomic, strong) NSArray* pull;
@property (nonatomic, strong) NSArray* push;

@end
