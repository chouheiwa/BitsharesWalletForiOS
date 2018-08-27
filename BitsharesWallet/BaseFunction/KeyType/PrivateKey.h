//
//  PrivateKey.h
//  BitsharesWallet
//
//  Created by flh on 2018/8/9.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PublicKey;
@interface PrivateKey : NSObject

/**
 32字节长度二进制数据
 */
@property (nonatomic, strong, readonly) NSData *keyData;

- (instancetype)initWithKeyData:(NSData *)keyData;

- (instancetype)initWithPrivateKey:(NSString *)privateKey;

/**
 通过速记词生成私钥(采用速记词sha512后接sha256最后base58 checkSum)

 @param brainKey 速记词
 @return 私钥对象
 */
- (instancetype)initWithBrainKey:(NSString *)brainKey;

- (PublicKey *)publicKey;

- (NSString *)signedCompact:(NSData *)sha256Data requireCanonical:(BOOL)requireCanonical;

- (NSData *)getSharedSecret:(PublicKey *)otherPublic;

@end
