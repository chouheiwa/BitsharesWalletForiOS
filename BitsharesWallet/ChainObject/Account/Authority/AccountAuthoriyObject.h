//
//  AccountAuthoriyObject.h
//  BitsharesWallet
//
//  Created by flh on 2018/8/17.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectToDataProtocol.h"
@class ObjectId;
@interface AccountAuthoriyObject : NSObject<ObjectToDataProtocol>

@property (nonatomic, strong, readonly) ObjectId *accountId;

@property (nonatomic, assign, readonly) short weight_threshold;

- (instancetype)initWithAccountId:(ObjectId *)accountId weightThreshold:(short)weightThreshold;

@end
