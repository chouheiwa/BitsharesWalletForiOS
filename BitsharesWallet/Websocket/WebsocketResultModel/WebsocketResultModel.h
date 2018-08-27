//
//  WebsocketResultModel.h
//  BitsharesWallet
//
//  Created by flh on 2018/8/17.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebsocketResultModel : NSObject

@property (nonatomic, strong) NSNumber *identifier;

@property (nonatomic, strong) id result;

@property (nonatomic, assign) BOOL isNotice;

@property (nonatomic, strong) NSError *error;

+ (instancetype)modelToDic:(NSDictionary *)dic;

@end
