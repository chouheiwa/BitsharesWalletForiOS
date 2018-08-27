//
//  WalletExtraKey.h
//  BitsharesWallet
//
//  Created by flh on 2018/8/19.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectToDataProtocol.h"
@class ObjectId;
@class PublicKey;
@interface WalletExtraKey : NSObject<ObjectToDataProtocol>

@property (nonatomic, strong) ObjectId *keyId;

@property (nonatomic, copy) NSArray <PublicKey *>*keyArray;

- (BOOL)containPublicKey:(PublicKey *)publicKey;

@end
