//
//  TKConfig.h
//  Pods
//
//  Created by Dal Rupnik on 20/06/14.
//
//

#import "JSONModel.h"

@interface TKConfig : JSONModel

@property (nonatomic, strong) NSString* host;
@property (nonatomic, strong) NSDictionary* pusher;
@property (nonatomic, strong) NSDictionary* github;

@end
