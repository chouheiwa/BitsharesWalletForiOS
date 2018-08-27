//
//  PackData.h
//  BitsharesWallet
//
//  Created by flh on 2018/8/15.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PackData : NSObject

+ (NSData *)packShort:(short)value;

+ (NSData *)packInt:(int)value;

+ (NSData *)packUnsigedInteger:(NSInteger)value;

+ (NSInteger)unpackUnsignedIntegerWithData:(NSData *)data byteLength:(int *)byteLength;

+ (NSData *)packLongValue:(long)value;

+ (NSData *)packUInt64_T:(uint64_t)value;

+ (NSData *)packBool:(BOOL)boolValue;

+ (NSData *)packDate:(NSDate *)date;

+ (NSData *)packString:(NSString *)string;

@end
