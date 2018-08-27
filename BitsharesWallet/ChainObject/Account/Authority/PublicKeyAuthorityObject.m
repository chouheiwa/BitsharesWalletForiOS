//
//  KeyAuthorityObject.m
//  BitsharesWallet
//
//  Created by flh on 2018/8/17.
//  Copyright © 2018年 flh. All rights reserved.
//

#import "PublicKeyAuthorityObject.h"
#import "PublicKey.h"
#import "PackData.h"

@implementation PublicKeyAuthorityObject

- (instancetype)initWithPublicKey:(PublicKey *)publicKey weightThreshold:(short)weightThreshold {
    if (self = [super init]) {
        _weight_threshold = weightThreshold;
        _key = publicKey;
    }
    return self;
}

+ (instancetype)generateFromObject:(NSArray *)object {
    if (![object isKindOfClass:[NSArray class]]) return nil;
    
    PublicKey *public = [[PublicKey alloc] initWithAllPubkeyString:object.firstObject];
    
    short weight = [object.lastObject shortValue];
    
    return [[self alloc] initWithPublicKey:public weightThreshold:weight];
}

- (id)generateToTransferObject {
    return @[self.key.description,@(self.weight_threshold)];
}

- (NSInteger)dataSize {
    return 35;
}

- (NSData *)transformToData {
    NSMutableData *data = [NSMutableData dataWithCapacity:34];
    
    [data appendData:self.key.keyData];
    
    [data appendData:[PackData packShort:self.weight_threshold]];
    
    return [data copy];
}

@end
