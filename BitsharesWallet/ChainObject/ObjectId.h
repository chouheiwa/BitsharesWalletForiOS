//
//  ObjectId.h
//  BitsharesWallet
//
//  Created by flh on 2018/8/15.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectToDataProtocol.h"

/**
 On the BitShares blockchains there are no addresses, but objects identified by a unique id, an type and a space in the form
 bitshares中没有地址的概念，但是所有的操作都会拥有一个独一无二的id
 example:1.2.6
 */
@interface ObjectId : NSObject<ObjectToDataProtocol>

/**
 区块链中
 */
@property (nonatomic, assign, readonly) NSInteger spaceId;

@property (nonatomic, assign, readonly) NSInteger typeId;

@property (nonatomic, assign, readonly) NSInteger instance;

+ (instancetype)createFromString:(NSString *)string;

- (instancetype)initFromSpaceId:(NSInteger)spaceId typeId:(NSInteger)typeId instance:(NSInteger)instance;

@end
