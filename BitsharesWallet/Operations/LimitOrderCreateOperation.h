//
//  LimitOrderCreateOperation.h
//  BitsharesWallet
//
//  Created by flh on 2018/8/30.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <BitsharesWallet/BitsharesWallet.h>
#import "ObjectToDataProtocol.h"
@class AssetAmountObject;
@class ObjectId;
@interface LimitOrderCreateOperation : BaseOperation

@property (nonatomic, strong) AssetAmountObject *fee;

@property (nonatomic, strong) ObjectId *seller;

@property (nonatomic, strong) AssetAmountObject *amount_to_sell;

@property (nonatomic, strong) AssetAmountObject *min_to_receive;

@property (nonatomic, strong) NSDate *expiration;

@property (nonatomic, assign) BOOL fill_or_kill;

@property (nonatomic, copy) NSArray *extensions;

@end
