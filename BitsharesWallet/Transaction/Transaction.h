//
//  Transaction.h
//  BitsharesWallet
//
//  Created by flh on 2018/8/16.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OperationContent.h"
#import "ObjectToDataProtocol.h"
@interface Transaction : NSObject<ObjectToDataProtocol>

@property (nonatomic, assign, readonly) uint16_t ref_block_num;

@property (nonatomic, assign, readonly) uint32_t ref_block_prefix;

@property (nonatomic, strong) NSDate *expiration;

@property (nonatomic, copy) NSArray <OperationContent *>*operations;

@property (nonatomic, strong) NSArray *extensions;

- (void)setRefBlock:(NSString *)refBlock;

@end
