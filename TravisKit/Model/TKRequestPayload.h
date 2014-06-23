//
// Created by Dal Rupnik on 23/06/14.
//

#import "JSONModel.h"

#import "TKRequest.h"
#import "TKCommit.h"

@interface TKRequestPayload : JSONModel

@property (nonatomic, strong) TKRequest* request;
@property (nonatomic, strong) TKCommit* commit;
@end