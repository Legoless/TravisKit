//
//  TKCache.h
//  Pods
//
//  Created by Dal Rupnik on 18/06/14.
//
//

#import "JSONModel.h"

@interface TKCache : JSONModel

@property (nonatomic) NSInteger repository_id;
@property (nonatomic, strong) NSNumber* size;
@property (nonatomic, strong) NSString* slug;
@property (nonatomic, strong) NSString* branch;
@property (nonatomic, strong) NSDate* last_modified;

@end
