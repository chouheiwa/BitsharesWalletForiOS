//
//  AssetOption.h
//  BitsharesWallet
//
//  Created by flh on 2018/8/22.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectToDataProtocol.h"
#import "AssetPermissionObject.h"
@class Price;
@class ObjectId;
@interface AssetOption : NSObject<ObjectToDataProtocol>

@property (nonatomic, strong) NSDecimalNumber *max_supply;

@property (nonatomic, assign) NSInteger market_fee_percent;

@property (nonatomic, assign) NSInteger max_market_fee;

@property (nonatomic, strong) AssetPermissionObject *issuer_permissions;

@property (nonatomic, strong) AssetPermissionObject *flags;

@property (nonatomic, strong) Price *core_exchange_rate;

@property (nonatomic, copy) NSArray <ObjectId *>*whitelist_authorities;

@property (nonatomic, copy) NSArray <ObjectId *>*blacklist_authorities;

@property (nonatomic, copy) NSArray <ObjectId *>*whitelist_markets;

@property (nonatomic, copy) NSArray <ObjectId *>*blacklist_markets;

@property (nonatomic, copy) NSString *descriptions;

@property (nonatomic, copy) NSArray *extensions;

@end
