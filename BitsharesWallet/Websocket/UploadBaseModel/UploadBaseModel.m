//
//  UploadBaseModel.m
//  BitsharesWallet
//
//  Created by flh on 2018/8/17.
//  Copyright © 2018年 flh. All rights reserved.
//

#import "UploadBaseModel.h"
#import "UploadParams.h"
@implementation UploadBaseModel

- (NSDictionary *)convertData {
    NSString *method = self.method == WebsocketBlockChainMethodApiCall?@"call":@"notice";
    
    return @{@"method":method,@"id":@(self.identifier),@"params":[self.params convertData]};
}

@end
