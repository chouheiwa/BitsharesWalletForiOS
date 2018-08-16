//
//  WebsocketClient.m
//  BitsharesWallet
//
//  Created by flh on 2018/8/14.
//  Copyright © 2018年 flh. All rights reserved.
//

#import "WebsocketClient.h"
#import <SocketRocket.h>

@interface WebsocketClient ()<SRWebSocketDelegate>

@end

@implementation WebsocketClient

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    
}
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    
}
- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    
}

@end
