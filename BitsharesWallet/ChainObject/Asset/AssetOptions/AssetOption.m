//
//  AssetOption.m
//  BitsharesWallet
//
//  Created by flh on 2018/8/22.
//  Copyright © 2018年 flh. All rights reserved.
//

#import "AssetOption.h"
#import "NSObject+DataToObject.h"

#import "PackData.h"

#import "Price.h"
#import "ObjectId.h"

@implementation AssetOption

- (instancetype)init
{
    self = [super init];
    if (self) {
        _whitelist_authorities = @[];
        _blacklist_authorities = @[];
        _whitelist_markets = @[];
        _blacklist_markets = @[];
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
    
    
    
    if ([key isEqualToString:@"max_supply"]) {
        _max_supply = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",value]];
        return;
    }
    
    if ([key isEqualToString:@"description"]) {
        _descriptions = value;
        return;
    }
    
    if ([value isKindOfClass:[NSArray class]]) {
        if (![key isEqualToString:@"extensions"]) {
            [super setValue:[ObjectId generateFromDataArray:value] forKey:key];
            return;
        }else {
            [super setValue:value forKey:key];
            return;
        }
    }
    
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
    NSMutableDictionary *dic = [[self defaultGetDictionary] mutableCopy];
    
    dic[@"description"] = dic[@"descriptions"];
    
    dic[@"descriptions"] = nil;
    
    return dic;
}

- (NSInteger)dataSize {
    return [self transformToData].length;
}

- (NSData *)transformToData {
    NSMutableData *data = [NSMutableData dataWithCapacity:100];
    
    [data appendData:[PackData packLongValue:_max_supply.longValue]];
    
    [data appendData:[PackData packShort:_market_fee_percent]];
    
    [data appendData:[PackData packLongValue:_max_market_fee]];
    
    [data appendData:_issuer_permissions.transformToData];
    
    [data appendData:_flags.transformToData];
    
    [data appendData:_core_exchange_rate.transformToData];
    
    [self packArray:self.whitelist_authorities toData:data];
    
    [self packArray:self.blacklist_authorities toData:data];
    
    [self packArray:self.whitelist_markets toData:data];
    
    [self packArray:self.blacklist_markets toData:data];
    
    [data appendData:[PackData packString:self.descriptions]];
    
    [data appendData:[PackData packUnsigedInteger:self.extensions.count]];
    
    return data.copy;
}

- (void)packArray:(NSArray <id <ObjectToDataProtocol>>*)array toData:(NSMutableData *)data {
    [data appendData:[PackData packUnsigedInteger:array.count]];
    
    for (id <ObjectToDataProtocol>obj in array) {
        [data appendData:obj.transformToData];
    }
}

@end
