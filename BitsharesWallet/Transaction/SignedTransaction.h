//
//  SignedTransaction.h
//  BitsharesWallet
//
//  Created by flh on 2018/8/16.
//  Copyright © 2018年 flh. All rights reserved.
//

#import "Transaction.h"
@class PrivateKey;
@class PublicKey;
@interface SignedTransaction : Transaction

@property (nonatomic, copy) NSArray <NSString *>*signatures;

- (void)signWithPrikey:(PrivateKey *)prikey;

- (NSArray <PublicKey *>*)needSignedKeys;

@end
