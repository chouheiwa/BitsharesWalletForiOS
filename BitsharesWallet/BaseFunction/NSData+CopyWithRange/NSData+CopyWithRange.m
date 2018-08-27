//
//  NSData+CopyWithRange.m
//  BitsharesWallet
//
//  Created by flh on 2018/8/10.
//  Copyright © 2018年 flh. All rights reserved.
//

#import "NSData+CopyWithRange.h"

@implementation NSData (CopyWithRange)

- (instancetype)copyWithRange:(NSRange)range {
    if (range.location + range.length > self.length) {
        NSException *exception = [NSException exceptionWithName:@"Data out of bounds" reason:[NSString stringWithFormat:@"Data length %lu can't copy at location:%lu length:%lu",self.length,range.location,range.length] userInfo:nil];
        [exception raise];
    }
    
    Byte *bytes = (Byte *)malloc(range.length);
    
    for (int i = 0; i < range.length; i ++) {
        bytes[i] = ((Byte *)self.bytes)[range.location + i];
    }
    
    NSData *copyData = [NSData dataWithBytes:bytes length:range.length];
    
    free(bytes);
    
    return copyData;
}

@end
