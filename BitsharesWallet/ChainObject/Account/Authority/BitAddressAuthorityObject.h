//
//  BitAddressAuthorityObject.h
//  BitsharesWallet
//
//  Created by flh on 2018/8/17.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectToDataProtocol.h"
@class BitAddress;
@interface BitAddressAuthorityObject : NSObject<ObjectToDataProtocol>

@property (nonatomic, strong, readonly) BitAddress *address;

@property (nonatomic, assign, readonly) short weight_threshold;

- (instancetype)initWithBitAddress:(BitAddress *)bitAddress weightThreshold:(short)weightThreshold;

@end
