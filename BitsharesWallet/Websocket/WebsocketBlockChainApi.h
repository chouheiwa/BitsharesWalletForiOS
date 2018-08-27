//
//  WebsocketBlockChainApi.h
//  BitsharesWallet
//
//  Created by flh on 2018/8/19.
//  Copyright © 2018年 flh. All rights reserved.
//
#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,WebsocketBlockChainApi) {
    WebsocketBlockChainApiNormal = 1,//区块链关闭状态
    WebsocketBlockChainApiDataBase,//区块链连接状态
    WebsocketBlockChainApiNetworkBroadcast,
    WebsocketBlockChainApiHistory
};
typedef NS_ENUM(NSInteger,WebsocketConnectStatus) {
    WebsocketConnectStatusClosed,//区块链关闭状态
    WebsocketConnectStatusConnecting,//区块链连接状态
    WebsocketConnectStatusConnected
};
