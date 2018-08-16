//
//  OperationContent.h
//  BitsharesWallet
//
//  Created by flh on 2018/8/16.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectToDataProtocol.h"
@class BaseOperation;


@interface OperationContent : NSObject<ObjectToDataProtocol>

@property (nonatomic, assign, readonly) NSInteger operationType;

@property (nonatomic, strong, readonly) id operationContent;

- (instancetype)initWithOperation:(BaseOperation *)operation;

@end
