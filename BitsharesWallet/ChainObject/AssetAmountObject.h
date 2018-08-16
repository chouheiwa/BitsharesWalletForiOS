//
//  AssetAmountObject.h
//  BitsharesWallet
//
//  Created by flh on 2018/8/15.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectToDataProtocol.h"
@class ObjectId;
/**
 资产id数量
 */
@interface AssetAmountObject : NSObject<ObjectToDataProtocol>

@property (nonatomic, strong, readonly) ObjectId *assetId;

@property (nonatomic, assign, readonly) long amount;

- (instancetype)initFromAssetId:(ObjectId *)objectId amount:(long)amount;



@end
