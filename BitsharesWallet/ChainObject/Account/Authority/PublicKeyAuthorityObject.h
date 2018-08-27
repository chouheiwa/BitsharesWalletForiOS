//
//  KeyAuthorityObject.h
//  BitsharesWallet
//
//  Created by flh on 2018/8/17.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectToDataProtocol.h"
@class PublicKey;
@interface PublicKeyAuthorityObject : NSObject<ObjectToDataProtocol>

@property (nonatomic, strong, readonly) PublicKey *key;

@property (nonatomic, assign, readonly) short weight_threshold;

- (instancetype)initWithPublicKey:(PublicKey *)publicKey weightThreshold:(short)weightThreshold;

@end
