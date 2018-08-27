//
//  WebsocketResultErrorParse.h
//  BitsharesWallet
//
//  Created by flh on 2018/8/27.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebsocketResultErrorParse : NSObject

+ (NSError *)generateFromError:(NSDictionary *)errorDic;

@end
