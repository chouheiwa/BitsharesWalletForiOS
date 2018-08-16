//
//  NSData+CopyWithRange.h
//  BitsharesWallet
//
//  Created by flh on 2018/8/10.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (CopyWithRange)

- (instancetype)copyWithRange:(NSRange)range;

@end
