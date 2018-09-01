//
//  AssetObject.h
//  BitsharesWallet
//
//  Created by flh on 2018/8/22.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectToDataProtocol.h"
#import "AssetOption.h"

@class ObjectId;
@class AssetAmountObject;
@interface AssetObject : NSObject<ObjectToDataProtocol>

@property (nonatomic, strong) ObjectId *identifier;

@property (nonatomic, copy) NSString *symbol;

@property (nonatomic, assign) NSInteger precision;

@property (nonatomic, strong) ObjectId *issuer;

@property (nonatomic, strong) AssetOption *options;

@property (nonatomic, strong) ObjectId *dynamic_asset_data_id;

@property (nonatomic, strong) ObjectId *bitasset_data_id;

- (BOOL)isBitAsset;

- (AssetAmountObject *)getAmountFromNormalFloatString:(NSString *)string;

- (NSString *)getRealAmountFromAssetAmount:(AssetAmountObject *)assetAmount;

@end
