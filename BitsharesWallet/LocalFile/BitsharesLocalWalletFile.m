//
//  BitsharesLocalWalletFile.m
//  BitsharesWallet
//
//  Created by flh on 2018/8/19.
//  Copyright © 2018年 flh. All rights reserved.
//

#import "BitsharesLocalWalletFile.h"
#import "BitsharesWalletError.h"

#import "NSObject+DataToObject.h"

#import "NSData+HashData.h"

#import "AccountObject.h"
#import "PublicKey.h"
#import "PrivateKey.h"

#import "PublicKeyAuthorityObject.h"

#import "WalletExtraKey.h"

#import "ObjectId.h"

@interface BitsharesLocalWalletFile ()

@property (nonatomic, assign) BOOL locked;

@property (nonatomic, assign) BOOL canSetPassword;

@property (nonatomic, strong) NSMutableDictionary *keyDic;

@end

@implementation BitsharesLocalWalletFile

- (instancetype)init {
    self = [super init];
    if (self) {
        self.locked = NO;
        self.cipher_keys = [[PlainKey alloc] init];
        
        self.my_accounts = @[];
        self.extra_keys = @[];
        self.pending_account_registrations = @[];
        self.pending_witness_registrations = @[];
        self.labeled_keys = @[];
        self.blind_receipts = @[];
    }
    return self;
}

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.locked = YES;
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setLocked:(BOOL)locked {
    _locked = locked;
    _canSetPassword = !locked;
}

- (BOOL)isLocked {
    return _locked;
}

- (BOOL)canSetPassword {
    return _canSetPassword;
}

- (BOOL)lockWithString:(NSString *)string {
    if ([self.cipher_keys lockWithPassword:string]) {
        self.locked = YES;
        return YES;
    }
    
    return NO;
}

- (BOOL)unlockWithString:(NSString *)string error:(NSError *__autoreleasing *)error {
    if (self.cipher_keys.isNew) {
        NSError *errors = [NSError errorWithDomain:@"Wallet file is new!Need to set password first" code:WebsocketErrorCodeWalletNotSet userInfo:nil];
        
        if (error) {
            *error = errors;
        }
        
        return NO;
    }
    
    BOOL result = [self.cipher_keys unlockWithPassword:string];
    
    if (!result) {
        NSError *errors = [NSError errorWithDomain:@"Wallet unlock error" code:WebsocketErrorCodeWalletUnlockError userInfo:nil];
        
        if (error) {
            *error = errors;
        }
    }else {
        self.locked = NO;
    }
    
    return result;
}

- (BOOL)importKey:(PrivateKey *)key ForAccount:(AccountObject *)account error:(NSError *__autoreleasing *)error {
    
    
    PublicKey *public = key.publicKey;
    
    if ([account containPublicKey:public]) {
        [self.cipher_keys addPrivateKey:key];
        
        NSMutableArray *array = [self.my_accounts mutableCopy];
        
        if (![array containsObject:account]) {
            [array addObject:account];
        }
        
        self.my_accounts = array;
        
        __block BOOL contain = NO;
        
        [self.extra_keys enumerateObjectsUsingBlock:^(WalletExtraKey * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.keyId.generateToTransferObject isEqualToString:account.identifier.generateToTransferObject]) {
                if (![obj containPublicKey:public]) {
                    NSMutableArray *pubArray = obj.keyArray.mutableCopy;
                    
                    [pubArray addObject:public];
                    
                    obj.keyArray = pubArray;
                }
                
                contain = YES;
                
                *stop = YES;
            }
        }];
        
        if (!contain) {
            NSMutableArray *dataArray = [NSMutableArray arrayWithArray:self.extra_keys];
            
            WalletExtraKey *extra = [[WalletExtraKey alloc] init];
            
            extra.keyId = account.identifier;
            
            extra.keyArray = @[public];
            
            [dataArray addObject:extra];
            
            self.extra_keys = dataArray;
        }
        
        return YES;
    }
    
    if (error) {
        *error = [NSError errorWithDomain:[NSString stringWithFormat:@"Private key %@ is not owner by account %@",key.description,account.name] code:WebsocketErrorCodeWalletKeyAccountError userInfo:nil];
    }
    
    return NO;
}

- (PrivateKey *)getPrivateKeyFromPublicKey:(PublicKey *)publicKey error:(NSError *__autoreleasing *)error {
    if ([self judgeLockedWithError:error]) return nil;
    
    return [self.cipher_keys getPrivateKey:publicKey];
}

- (BOOL)judgeLockedWithError:(NSError **)error {
    if (self.isLocked) {
        if (error) {
            *error = [NSError errorWithDomain:@"Wallet locked!" code:WebsocketErrorCodeWalletLockedError userInfo:nil];
        }
        
        return YES;
    }
    return NO;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([value isKindOfClass:[NSNull class]]) return;

    if ([key isEqualToString:@"my_accounts"]) {
        [super setValue:[AccountObject generateFromDataArray:value] forKey:key];
        return;
    }
    
    if ([key isEqualToString:@"extra_keys"]) {
        NSArray *array = [WalletExtraKey generateFromDataArray:value];
        
        [super setValue:array forKey:key];
        return;
    }
    
    id obj = [self defaultGetValue:value forKey:key];
    
    if (!obj) obj = value;
    
    [super setValue:obj forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (instancetype)generateFromObject:(NSDictionary *)object {
    if (![object isKindOfClass:[NSDictionary class]]) return nil;
    
    return [[self alloc] initWithDic:object];
}

- (id)generateToTransferObject {
    NSMutableDictionary *dic = [[self defaultGetDictionary] mutableCopy];
    
    dic[@"locked"] = nil;
    
    dic[@"canSetPassword"] = nil;
    
    return dic;
}

@end
