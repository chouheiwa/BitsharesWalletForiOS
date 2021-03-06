//
//  NSData+HashData.h
//  BitsharesWallet
//
//  Created by flh on 2018/8/8.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (HashData)

- (NSData *)sha256Data;

- (NSData *)doubleSha256Data;

- (NSData *)sha512Data;

- (NSData *)RIPEMD160Data;

- (void)logDataDetail:(NSString *)test;

/**
 aes256CBC encrypt

 @param keyData 32位长度密码串
 @param ivData 16位长度向量偏移
 @return 加密后字节码
 */
- (NSData *)aes256Encrypt:(NSData *)keyData ivData:(NSData *)ivData;

- (NSData *)aes256Decrypt:(NSData *)keyData ivData:(NSData *)ivData;

@end
