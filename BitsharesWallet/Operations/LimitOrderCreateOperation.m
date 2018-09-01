//
//  LimitOrderCreateOperation.m
//  BitsharesWallet
//
//  Created by flh on 2018/8/30.
//  Copyright © 2018年 flh. All rights reserved.
//

#import "LimitOrderCreateOperation.h"
#import "NSObject+DataToObject.h"
#import "AssetAmountObject.h"
#import "ObjectId.h"
#import "PackData.h"
#import "NSDate+UTCDate.h"
@implementation LimitOrderCreateOperation

- (instancetype)init {
    if (self = [super init]) {
        _extensions = @[];
    }
    return self;
}

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([value isKindOfClass:[NSNull class]]) return;
    
    value = [self defaultGetValue:value forKey:key];
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (instancetype)generateFromObject:(id)object {
    if (![object isKindOfClass:[NSDictionary class]]) return nil;
    
    return [[self alloc] initWithDic:object];
}

- (id)generateToTransferObject {
    return [self defaultGetDictionary];
}

- (NSData *)transformToData {
    NSMutableData *data = [NSMutableData dataWithCapacity:200];
    
    [data appendData:self.fee.transformToData];
    
    [data appendData:self.seller.transformToData];
    
    [data appendData:self.amount_to_sell.transformToData];
    
    [data appendData:self.min_to_receive.transformToData];
    
    [data appendData:self.expiration.transformToData];
    
    [data appendData:[PackData packBool:self.fill_or_kill]];
    
    [data appendData:[PackData packUnsigedInteger:self.extensions.count]];
    
    return [data copy];
}

- (AssetAmountObject *)caculateFeeWithFeeDic:(NSDictionary *)feeDictionary payFeeAsset:(AssetObject *)asset {
    
}

@end
