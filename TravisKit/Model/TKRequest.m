//
//  TKRequest.m
//  Pods
//
//  Created by Dal Rupnik on 18/06/14.
//
//

#import "TKRequest.h"

@implementation TKRequest

- (void)setResultWithNSString:(NSString *)resultString
{
    if ([resultString isEqualToString:@"null"])
    {
        _result = TKResultTypeNull;
    }
    else if ([resultString isEqualToString:@"accepted"])
    {
        _result = TKResultTypeAccepted;
    }
    else if ([resultString isEqualToString:@"rejected"])
    {
        _result = TKResultTypeRejected;
    }
}

- (id)JSONObjectForResult
{
    switch (self.result)
    {
        case TKResultTypeAccepted:
            return @"accepted";
        case TKResultTypeRejected:
            return @"rejected";
        default:
            return @"null";
    }
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"result"])
    {
        return YES;
    }
    
    return NO;
}

@end
