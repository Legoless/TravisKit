
//
//  TKDefines.h
//  TravisKit
//
//  Created by Dal Rupnik on 18/06/14.
//  Copyright (c) 2014 arvystate.net. All rights reserved.
//

#ifndef TKDefines_Header_h
#define TKDefines_Header_h

typedef enum : NSUInteger
{
    TKEventTypeAny,
    TKEventTypePush,
    TKEventTypePullRequest
} TKEventType;

typedef enum : NSUInteger
{
    TKOwnerTypeUser,
    TKOwnerTypeOrganization
} TKOwnerType;

typedef enum : NSUInteger
{
    TKResultTypeNull,
    TKResultTypeAccepted,
    TKResultTypeRejected
} TKResultType;

#endif
