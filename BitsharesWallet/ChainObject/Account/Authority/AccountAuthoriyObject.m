
//
//  AccountAuthoriyObject.m
//  BitsharesWallet
//
//  Created by flh on 2018/8/17.
//  Copyright © 2018年 flh. All rights reserved.
//

#import "AccountAuthoriyObject.h"
#import "ObjectId.h"
#import "PackData.h"
@implementation AccountAuthoriyObject

- (instancetype)initWithAccountId:(ObjectId *)accountId weightThreshold:(short)weightThreshold {
    self = [super init];
    if (self) {
        _weight_threshold = weightThreshold;
        _accountId = accountId;
    }
    return self;
}

+ (instancetype)generateFromObject:(NSArray *)object {
    if (![object isKindOfClass:[NSArray class]]) return nil;
    
    ObjectId *accountId = [ObjectId generateFromObject:object.firstObject];
    
    short weight = [object.lastObject shortValue];
    
    return [[self alloc] initWithAccountId:accountId weightThreshold:weight];
}

- (id)generateToTransferObject {
    return @[_accountId.generateToTransferObject,@(_weight_threshold)];
}

- (NSData *)transformToData {
    NSMutableData *data = [NSMutableData dataWithCapacity:10];
    
    [data appendData:_accountId.transformToData];
    
    [data appendData:[PackData packShort:_weight_threshold]];
    return data;
}

- (NSInteger)dataSize {
    return [self transformToData].length;
}

@end
