//
//  Base58Object.h
//  BitsharesWallet
//
//  Created by flh on 2018/8/8.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Base58Object : NSObject
/**
 将指定字节串做base58转换
 
 @param byteData 字节串
 @return base58字符串
 */
+ (NSString *)encode:(NSData *)byteData;
/**
 从base58字符串中解密
 
 @param base58String base58字符串
 @return 解密后二进制数据
 */
+ (NSData *)decodeWithBase58String:(NSString *)base58String;

/**
 base58转码包含转码校验位(sha256校验位)
 
 @param checkSumData 转码二进制数据
 @return 包含末尾4位检验位(Sha256)的base58字符串
 */
+ (NSString *)encodeWithSha256CheckSum:(NSData *)checkSumData;

/**
 base58字符串解码(检查末位4位尾缀(sha256校验位))

 @param base58StringCheckSum base58字符串
 @return 原二进制数据(去除sha256后)
 */
+ (NSData *)decodeWithSha256Base58StringCheckSum:(NSString *)base58StringCheckSum;

/**
 base58转码包含转码校验位(RIPEMD160校验位)
 
 @param checkSumData 转码二进制数据
 @return 包含末尾4位检验位(RIPEMD160)的base58字符串
 */
+ (NSString *)encodeWithRIPEMD160CheckSum:(NSData *)checkSumData;

+ (NSData *)decodeWithRIPEMD160Base58StringCheckSum:(NSString *)base58StringCheckSum;

@end
