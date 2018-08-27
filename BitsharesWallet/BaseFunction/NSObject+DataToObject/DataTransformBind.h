//
//  DataTransformBind.h
//  BitsharesWallet
//
//  Created by flh on 2018/8/19.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataTransformBind : NSObject

@property (nonatomic, copy) NSString *className;

@property (nonatomic, assign) BOOL transformBySelf;

@property (nonatomic, copy) NSDictionary *fromJsonDic;

@property (nonatomic, copy) NSDictionary *toJsonDic;

@end
