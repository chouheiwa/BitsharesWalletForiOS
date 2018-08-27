//
//  UploadParams.h
//  BitsharesWallet
//
//  Created by flh on 2018/8/17.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UploadParams : NSObject

@property (nonatomic, assign) NSInteger apiId;

@property (nonatomic, copy) NSString *methodName;

@property (nonatomic, copy) NSArray *totalParams;

- (NSArray *)convertData;

@end
