//
//  TKBroadcast.h
//  Pods
//
//  Created by Dal Rupnik on 18/06/14.
//
//

#import "JSONModel.h"

@interface TKBroadcast : JSONModel

@property (nonatomic) NSInteger id;
@property (nonatomic, strong) NSString* message;

@end
