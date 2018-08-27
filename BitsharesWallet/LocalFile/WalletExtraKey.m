//
//  WalletExtraKey.m
//  BitsharesWallet
//
//  Created by flh on 2018/8/19.
//  Copyright © 2018年 flh. All rights reserved.
//

#import "WalletExtraKey.h"
#import "ObjectId.h"
#import "PublicKey.h"

#import "NSObject+DataToObject.h"

@implementation WalletExtraKey

+ (instancetype)generateFromObject:(NSArray *)object {
    if (![object isKindOfClass:[NSArray class]]) return nil;
    
    WalletExtraKey *wallet = [[WalletExtraKey alloc] init];
    
    wallet.keyId = [ObjectId createFromString:object.firstObject];
    
    NSArray *array = object.lastObject;
    
    NSMutableArray *publicArray = [NSMutableArray arrayWithCapacity:(array.count)];
    
    for (NSString *publicKey in array) {
        [publicArray addObject:[PublicKey generateFromObject:publicKey]];
    }
    
    wallet.keyArray = publicArray;
    
    return wallet;
}

- (id)generateToTransferObject {
    return @[self.keyId.generateToTransferObject,[NSObject generateToTransferArray:self.keyArray]];
}

- (BOOL)containPublicKey:(PublicKey *)publicKey {
    return [self.keyArray containsObject:publicKey];
}

@end
