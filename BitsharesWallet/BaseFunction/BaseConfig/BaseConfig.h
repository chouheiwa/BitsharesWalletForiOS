//
//  BaseConfig.h
//  BitsharesWallet
//
//  Created by flh on 2018/8/15.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseConfig : NSObject

+ (void)setPrefix:(NSString *)prefix;

+ (NSString *)prefix;

+ (void)setChainId:(NSString *)chainId;

+ (NSString *)chainId;

@end
