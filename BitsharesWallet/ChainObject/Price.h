//
//  Price.h
//  BitsharesWallet
//
//  Created by flh on 2018/8/23.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectToDataProtocol.h"

@class AssetAmountObject;
@interface Price : NSObject<ObjectToDataProtocol>

@property (nonatomic, strong) AssetAmountObject *base;

@property (nonatomic, strong) AssetAmountObject *quote;

@end
