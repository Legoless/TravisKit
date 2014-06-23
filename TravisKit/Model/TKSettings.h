//
//  TKSettings.h
//  Pods
//
//  Created by Dal Rupnik on 18/06/14.
//
//

#import "JSONModel.h"

@interface TKSettings : JSONModel

@property (nonatomic) BOOL builds_only_with_travis_yml;
@property (nonatomic) BOOL build_pushes;
@property (nonatomic) BOOL build_pull_requests;

@end
