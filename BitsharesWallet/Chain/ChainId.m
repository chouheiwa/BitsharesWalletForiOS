//
//  ChainId.m
//  BitsharesWallet
//
//  Created by flh on 2018/8/13.
//  Copyright © 2018年 flh. All rights reserved.
//

#import "ChainId.h"
#import "NSData+Base16.h"
@implementation ChainId

- (instancetype)initWithBase16String:(NSString *)base16String {
    if (self = [super init]) {
        _keyData = [[[NSData alloc] initWithBase16EncodedString:base16String options:(NSDataBase16DecodingOptionsDefault)] copy];
    }
    return self;
}

@end
