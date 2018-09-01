//
//  BrainKey.h
//  BitsharesWallet
//
//  Created by flh on 2018/8/28.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PublicKey;
@class PrivateKey;
@interface BrainKey : NSObject

@property (nonatomic, copy) NSString *brainKey;

@property (nonatomic, strong) PublicKey *pubKey;

@property (nonatomic, strong) PrivateKey *priKey;

+ (instancetype)suggestBrainKey;

+ (instancetype)deriveFromBrainKey:(NSString *)brainKeys;

@end
