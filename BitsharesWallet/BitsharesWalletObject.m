//
//  BitsharesWalletObject.m
//  BitsharesWallet
//
//  Created by flh on 2018/8/19.
//  Copyright © 2018年 flh. All rights reserved.
//

#import "BitsharesWalletObject.h"
#import "BaseConfig.h"
#import "WebsocketClient.h"

#import "ObjectId.h"
#import "BitsharesLocalWalletFile.h"
#import "AuthorityObject.h"

#import "NSObject+DataToObject.h"

#import "TransferOperation.h"
#import "LimitOrderCreateOperation.h"

@interface BitsharesWalletObject ()

@property (nonatomic, strong) WebsocketClient *client;

@property (nonatomic, strong) BitsharesLocalWalletFile *walletFile;

@property (nonatomic, copy) NSDictionary *feeDictionary;

@end

@implementation BitsharesWalletObject

- (instancetype)initWithChainId:(NSString *)chainId prefix:(NSString *)prefix {
    if (self = [super init]) {
        [BaseConfig setPrefix:prefix];
        [BaseConfig setChainId:chainId];
        
        _walletFile = [[BitsharesLocalWalletFile alloc] init];
        
        _walletFile.chain_id = chainId;
    }
    return self;
}

- (BOOL)judgeCanUseWithError:(NSError **)error {
    if (self.walletFile.isLocked) {
        if (error) {
            *error = [NSError errorWithDomain:@"Wallet Locked Error,you should use function unlock" code:WebsocketErrorCodeWalletLockedError userInfo:nil];
        }
    }
    return YES;
}

- (void)setPassword:(NSString *)password error:(NSError *__autoreleasing *)error {
    if ([self.walletFile canSetPassword]) {
        [self.walletFile lockWithString:password];
        return;
    }
    if (error) {
        *error = [NSError errorWithDomain:@"Wallet Set Password Error" code:WebsocketErrorCodeWalletLockedError userInfo:nil];
    }
}

- (void)unlockPassword:(NSString *)password error:(NSError *__autoreleasing *)error {
    [self.walletFile unlockWithString:password error:error];
}

- (BOOL)loadLocalWalletFileFromPath:(NSString *)path error:(NSError *__autoreleasing *)error {
    @try {
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        if (!data) {
            if (error) {
                *error = [NSError errorWithDomain:[NSString stringWithFormat:@"File not exists at path:%@",path] code:WebsocketErrorCodeWalletFileNotFound userInfo:nil];
            }
            
            return NO;
        }
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:error];
        
        if (!dic) {
            return NO;
        }
        
        _walletFile = [BitsharesLocalWalletFile generateFromObject:dic];
        
        if (!_walletFile) {
            if (error) {
                *error = [NSError errorWithDomain:[NSString stringWithFormat:@"File format is not right"] code:WebsocketErrorCodeWalletFileFormatWrong userInfo:nil];
            }
            
            return NO;
        }
        
        return YES;
    }@catch (NSException *exception) {
        // 捕获到的异常exception
        if (error) {
            *error = [NSError errorWithDomain:exception.reason code:WebsocketErrorCodeWalletLoadExceptionRaise userInfo:exception.userInfo];
        }
    }
    
    return NO;
}

- (BOOL)importKey:(PrivateKey *)privateKey forAccount:(AccountObject *)account error:(NSError *__autoreleasing *)error{
    return [self.walletFile importKey:privateKey ForAccount:account error:error];
}

- (PrivateKey *)getPrivateKey:(PublicKey *)key {
    return [self.walletFile getPrivateKeyFromPublicKey:key error:nil];
}

- (BOOL)saveWalletFileAtPath:(NSString *)path error:(NSError *__autoreleasing *)error {
    NSData *data = [NSJSONSerialization dataWithJSONObject:[self.walletFile generateToTransferObject] options:(NSJSONWritingPrettyPrinted) error:nil];
        
    return [data writeToFile:path options:(NSDataWritingAtomic) error:error];
}

- (void)connectUrl:(NSString *)url timeOut:(NSTimeInterval)timeOut connectedError:(void (^)(NSError *))connectedError {
    if (_client.connectStatus == WebsocketConnectStatusConnected) return;
    
    self.client = [[WebsocketClient alloc] initWithUrl:url closedCallBack:connectedError];
    
    [self.client connectWithTimeOut:timeOut];
    
    self.walletFile.ws_server = url;
    
    _connectedUrl = url;
}

