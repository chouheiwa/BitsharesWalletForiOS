//
//  BitAddressAuthorityObject.m
//  BitsharesWallet
//
//  Created by flh on 2018/8/17.
//  Copyright © 2018年 flh. All rights reserved.
//

#import "BitAddressAuthorityObject.h"
#import "BitAddress.h"
#import "BaseConfig.h"
#import "PackData.h"
@implementation BitAddressAuthorityObject

- (instancetype)initWithBitAddress:(BitAddress *)bitAddress weightThreshold:(short)weightThreshold {
    if (self = [super init]) {
        _address = bitAddress;
        _weight_threshold = weightThreshold;
    }
    return self;
}

+ (instancetype)generateFromObject:(NSArray *)object {
    if (![object isKindOfClass:[NSArray class]]) return nil;
    
    BitAddress *address = [[BitAddress alloc] initWithBitAddressString:object.firstObject];
    
    short weight = [object.lastObject shortValue];
    
    return [[self alloc] initWithBitAddress:address weightThreshold:weight];
}

- (id)generateToTransferObject {
    return @[_address.description,@(_weight_threshold)];
}

- (NSData *)transformToData {
    NSMutableData *data = [NSMutableData dataWithCapacity:34];
    
    [data appendData:self.address.keyData];
    
    [data appendData:[PackData packShort:self.weight_threshold]];
    
    return [data copy];
}

- (NSInteger)dataSize {
    return 22;
}

@end
