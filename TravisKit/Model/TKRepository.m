//
//  TKRepository.m
//  TravisKit
//
//  Created by Dal Rupnik on 17/06/14.
//  Copyright (c) 2014 arvystate.net. All rights reserved.
//

#import "TKRepository.h"

@implementation TKRepository

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    if ([propertyName hasPrefix:@"last_build"])
    {
        return YES;
    }
    
    return NO;
}

@end
