//
//  AuthorityObject.h
//  BitsharesWallet
//
//  Created by flh on 2018/8/17.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectToDataProtocol.h"
@class BitAddressAuthorityObject;
@class PublicKeyAuthorityObject;
@class AccountAuthoriyObject;

@class PublicKey;
@interface AuthorityObject : NSObject<ObjectToDataProtocol>

/**
 权重
 */
@property (nonatomic, assign) int weight_threshold;

@property (nonatomic, copy) NSArray <AccountAuthoriyObject *>*account_auths;

@property (nonatomic, copy) NSArray <PublicKeyAuthorityObject *>*key_auths;

@property (nonatomic, copy) NSArray <BitAddressAuthorityObject *>*address_auths;

- (BOOL)containPublicKey:(PublicKey *)publicKey;

- (NSArray <PublicKey *> *)publicKeys;

@end