- (void)setConnectStatusChange:(void (^)(WebsocketConnectStatus))connectStatusChange {
    _connectStatusChange = connectStatusChange;
    if (_client) {
        _client.connectStatusChange = connectStatusChange;
    }
}

- (void)setClient:(WebsocketClient *)client {
    _client = client;
    
    if (_connectStatusChange) {
        _client.connectStatusChange = _connectStatusChange;
    }
}

- (void)sendWithChainApi:(WebsocketBlockChainApi)chainApi method:(WebsocketBlockChainMethodApi)method params:(UploadParams *)uploadParams callBack:(CallBackModel *)callBack {
    [_client sendWithChainApi:chainApi method:method params:uploadParams callBack:callBack];
}

- (void)getObject:(ObjectId *)object success:(void (^)(id))success error:(void (^)(NSError *))error {
    UploadParams *uploadParams = [[UploadParams alloc] init];
    
    uploadParams.methodName = @"get_objects";
    
    uploadParams.totalParams = @[@[object.generateToTransferObject]];
    
    CallBackModel *callBackModel = [[CallBackModel alloc] init];
    
    callBackModel.successResult = ^(NSArray * result) {
        NSDictionary *dic = result.firstObject;
        
        success(dic);
    };
    
    callBackModel.errorResult = error;
    
    [self sendWithChainApi:WebsocketBlockChainApiDataBase method:(WebsocketBlockChainMethodApiCall) params:uploadParams callBack:callBackModel];
}

- (void)getAccount:(NSString *)accountIdOrName success:(void (^)(AccountObject *))success error:(void (^)(NSError *))error {
    ObjectId *object = [ObjectId generateFromObject:accountIdOrName];
    
    UploadParams *uploadParams = [[UploadParams alloc] init];
    
    if (object) {
        uploadParams.methodName = @"get_objects";
        
        uploadParams.totalParams = @[@[object.generateToTransferObject]];
    }else {
        uploadParams.methodName = @"lookup_account_names";
        
        uploadParams.totalParams = @[@[accountIdOrName]];
    }
    
    CallBackModel *callBackModel = [[CallBackModel alloc] init];
    
    callBackModel.successResult = ^(NSArray * result) {
        NSDictionary *dic = result.firstObject;
        
        success([AccountObject generateFromObject:dic]);
    };
    
    callBackModel.errorResult = error;
    
    [self sendWithChainApi:(WebsocketBlockChainApiDataBase) method:(WebsocketBlockChainMethodApiCall) params:uploadParams callBack:callBackModel];
}

- (void)listAccountBalance:(AccountObject *)account success:(void (^)(NSArray<AssetAmountObject *> *))success error:(ErrorDone)error {
    UploadParams *uploadParams = [[UploadParams alloc] init];
    
    uploadParams.methodName = @"get_account_balances";
    
    uploadParams.totalParams = @[account.identifier.generateToTransferObject,@[]];
    
    CallBackModel *callBackModel = [[CallBackModel alloc] init];
    
    callBackModel.successResult = ^(NSArray * result) {
        success([AssetAmountObject generateFromDataArray:result]);
    };
    
    [self sendWithChainApi:(WebsocketBlockChainApiDataBase) method:(WebsocketBlockChainMethodApiCall) params:uploadParams callBack:callBackModel];
}

- (void)listAssets:(NSString *)lowerBounds nLimit:(NSInteger)nLimit success:(void (^)(NSArray<AssetObject *> *))success error:(ErrorDone)error {
    UploadParams *uploadParams = [[UploadParams alloc] init];

    uploadParams.methodName = @"list_assets";
    
    uploadParams.totalParams = @[lowerBounds,@(nLimit)];
    
    CallBackModel *callBackModel = [[CallBackModel alloc] init];
    
    callBackModel.successResult = ^(NSArray * result) {
        success([AssetObject generateFromDataArray:result]);
    };
    
    callBackModel.errorResult = error;
    
    [self sendWithChainApi:(WebsocketBlockChainApiDataBase) method:(WebsocketBlockChainMethodApiCall) params:uploadParams callBack:callBackModel];
}

