//
//  SpecialAuthorityObject.h
//  BitsharesWallet
//
//  Created by flh on 2018/8/19.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectToDataProtocol.h"
/**
 I have no idea about this object
 还不知道这个对象干什么用的
 */
@interface SpecialAuthorityObject : NSObject<ObjectToDataProtocol>

@property (nonatomic, assign) NSInteger weight_threshold;

@property (nonatomic, copy) NSDictionary *item;

@end
