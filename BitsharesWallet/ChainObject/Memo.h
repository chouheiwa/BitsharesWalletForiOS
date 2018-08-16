//
//  Memo.h
//  BitsharesWallet
//
//  Created by flh on 2018/8/15.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectToDataProtocol.h"

@class PublicKey;
@class PrivateKey;

@interface Memo : NSObject<ObjectToDataProtocol>

@property (nonatomic, strong, readonly) PublicKey *from;

@property (nonatomic, strong, readonly) PublicKey *to;

- (instancetype)initWithSend:(BOOL)isSend privateKey:(PrivateKey *)priKey anotherPublickKey:(PublicKey *)anotherPubKey customerNonce:(NSString *)customerNonce totalMessage:(NSString *)totalMessage;

- (NSString *)getMessageWithPrivateKey:(PrivateKey *)privateKey;

@end