- (void)getAsset:(NSString *)assetIdOrName success:(void (^)(AssetObject *))success error:(void (^)(NSError *))error {
    ObjectId *object = [ObjectId generateFromObject:assetIdOrName];
    
    UploadParams *uploadParams = [[UploadParams alloc] init];
    
    if (object) {
        uploadParams.methodName = @"get_objects";
        
        uploadParams.totalParams = @[@[object.generateToTransferObject]];
    }else {
        uploadParams.methodName = @"lookup_asset_symbols";
        
        uploadParams.totalParams = @[@[assetIdOrName]];
    }
    
    CallBackModel *callBackModel = [[CallBackModel alloc] init];
    
    callBackModel.successResult = ^(NSArray * result) {
        NSDictionary *dic = result.firstObject;
        
        success([AssetObject generateFromObject:dic]);
    };
    
    callBackModel.errorResult = error;
    
    [self sendWithChainApi:(WebsocketBlockChainApiDataBase) method:(WebsocketBlockChainMethodApiCall) params:uploadParams callBack:callBackModel];
}

- (void)getAssets:(NSArray<ObjectId *> *)assetIds success:(void (^)(NSArray<AssetObject *> *))success error:(ErrorDone)error {
    UploadParams *uploadParams = [[UploadParams alloc] init];

    uploadParams.methodName = @"get_objects";
    
    uploadParams.totalParams = @[[NSObject generateToTransferArray:assetIds]];
    
    CallBackModel *callBackModel = [[CallBackModel alloc] init];
    
    callBackModel.successResult = ^(NSArray * result) {
        success([AssetObject generateFromDataArray:result]);
    };
    
    callBackModel.errorResult = error;
    
    [self sendWithChainApi:(WebsocketBlockChainApiDataBase) method:(WebsocketBlockChainMethodApiCall) params:uploadParams callBack:callBackModel];
}

- (void)getDynamicGlobalPropertiesWithSuccess:(void (^)(ChainDynamicGlobalProperties *))success error:(void (^)(NSError *))error {
    UploadParams *uploadParams = [[UploadParams alloc] init];
    
    uploadParams.methodName = @"get_dynamic_global_properties";
    
    uploadParams.totalParams = @[];
    
    CallBackModel *callBackModel = [[CallBackModel alloc] init];
    
    callBackModel.successResult = ^(id result) {
        success([ChainDynamicGlobalProperties generateFromObject:result]);
    };
    
    callBackModel.errorResult = error;
    
    [self sendWithChainApi:(WebsocketBlockChainApiDataBase) method:(WebsocketBlockChainMethodApiCall) params:uploadParams callBack:callBackModel];
}

- (void)getOperationBaseFeeObjectWithSuccess:(void (^)(id))success error:(void (^)(NSError *))error lazyLoad:(BOOL)lazyLoad {
    if (lazyLoad && self.feeDictionary) {
        success(self.feeDictionary);
        return;
    }
    
    UploadParams *uploadParams = [[UploadParams alloc] init];
    
    uploadParams.methodName = @"get_objects";
    
    uploadParams.totalParams = @[@[@"2.0.0"]];
    
    CallBackModel *callBackModel = [[CallBackModel alloc] init];
    
    callBackModel.successResult = ^(NSArray *result) {
        NSArray *feeArray = result.firstObject[@"parameters"][@"current_fees"][@"parameters"];
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:feeArray.count];
        
        for (NSArray *array in feeArray) {
            dic[array.firstObject] = array.lastObject;
        }
        
        self.feeDictionary = dic;
        
        success(dic);
    };
    
    callBackModel.errorResult = error;
    
    [self sendWithChainApi:WebsocketBlockChainApiDataBase method:(WebsocketBlockChainMethodApiCall) params:uploadParams callBack:callBackModel];
}

