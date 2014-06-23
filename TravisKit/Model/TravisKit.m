//
//  TravisKit.m
//  TravisKit
//
//  Created by Dal Rupnik on 17/06/14.
//  Copyright (c) 2014 arvystate.net. All rights reserved.
//

#import "TravisKit.h"

@implementation TravisKit

+ (TKClient *)openSourceClient
{
    return [TKClient clientWithServer:TKOpenSourceServer];
}

+ (TKClient *)privateClient
{
    return [TKClient clientWithServer:TKPrivateServer];
}

+ (TKClient *)clientWithURL:(NSString *)url
{
    return [TKClient clientWithServer:url];
}

@end