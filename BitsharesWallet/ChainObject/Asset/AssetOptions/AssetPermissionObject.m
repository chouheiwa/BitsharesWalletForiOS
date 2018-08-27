//
//  AssetPermissionObject.m
//  BitsharesWallet
//
//  Created by flh on 2018/8/22.
//  Copyright © 2018年 flh. All rights reserved.
//

#import "AssetPermissionObject.h"

#import "PackData.h"

@implementation AssetPermissionObject



+ (instancetype)generateFromObject:(id)object {
    if (![object isKindOfClass:[NSNumber class]]) return nil;
    
    NSInteger final_permission = [object integerValue];
    
    AssetPermissionObject *permission = [[AssetPermissionObject alloc] init];
    
    permission.charge_market_fee = final_permission & 0x01;
    
    permission.white_list = final_permission & 0x02;
    
    permission.override_authority = final_permission & 0x04;
    
    permission.transfer_restricted = final_permission & 0x08;
    
    permission.disable_force_settle = final_permission & 0x10;
    
    permission.global_settle = final_permission & 0x20;
    
    permission.disable_confidential = final_permission & 0x40;
    
    permission.witness_fed_asset = final_permission & 0x80;
    
    permission.committee_fed_asset = final_permission & 0x100;
    
    return permission;
}

- (id)generateToTransferObject {
    NSInteger final_permission = 0;
    
    if (self.charge_market_fee) final_permission += 0x01;
    
    if (self.white_list) final_permission += 0x02;
    
    if (self.override_authority) final_permission += 0x04;
    
    if (self.transfer_restricted) final_permission += 0x08;
    
    if (self.disable_force_settle) final_permission += 0x10;
    
    if (self.global_settle) final_permission += 0x20;
    
    if (self.disable_confidential) final_permission += 0x40;
    
    if (self.witness_fed_asset) final_permission += 0x80;
    
    if (self.committee_fed_asset) final_permission += 0x100;
    
    return @(final_permission);
}

- (NSInteger)dataSize {
    return 2;
}

- (NSData *)transformToData {
    return [PackData packShort:[[self generateToTransferObject] integerValue]];
}
@end
