//
//  PlainKey.h
//  BitsharesWallet
//
//  Created by flh on 2018/8/20.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectToDataProtocol.h"
@class PublicKey;
@class PrivateKey;
@interface PlainKey : NSObject<ObjectToDataProtocol>

- (instancetype)initWithCipherKey:(NSString *)cipherKey;

- (BOOL)unlockWithPassword:(NSString *)password;

- (BOOL)lockWithPassword:(NSString *)password;

- (void)addPrivateKey:(PrivateKey *)privateKey;

- (PrivateKey *)getPrivateKey:(PublicKey *)pubKey;

- (BOOL)isNew;

@end
