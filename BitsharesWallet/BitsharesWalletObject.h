//
//  BitsharesWalletObject.h
//  BitsharesWallet
//
//  Created by flh on 2018/8/19.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BitsharesWalletError.h"
#import "WebsocketBlockChainApi.h"
#import "UploadParams.h"
#import "UploadBaseModel.h"
#import "CallBackModel.h"

#import "ObjectId.h"
#import "AccountObject.h"
#import "AssetObject.h"
#import "ChainDynamicGlobalProperties.h"

#import "SignedTransaction.h"
#import "Memo.h"
#import "AccountOptionObject.h"

@interface BitsharesWalletObject : NSObject

@property (nonatomic, copy) void (^connectStatusChange)(WebsocketConnectStatus status);

- (instancetype)initWithChainId:(NSString *)chainId prefix:(NSString *)prefix;

- (void)setPassword:(NSString *)password error:(NSError **)error;

- (void)unlockPassword:(NSString *)password error:(NSError **)error;
/**
 从本地文件中读取钱包

 @param path 读取钱包路径
 @param error 错误时返回error
 @return 读取结果
 */
- (BOOL)loadLocalWalletFileFromPath:(NSString *)path error:(NSError **)error;
/**
 将钱包文件存入本地
 
 @param path 存入钱包路径
 @param error 错误时返回error
 @return 保存结果
 */
- (BOOL)saveWalletFileAtPath:(NSString *)path error:(NSError **)error;

/**
 导入账户和私钥

 @param privateKey 私钥
 @param account 账户对象
 @param error 错误
 @return 导入成功或失败
 */
- (BOOL)importKey:(PrivateKey *)privateKey forAccount:(AccountObject *)account error:(NSError **)error;

- (void)connectUrl:(NSString *)url timeOut:(NSTimeInterval)timeOut connectedError:(void (^)(NSError *))connectedError;

- (void)sendWithChainApi:(WebsocketBlockChainApi)chainApi method:(WebsocketBlockChainMethodApi)method params:(UploadParams *)uploadParams callBack:(CallBackModel *)callBack;

- (void)getObject:(ObjectId *)object success:(void(^)(id result))success error:(void(^)(NSError *error))error;

- (void)getAccount:(NSString *)accountIdOrName success:(void(^)(AccountObject *result))success error:(void(^)(NSError *error))error;

- (void)getAsset:(NSString *)assetIdOrName success:(void(^)(AssetObject *result))success error:(void(^)(NSError *error))error;

- (void)getDynamicGlobalPropertiesWithSuccess:(void(^)(ChainDynamicGlobalProperties *result))success error:(void(^)(NSError *error))error;

- (void)getOperationBaseFeeObjectWithSuccess:(void (^) (id result))success error:(void (^) (NSError *error))error lazyLoad:(BOOL)lazyLoad;

- (void)transferFromAccount:(AccountObject *)fromAccount toAccount:(AccountObject *)toAccount assetAmount:(AssetAmountObject *)assetAmount memo:(NSString *)memo feePayingAsset:(AssetObject *)feePayingAsset success:(void (^) (SignedTransaction *))success error:(void (^) (NSError *))error;

- (NSArray <AccountObject *> *)myaccounts;

@end
