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
#import "AssetAmountObject.h"
#import "ChainDynamicGlobalProperties.h"

#import "SignedTransaction.h"
#import "Memo.h"
#import "AccountOptionObject.h"

#import "BrainKey.h"

typedef void (^ErrorDone) (NSError *error);

typedef void(^SignedTransactionDone)(SignedTransaction *signedTransaction);

@interface BitsharesWalletObject : NSObject

@property (nonatomic, copy) void (^connectStatusChange)(WebsocketConnectStatus status);

@property (nonatomic, copy, readonly) NSString *connectedUrl;

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

- (PrivateKey *)getPrivateKey:(PublicKey *)key;

/**
 连接到指定url

 @param url url
 @param timeOut 超时时间
 @param connectedError 错误
 */
- (void)connectUrl:(NSString *)url timeOut:(NSTimeInterval)timeOut connectedError:(ErrorDone)connectedError;

/**
 发送调用Api命令

 @param chainApi 需要调用api列表
 @param method 调用方法(call|notice)
 @param uploadParams 上传参数
 @param callBack 所需回调
 */
- (void)sendWithChainApi:(WebsocketBlockChainApi)chainApi method:(WebsocketBlockChainMethodApi)method params:(UploadParams *)uploadParams callBack:(CallBackModel *)callBack;

/**
 根据id获取区块链指定参数

 @param object 需要获取参数的id
 @param success 成功回调
 @param error 失败回调(超时不会回调)
 */
- (void)getObject:(ObjectId *)object success:(void(^)(id result))success error:(ErrorDone)error;

/**
 根据账户名获取账户对象

 @param accountIdOrName 账户名或者账户id(@"1.2.n")
 @param success 成功回调
 @param error 失败回调
 */
- (void)getAccount:(NSString *)accountIdOrName success:(void(^)(AccountObject *result))success error:(ErrorDone)error;

/**
 获取指定账户余额

 @param account 账户对象
 @param success 成功回调
 @param error 失败回调
 */
- (void)listAccountBalance:(AccountObject *)account success:(void (^) (NSArray <AssetAmountObject *>*))success error:(ErrorDone)error;

/**
 获取区块链资产列表

 @param lowerBounds <#lowerBounds description#>
 @param nLimit 限制数量(最大数量100)
 @param success 成功回调
 @param error 失败回调
 */
- (void)listAssets:(NSString *)lowerBounds nLimit:(NSInteger)nLimit success:(void (^) (NSArray <AssetObject *>*result))success error:(ErrorDone)error;

/**
 获取指定名称资产

 @param assetIdOrName 资产名称或id(1.3.n)
 @param success 成功回调
 @param error 失败回调
 */
- (void)getAsset:(NSString *)assetIdOrName success:(void(^)(AssetObject *result))success error:(ErrorDone)error;

/**
 根据id获取资产对象[1.3.n]

 @param assetIds 资产数组
 @param success 成功回调
 @param error 失败回调
 */
- (void)getAssets:(NSArray <ObjectId *>*)assetIds success:(void (^)(NSArray <AssetObject *>*))success error:(ErrorDone)error;

/**
 获取全局可变参数(最新区块信息等参数)

 @param success 成功回调
 @param error 失败回调
 */
- (void)getDynamicGlobalPropertiesWithSuccess:(void(^)(ChainDynamicGlobalProperties *result))success error:(ErrorDone)error;

/**
 获取基准手续费费率表(id:2.0.0)部分参数

 @param success 成功回调
 @param error 失败回调
 @param lazyLoad 是否读取本地缓存(只有当读取过一遍，并且再次读取的时候才可能不请求网络)
 */
- (void)getOperationBaseFeeObjectWithSuccess:(void (^) (id result))success error:(ErrorDone)error lazyLoad:(BOOL)lazyLoad;

/**
 转账

 @param fromAccount 转账发起账户
 @param toAccount 转账接收账户
 @param assetAmount 转账数量 (可通过AssetObject [-getAmountFromNormalFloatString:]获得真实数量)
 @param memo 转账备注(用自己的memo_key(私钥)加对方的memo_key(做加密))
 @param feePayingAsset 手续费支付币种(不能传空)
 @param success 成功回调
 @param error 失败回调
 */
- (void)transferFromAccount:(AccountObject *)fromAccount toAccount:(AccountObject *)toAccount assetAmount:(AssetAmountObject *)assetAmount memo:(NSString *)memo feePayingAsset:(AssetObject *)feePayingAsset success:(SignedTransactionDone)success error:(ErrorDone)error;

/**
 挂单

 @param account 挂单账户
 @param amountToSell 挂单希望卖出资产
 @param minToReceive 挂单最少希望收到资产
 @param expirationDate 超期时间
 @param fillOrKill 是否允许被多单填补
 @param feeAsset 手续费支付币种
 @param success 成功回调
 @param error 失败回调
 */
- (void)sellAssetFromAccount:(AccountObject *)account amountToSell:(AssetAmountObject *)amountToSell minToReceiveAsset:(AssetAmountObject *)minToReceive expirationDate:(NSDate *)expirationDate fillOrKill:(BOOL)fillOrKill feeAsset:(AssetObject *)feeAsset success:(SignedTransactionDone)success error:(ErrorDone)error;

/**
 获取一个随机公私钥对

 @return 包含速记词的公私钥对
 */
- (BrainKey *)suggestBrainKey;

/**
 根据速记词解析出公私钥

 @param brainKey 速记词
 @return 包含速记词的公私钥对
 */
- (BrainKey *)deriveKeyWithBrainKey:(NSString *)brainKey;

- (NSArray <AccountObject *> *)myaccounts;

@end
