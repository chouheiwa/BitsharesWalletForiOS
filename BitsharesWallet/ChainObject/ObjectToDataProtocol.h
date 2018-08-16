//
//  ObjectToDataProtocol.h
//  BitsharesWallet
//
//  Created by flh on 2018/8/15.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ObjectToDataProtocol <NSObject>



/**
 生成用于websocket广播的Dictionary

 @return NSString | NSDictionary | NSArray
 */
- (id)generateToTransferObject;

/**
 从websocket获取对象转化

 @param object NSString | NSDictionary | NSArray 类
 @return 该对象
 */
+ (instancetype)generateFromObject:(id)object;

@optional

- (NSInteger)dataSize;

- (NSData *)transformToData;

@end
