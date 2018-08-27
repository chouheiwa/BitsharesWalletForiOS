//
//  BitsharesLocalWalletFile.h
//  BitsharesWallet
//
//  Created by flh on 2018/8/19.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectToDataProtocol.h"
#import "AccountObject.h"
#import "WalletExtraKey.h"
#import "PlainKey.h"

#import "AccountObject.h"

@interface BitsharesLocalWalletFile : NSObject<ObjectToDataProtocol>

@property (nonatomic, copy) NSString *chain_id;

@property (nonatomic, copy) NSArray <AccountObject *>*my_accounts;

@property (nonatomic, strong) PlainKey *cipher_keys;

@property (nonatomic, copy) NSArray <WalletExtraKey *>*extra_keys;

@property (nonatomic, copy) NSArray *pending_account_registrations;

@property (nonatomic, copy) NSArray *pending_witness_registrations;

@property (nonatomic, copy) NSArray *labeled_keys;

@property (nonatomic, copy) NSArray *blind_receipts;

@property (nonatomic, copy) NSString *ws_server;

@property (nonatomic, copy) NSString *ws_user;

@property (nonatomic, copy) NSString *ws_password;

- (BOOL)isLocked;

- (BOOL)canSetPassword;

- (BOOL)unlockWithString:(NSString *)string error:(NSError **)error;

- (BOOL)lockWithString:(NSString *)string;

- (BOOL)importKey:(PrivateKey *)key ForAccount:(AccountObject *)account error:(NSError **)error;

- (PrivateKey *)getPrivateKeyFromPublicKey:(PublicKey *)publicKey error:(NSError **)error;

@end
