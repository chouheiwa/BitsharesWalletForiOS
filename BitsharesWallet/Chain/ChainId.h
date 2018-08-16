//
//  ChainId.h
//  BitsharesWallet
//
//  Created by flh on 2018/8/13.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChainId : NSObject

@property (nonatomic, copy, readonly) NSData *keyData;

- (instancetype)initWithBase16String:(NSString *)base16String;

@end
