//
//  WebsocketClient.h
//  BitsharesWallet
//
//  Created by flh on 2018/8/14.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,WebsocketConnectStatus) {
    WebsocketConnectStatusClosed,//区块链关闭状态
    WebsocketConnectStatusConnecting,//区块链连接状态
    WebsocketConnectStatusConnected
};

typedef NS_ENUM(NSInteger,WebsocketBlockChainApi) {
    WebsocketBlockChainApiNormal,//区块链关闭状态
    WebsocketBlockChainApiDataBase,//区块链连接状态
    WebsocketBlockChainApiNetworkBroadcast,
    WebsocketBlockChainApiHistory
};

typedef NS_ENUM(NSInteger,WebsocketBlockChainMethodApi) {
    WebsocketBlockChainMethodApiCall,//
    WebsocketBlockChainMethodApiNotice,//区块链连接状态
};

@interface WebsocketClient : NSObject

/**
 ConnectStatus
 区块链连接状态:标志着和区块链的连接状态
 */
@property (nonatomic, assign, readonly) WebsocketConnectStatus connectStatus;



@end
