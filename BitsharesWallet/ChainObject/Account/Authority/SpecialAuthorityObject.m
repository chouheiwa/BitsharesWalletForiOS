//
//  SpecialAuthorityObject.m
//  BitsharesWallet
//
//  Created by flh on 2018/8/19.
//  Copyright © 2018年 flh. All rights reserved.
//

#import "SpecialAuthorityObject.h"

@implementation SpecialAuthorityObject

+ (instancetype)generateFromObject:(NSArray *)object {
    if (![object isKindOfClass:[NSArray class]]) return nil;
    
    SpecialAuthorityObject *obj = [[SpecialAuthorityObject alloc] init];
    
    obj.weight_threshold = [object.firstObject integerValue];
    
    obj.item = object.lastObject;
    
    return obj;
}

- (id)generateToTransferObject {
    return @[@(self.weight_threshold),self.item];
}

@end
