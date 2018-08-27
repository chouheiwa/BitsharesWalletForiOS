//
//  ChainDynamicGlobalProperties.h
//  BitsharesWallet
//
//  Created by flh on 2018/8/27.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectToDataProtocol.h"
@class ObjectId;

@interface ChainDynamicGlobalProperties : NSObject<ObjectToDataProtocol>

@property (nonatomic, strong) ObjectId *identifier;

@property (nonatomic, strong) NSDecimalNumber *head_block_number;

@property (nonatomic, copy) NSString *head_block_id;

@property (nonatomic, strong) NSDate *time;

@property (nonatomic, strong) ObjectId *current_witness;

@property (nonatomic, strong) NSDate *next_maintenance_time;

@property (nonatomic, strong) NSDate *last_budget_time;

@property (nonatomic, strong) NSDecimalNumber *witness_budget;

@property (nonatomic, assign) NSInteger accounts_registered_this_interval;

@property (nonatomic, assign) NSInteger recently_missed_count;

@property (nonatomic, strong) NSDecimalNumber *current_aslot;

@property (nonatomic, copy) NSString *recent_slots_filled;

@property (nonatomic, assign) NSInteger dynamic_flags;

@property (nonatomic, strong) NSDecimalNumber *last_irreversible_block_num;



@end
