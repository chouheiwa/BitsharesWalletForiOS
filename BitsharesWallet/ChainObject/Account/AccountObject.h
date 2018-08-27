//
//  AccountObject.h
//  BitsharesWallet
//
//  Created by flh on 2018/8/17.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectToDataProtocol.h"
@class ObjectId;
@class AuthorityObject;
@class AccountOptionObject;
@class SpecialAuthorityObject;
@class PublicKey;
@interface AccountObject : NSObject<ObjectToDataProtocol>

/**
 账户id(唯一标识)
 */
@property (nonatomic, strong) ObjectId *identifier;

/**
 账户关系超期时间
 */
@property (nonatomic, strong) NSDate *membership_expiration_date;

/**
 账户注册人(当和id一致时这个用户是终身会员)
 */
@property (nonatomic, strong) ObjectId *registrar;

@property (nonatomic, strong) ObjectId *referrer;

@property (nonatomic, strong) ObjectId *lifetime_referrer;

@property (nonatomic, assign) NSInteger network_fee_percentage;

@property (nonatomic, assign) NSInteger lifetime_referrer_fee_percentage;

@property (nonatomic, assign) NSInteger referrer_rewards_percentage;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) AuthorityObject *owner;

@property (nonatomic, strong) AuthorityObject *active;

@property (nonatomic, strong) AccountOptionObject *options;

@property (nonatomic, strong) ObjectId *statistics;

@property (nonatomic, strong) NSArray <ObjectId *>*whitelisting_accounts;

@property (nonatomic, strong) NSArray <ObjectId *>*blacklisting_accounts;

@property (nonatomic, strong) NSArray <ObjectId *>*whitelisted_accounts;

@property (nonatomic, strong) NSArray <ObjectId *>*blacklisted_accounts;

@property (nonatomic, strong) ObjectId *cashback_vb;

@property (nonatomic, strong) SpecialAuthorityObject *owner_special_authority;

@property (nonatomic, strong) SpecialAuthorityObject *active_special_authority;

@property (nonatomic, assign) NSInteger top_n_control_flags;

- (BOOL)containPublicKey:(PublicKey *)publicKey;

@end
