//
//  AssetAmountObject.m
//  BitsharesWallet
//
//  Created by flh on 2018/8/15.
//  Copyright © 2018年 flh. All rights reserved.
//

#import "AssetAmountObject.h"
#import "ObjectId.h"
#import "PackData.h"
@implementation AssetAmountObject

- (instancetype)initFromAssetId:(ObjectId *)objectId amount:(long)amount {
    if (self = [super init]) {
        _assetId = objectId;
        _amount = amount;
    }
    return self;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([value isKindOfClass:[NSNull class]]) return;
    
    if ([key isEqualToString:@"asset_id"]) {
        _assetId = [ObjectId generateFromObject:value];
        return;
    }
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (NSString *)description {
    NSData *data = [NSJSONSerialization dataWithJSONObject:[self generateToTransferObject] options:(NSJSONWritingPrettyPrinted) error:NULL];
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+ (instancetype)generateFromObject:(NSDictionary *)object {
    if (![object isKindOfClass:[NSDictionary class]]) return nil;
    
    AssetAmountObject *obj = [[AssetAmountObject alloc] init];
    
    [obj setValuesForKeysWithDictionary:object];
    
    return obj;
}

- (id)generateToTransferObject {
    return @{@"asset_id":[_assetId generateToTransferObject],@"amount":@(_amount)};
}

- (NSInteger)dataSize {
    return [self transformToData].length;
}

- (NSData *)transformToData {
    NSMutableData *data = [NSMutableData dataWithCapacity:20];
    
    [data appendData:[PackData packLongValue:_amount]];
    
    [data appendData:[_assetId transformToData]];
    
    return [data copy];
}
@end
