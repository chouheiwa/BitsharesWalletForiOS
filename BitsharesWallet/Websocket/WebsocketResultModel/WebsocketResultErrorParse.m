//
//  WebsocketResultErrorParse.m
//  BitsharesWallet
//
//  Created by flh on 2018/8/27.
//  Copyright © 2018年 flh. All rights reserved.
//

#import "WebsocketResultErrorParse.h"
#import "BitsharesWalletError.h"
@implementation WebsocketResultErrorParse

+ (NSError *)generateFromError:(NSDictionary *)errorDic {
    NSDictionary *data = errorDic[@"data"];
    
    WebsocketErrorCode code = [data[@"code"] integerValue];
    
    NSString *message = errorDic[@"message"];
    
    switch (code) {
        case WebsocketErrorCodeBroadcastInsufficientFee:{
            return [NSError errorWithDomain:message code:code userInfo:@{@"data":data[@"stack"][0][@"data"],@"chineseMessage":[NSString stringWithFormat:@"账户给定付出手续费不足,请给付足额手续费"]}];
        }
            break;
        case WebsocketErrorCodeBroadcastMissingRequiredActiveAuthority:
            return [NSError errorWithDomain:message code:code userInfo:@{@"data":data[@"stack"][0][@"data"],@"chineseMessage":[NSString stringWithFormat:@"缺少账户活动私钥"]}];
            break;
        case WebsocketErrorCodeBroadcastMissingRequiredOwnerAuthority:
            return [NSError errorWithDomain:message code:code userInfo:@{@"data":data[@"stack"][0][@"data"],@"chineseMessage":[NSString stringWithFormat:@"缺少账户所有者私钥"]}];
            break;
        case WebsocketErrorCodeBroadcastMissingRequiredOtherAuthority:
            return [NSError errorWithDomain:message code:code userInfo:@{@"data":data[@"stack"][0][@"data"],@"chineseMessage":[NSString stringWithFormat:@"缺少账户其他权限私钥"]}];
            break;
        case 10:{
            if ([message containsString:@"Insufficient Balance"]) {
                return [NSError errorWithDomain:message code:WebsocketErrorCodeBroadcastInsufficientBalance userInfo:nil];
            }
        }
            break;
        default:
            break;
            
    }
    
    return [NSError errorWithDomain:@"Broad cast error not known" code:WebsocketErrorCodeBroadcastErrorNotKnown userInfo:errorDic];
}

@end
