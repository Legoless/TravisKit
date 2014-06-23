//
//  TKAnnotation.h
//  Pods
//
//  Created by Dal Rupnik on 17/06/14.
//
//

#import "JSONModel.h"

@interface TKAnnotation : JSONModel

@property (nonatomic) NSInteger id;
@property (nonatomic) NSInteger job_id;
@property (nonatomic, strong) NSString* description;
@property (nonatomic, strong) NSString* url;
@property (nonatomic, strong) NSString* status;

@property (nonatomic, strong) NSString<Optional>* username;
@property (nonatomic, strong) NSString<Optional>* key;

@end
