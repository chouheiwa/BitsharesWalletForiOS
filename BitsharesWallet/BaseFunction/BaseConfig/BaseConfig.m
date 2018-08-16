//
//  BaseConfig.m
//  BitsharesWallet
//
//  Created by flh on 2018/8/15.
//  Copyright © 2018年 flh. All rights reserved.
//

#import "BaseConfig.h"

@interface BaseConfig ()

@property (nonatomic, copy) NSString *prefix;

@property (nonatomic, copy) NSString *chainId;

@end

@implementation BaseConfig

+ (instancetype)shareInstance {
    static BaseConfig *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[BaseConfig alloc] init];
    });
    
    return sharedInstance;
}

+ (void)setPrefix:(NSString *)prefix {
    [BaseConfig shareInstance].prefix = prefix;
}

+ (NSString *)prefix {
    return [BaseConfig shareInstance].prefix;
}

+ (void)setChainId:(NSString *)chainId {
    [BaseConfig shareInstance].chainId = chainId;
}

+ (NSString *)chainId {
    return [BaseConfig shareInstance].chainId;
}

@end
