//
//  SignedTransaction.h
//  BitsharesWallet
//
//  Created by flh on 2018/8/16.
//  Copyright © 2018年 flh. All rights reserved.
//

#import "Transaction.h"
@class PrivateKey;
@interface SignedTransaction : Transaction

@property (nonatomic, copy) NSArray <NSString *>*signatures;

- (void)signWithPrikey:(PrivateKey *)prikey;

@end