- (void)transferFromAccount:(AccountObject *)fromAccount toAccount:(AccountObject *)toAccount assetAmount:(AssetAmountObject *)assetAmount memo:(NSString *)memo feePayingAsset:(AssetObject *)feePayingAsset success:(SignedTransactionDone)success error:(void (^) (NSError *))error {
    NSError *errors;
    
    if (![self judgeCanUseWithError:&errors]) {
        error(errors);
        return;
    }
    
    TransferOperation *operation = [[TransferOperation alloc] init];
    
    operation.from = fromAccount.identifier;
    
    operation.to = toAccount.identifier;
    
    operation.amount = assetAmount;

    operation.requiredAuthority = fromAccount.active.publicKeys;
    
    if (memo.length > 0) {
        NSError *errors;
        
        PrivateKey *private = [self.walletFile getPrivateKeyFromPublicKey:fromAccount.options.memo_key error:&errors];
        
        if (!private) {
            if (!errors) {
                errors = [NSError errorWithDomain:[NSString stringWithFormat:@"Account %@ memo key %@ not found",fromAccount.name,fromAccount.options.memo_key] code:WebsocketErrorCodeWalletKeyAccountError userInfo:nil];
            }
            
            error(errors);
            return;
        }
        
        Memo *memoData = [[Memo alloc] initWithSend:YES privateKey:private anotherPublickKey:toAccount.options.memo_key customerNonce:nil totalMessage:memo];
        
        operation.memo = memoData;
    }
    
    [self getOperationBaseFeeObjectWithSuccess:^(NSDictionary *result) {
        operation.fee = [operation caculateFeeWithFeeDic:result[@(0)] payFeeAsset:feePayingAsset];
        
        OperationContent *content = [[OperationContent alloc] initWithOperation:operation];
        
        SignedTransaction *signedTran = [[SignedTransaction alloc] init];
        
        signedTran.operations = @[content];
        
        [self signedTransaction:signedTran success:success error:error];
    } error:error lazyLoad:YES];
}

- (void)sellAssetFromAccount:(AccountObject *)account amountToSell:(AssetAmountObject *)amountToSell minToReceiveAsset:(AssetAmountObject *)minToReceive expirationDate:(NSDate *)expirationDate fillOrKill:(BOOL)fillOrKill feeAsset:(AssetObject *)feeAsset success:(SignedTransactionDone)success error:(ErrorDone)error {
    NSError *errors;
    if (![self judgeCanUseWithError:&errors]) {
        error(errors);
        return;
    }
    
    LimitOrderCreateOperation *operation = [[LimitOrderCreateOperation alloc] init];
    
    operation.seller = account.identifier;
    
    operation.amount_to_sell = amountToSell;
    
    operation.min_to_receive = minToReceive;
    
    operation.expiration = expirationDate;
    
    operation.fill_or_kill = fillOrKill;
    
    [self getOperationBaseFeeObjectWithSuccess:^(NSDictionary *result) {
        operation.requiredAuthority = account.active.publicKeys;
        
        operation.fee = [operation caculateFeeWithFeeDic:result[@1] payFeeAsset:feeAsset];
        
        OperationContent *content = [[OperationContent alloc] initWithOperation:operation];
        
        SignedTransaction *signedTran = [[SignedTransaction alloc] init];
        
        signedTran.operations = @[content];
        
        [self signedTransaction:signedTran success:success error:error];
    } error:error lazyLoad:YES];
    
}

- (void)signedTransaction:(SignedTransaction *)signedTransaction success:(void (^) (SignedTransaction *))success error:(void (^) (NSError *))error {
    NSError *errors;
    if (![self judgeCanUseWithError:&errors]) {
        error(errors);
        return;
    }
    
    [self getDynamicGlobalPropertiesWithSuccess:^(ChainDynamicGlobalProperties *result) {
        [signedTransaction setRefBlock:result.head_block_id];
        signedTransaction.expiration = [result.time dateByAddingTimeInterval:30];
        
        for (PublicKey *key in [signedTransaction needSignedKeys]) {
            PrivateKey *priKey = [self.walletFile getPrivateKeyFromPublicKey:key error:nil];
            
            if (priKey) {
                [signedTransaction signWithPrikey:priKey];
            }
        }
        
        UploadParams *uploadParams = [[UploadParams alloc] init];
        
        uploadParams.methodName = @"broadcast_transaction";
        
        uploadParams.totalParams = @[signedTransaction.generateToTransferObject];
        
        CallBackModel *callBackModel = [[CallBackModel alloc] init];
        
        callBackModel.successResult = ^(id result) {
            success(signedTransaction);
        };
        
        callBackModel.errorResult = error;
        
        [self sendWithChainApi:WebsocketBlockChainApiNetworkBroadcast method:(WebsocketBlockChainMethodApiCall) params:uploadParams callBack:callBackModel];
        
    } error:error];
}

- (BrainKey *)deriveKeyWithBrainKey:(NSString *)brainKey {
    return [BrainKey deriveFromBrainKey:brainKey];
}

- (BrainKey *)suggestBrainKey {
    return [BrainKey suggestBrainKey];
}

- (NSArray <AccountObject *> *)myaccounts {
    return self.walletFile.my_accounts;
}
@end
