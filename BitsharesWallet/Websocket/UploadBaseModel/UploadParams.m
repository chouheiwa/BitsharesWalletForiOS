//
//  UploadParams.m
//  BitsharesWallet
//
//  Created by flh on 2018/8/17.
//  Copyright © 2018年 flh. All rights reserved.
//

#import "UploadParams.h"

@implementation UploadParams

- (NSArray *)convertData {
    return @[@(self.apiId),self.methodName,self.totalParams];
}

@end
