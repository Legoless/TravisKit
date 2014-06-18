//
//  TKLog.h
//  Pods
//
//  Created by Dal Rupnik on 18/06/14.
//
//

#import "JSONModel.h"

@interface TKLog : JSONModel

@property (nonatomic) NSInteger id;
@property (nonatomic) NSInteger job_id;
@property (nonatomic, strong) NSString* body;

@end
