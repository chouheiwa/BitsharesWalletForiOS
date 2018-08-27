//
//  Price.m
//  BitsharesWallet
//
//  Created by flh on 2018/8/23.
//  Copyright © 2018年 flh. All rights reserved.
//

#import "Price.h"
#import "NSObject+DataToObject.h"
#import "AssetAmountObject.h"
@implementation Price

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

- (NSInteger)dataSize {
    return self.transformToData.length;
}

- (NSData *)transformToData {
    NSMutableData *data = [NSMutableData data];
    
    [data appendData:_base.transformToData];
    [data appendData:_quote.transformToData];
    
    return data.copy;
}

@end
