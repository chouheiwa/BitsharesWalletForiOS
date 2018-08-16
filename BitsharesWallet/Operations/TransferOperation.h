//
//  TransferOperation.h
//  BitsharesWallet
//
//  Created by flh on 2018/8/15.
//  Copyright © 2018年 flh. All rights reserved.
//

#import "BaseOperation.h"
#import "ObjectToDataProtocol.h"
@class ObjectId;
@class AssetAmountObject;
@class Memo;
@interface TransferOperation : BaseOperation

@property (nonatomic, strong, nonnull) AssetAmountObject *fee;

@property (nonatomic, strong, nonnull) ObjectId *from;

@property (nonatomic, strong, nonnull) ObjectId *to;

@property (nonatomic, strong, nonnull) AssetAmountObject *amount;

@property (nonatomic, strong, nullable) Memo *memo;

@property (nonatomic, strong, nonnull) NSArray *extensions;

@end
