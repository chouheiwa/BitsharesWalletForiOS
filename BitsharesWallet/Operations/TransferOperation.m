//
//  TransferOperation.m
//  BitsharesWallet
//
//  Created by flh on 2018/8/15.
//  Copyright © 2018年 flh. All rights reserved.
//

#import "TransferOperation.h"
#import "AssetAmountObject.h"
#import "ObjectId.h"
#import "Memo.h"
#import "PackData.h"
#import "NSData+HashData.h"

@implementation TransferOperation

- (instancetype)init
{
    self = [super init];
    if (self) {
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
    
    if ([key isEqualToString:@"fee"]) {
        self.fee = [AssetAmountObject generateFromObject:value];
        return;
    }
    if ([key isEqualToString:@"from"]) {
        self.from = [ObjectId generateFromObject:value];
        return;
    }
    if ([key isEqualToString:@"to"]) {
        self.to = [ObjectId generateFromObject:value];
        return;
    }
    
    if ([key isEqualToString:@"memo"]) {
        self.memo = [Memo generateFromObject:value];
        return;
    }
    if ([key isEqualToString:@"amount"]) {
        self.amount = [AssetAmountObject generateFromObject:value];
        return;
    }
    
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (instancetype)generateFromObject:(id)object {
    if (![object isKindOfClass:[NSDictionary class]]) return nil;
    return [[self alloc] initWithDic:object];
}
//
- (id)generateToTransferObject {
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:6];
    
    dic[@"fee"] = [self.fee generateToTransferObject];
    
    dic[@"from"] = [self.from generateToTransferObject];
    
    dic[@"to"] = [self.to generateToTransferObject];
    
    dic[@"amount"] = [self.amount generateToTransferObject];
    
    dic[@"memo"] = [self.memo generateToTransferObject];
    
    dic[@"extensions"] = self.extensions;
    
    return [dic copy];
}

- (NSData *)transformToData {
    NSMutableData *mutableData = [NSMutableData dataWithCapacity:300];
    
    if (!self.fee) {
        [mutableData appendData:[[[AssetAmountObject alloc] initFromAssetId:[ObjectId generateFromObject:@"1.3.0"] amount:0] transformToData]];
    }else {
        [mutableData appendData:[self.fee transformToData]];
    }
    
    [mutableData appendData:[self.from transformToData]];
    
    [mutableData appendData:[self.to transformToData]];
    
    [mutableData appendData:[self.amount transformToData]];
    
    BOOL memoExist = self.memo != nil;
    
    [mutableData appendData:[PackData packBool:memoExist]];
    
    if (memoExist) {
        NSData *memoData =[self.memo transformToData];
        
        [mutableData appendData:memoData];
    }
    
    [mutableData appendData:[PackData packUnsigedInteger:self.extensions.count]];
    
    return [mutableData copy];
}

- (NSInteger)dataSize {
    return [self transformToData].length;
}

@end
