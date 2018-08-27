//
//  BitsharesWalletError.h
//  BitsharesWallet
//
//  Created by flh on 2018/8/19.
//  Copyright © 2018年 flh. All rights reserved.
//
#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,WebsocketErrorCode) {
    //连接异常(连接中断或尚未连接)
    //Connected Error
    WebsocketErrorCodeNotConnected,
    WebsocketErrorCodeApiNotFound,
    WebsocketErrorCodeWalletFileNotFound,
    WebsocketErrorCodeWalletFileFormatWrong,
    WebsocketErrorCodeWalletLoadExceptionRaise,
    WebsocketErrorCodeWalletNotSet,
    WebsocketErrorCodeWalletUnlockError,
    WebsocketErrorCodeWalletLockedError,
    WebsocketErrorCodeWalletKeyAccountError,
    
    WebsocketErrorCodeBroadcastErrorNotKnown,
    WebsocketErrorCodeBroadcastInsufficientBalance = 100000,//余额不足
    
    WebsocketErrorCodeBroadcastMissingRequiredActiveAuthority = 3030001,//缺少校验权限
    WebsocketErrorCodeBroadcastMissingRequiredOwnerAuthority,
    WebsocketErrorCodeBroadcastMissingRequiredOtherAuthority,
    WebsocketErrorCodeBroadcastInsufficientFee = 3030007,
    
    
};
