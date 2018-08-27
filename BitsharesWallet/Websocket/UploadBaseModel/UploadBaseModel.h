//
//  UploadBaseModel.h
//  BitsharesWallet
//
//  Created by flh on 2018/8/17.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UploadParams;

typedef NS_ENUM(NSInteger,WebsocketBlockChainMethodApi) {
    WebsocketBlockChainMethodApiCall,//
    WebsocketBlockChainMethodApiNotice,//区块链连接状态
};

@interface UploadBaseModel : NSObject

@property (nonatomic, assign) WebsocketBlockChainMethodApi method;

@property (nonatomic, assign) NSInteger identifier;

@property (nonatomic, strong) UploadParams *params;

- (NSDictionary *)convertData;

@end
