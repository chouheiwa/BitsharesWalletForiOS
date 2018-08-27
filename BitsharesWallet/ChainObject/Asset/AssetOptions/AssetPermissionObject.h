//
//  AssetPermissionObject.h
//  BitsharesWallet
//
//  Created by flh on 2018/8/22.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectToDataProtocol.h"
@interface AssetPermissionObject : NSObject<ObjectToDataProtocol>

@property (nonatomic, assign) BOOL charge_market_fee;

@property (nonatomic, assign) BOOL white_list;

@property (nonatomic, assign) BOOL override_authority;

@property (nonatomic, assign) BOOL transfer_restricted;

@property (nonatomic, assign) BOOL disable_force_settle;

@property (nonatomic, assign) BOOL global_settle;

@property (nonatomic, assign) BOOL disable_confidential;

@property (nonatomic, assign) BOOL witness_fed_asset;

@property (nonatomic, assign) BOOL committee_fed_asset;

@end
