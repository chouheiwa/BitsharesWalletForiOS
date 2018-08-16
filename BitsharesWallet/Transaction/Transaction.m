//
//  Transaction.m
//  BitsharesWallet
//
//  Created by flh on 2018/8/16.
//  Copyright © 2018年 flh. All rights reserved.
//

#import "Transaction.h"
#import "NSDate+UTCDate.h"
#import "OperationContent.h"
#import "PackData.h"
@implementation Transaction

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([value isKindOfClass:[NSNull class]]) return;
    
    if ([key isEqualToString:@"expiration"]) {
        self.expiration = [NSDate generateFromObject:value];
        return;
    }
    
    if ([key isEqualToString:@"operations"]) {
        NSArray *array = value;
        NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:array.count];
        for (NSDictionary *dic in array) {
            [mutableArray addObject:[OperationContent generateFromObject:dic]];
        }
        
        self.operations = mutableArray;
        
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
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.operations.count];
    
    for (OperationContent *operationContent in self.operations) {
        [array addObject:[operationContent generateToTransferObject]];
    }
    
    return @{@"ref_block_num":@(self.ref_block_num),@"ref_block_prefix":@(self.ref_block_prefix),@"expiration":[self.expiration generateToTransferObject],@"operations":[array copy],@"extensions":self.extensions};
}

- (NSData *)transformToData {
    NSMutableData *data = [NSMutableData dataWithCapacity:200];
    
    [data appendData:[PackData packShort:self.ref_block_num]];
    
    [data appendData:[PackData packInt:self.ref_block_prefix]];
    
    [data appendData:[PackData packDate:self.expiration]];
    
    [data appendData:[PackData packUnsigedInteger:self.operations.count]];
    
    for (OperationContent *content in self.operations) {
        [data appendData:[content transformToData]];
    }
    
    [data appendData:[PackData packUnsigedInteger:self.extensions.count]];
    
    return [data copy];
}

@end
