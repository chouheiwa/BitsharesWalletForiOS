//
//  WebsocketClient.h
//  BitsharesWallet
//
//  Created by flh on 2018/8/14.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BitsharesWalletError.h"
#import "WebsocketBlockChainApi.h"
#import "UploadBaseModel.h"
@class CallBackModel;
@class UploadParams;



@interface WebsocketClient : NSObject

/**
 ConnectStatus
 区块链连接状态:标志着和区块链的连接状态
 KVO监听
 */
@property (nonatomic, assign, readonly) WebsocketConnectStatus connectStatus;

@property (nonatomic, copy) void (^connectStatusChange)(WebsocketConnectStatus connectStatus);

@property (nonatomic, copy, readonly) NSString *connectedUrl;

- (instancetype)initWithUrl:(NSString *)url closedCallBack:(void (^) (NSError *error))closedCallBack;

- (void)connectWithTimeOut:(NSTimeInterval)timeOut;

- (void)sendWithChainApi:(WebsocketBlockChainApi)chainApi method:(WebsocketBlockChainMethodApi)method params:(UploadParams *)uploadParams callBack:(CallBackModel *)callBack;

@end
