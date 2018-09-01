//
//  PlainKey.m
//  BitsharesWallet
//
//  Created by flh on 2018/8/20.
//  Copyright © 2018年 flh. All rights reserved.
//

#import "PlainKey.h"

#import "PublicKey.h"
#import "PrivateKey.h"

#import "NSData+HashData.h"
#import "NSData+CopyWithRange.h"
#import "NSData+Base16.h"

#import "PackData.h"

@interface PlainKey ()

@property (nonatomic, copy) NSString *cipherKey;

@property (nonatomic, strong) NSMutableDictionary <PublicKey *,PrivateKey *>*keyDic;

@property (nonatomic, copy) NSString *password;

@end

@implementation PlainKey

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.keyDic = [NSMutableDictionary dictionary];
    }
    return self;
}

- (instancetype)initWithCipherKey:(NSString *)cipherKey {
    if (self = [self init]) {
        self.cipherKey = cipherKey;
    }
    return self;
}

- (BOOL)unlockWithPassword:(NSString *)password {
    NSData *sha512Data = [[password dataUsingEncoding:4] sha512Data];
    
    NSData *baseData = [[[NSData alloc] initWithBase16EncodedString:self.cipherKey options:0] aes256Decrypt:[sha512Data copyWithRange:NSMakeRange(0, 32)] ivData:[sha512Data copyWithRange:NSMakeRange(32, 16)]];
    
    int dataSize;
    
    NSInteger size = [PackData unpackUnsignedIntegerWithData:baseData byteLength:&dataSize];
    
    NSData *checkSum = [baseData copyWithRange:NSMakeRange(baseData.length - sha512Data.length, sha512Data.length)];
    
    BOOL result = [checkSum isEqualToData:sha512Data];
    
    if (!result) return NO;
    
    _password = password;
    
    _keyDic = [NSMutableDictionary dictionaryWithCapacity:size];
    
    NSData *data = [baseData copyWithRange:NSMakeRange(dataSize, baseData.length - dataSize - checkSum.length)];
    
    int publicKeyDataLength = 33;

    while (data.length > publicKeyDataLength) {
        NSData *publicData = [data copyWithRange:NSMakeRange(0, publicKeyDataLength)];
        
        data = [data copyWithRange:NSMakeRange(publicKeyDataLength, data.length - publicKeyDataLength)];
        
        int finalSize;
        
        NSInteger stringSize = [PackData unpackUnsignedIntegerWithData:data byteLength:&finalSize];
        
        NSData *privateKeyStringData = [data copyWithRange:NSMakeRange(finalSize, stringSize)];
        
        PublicKey *pub = [[PublicKey alloc] initWithKeyData:publicData];
        PrivateKey *privateKey = [[PrivateKey alloc] initWithPrivateKey:[[NSString alloc] initWithData:privateKeyStringData encoding:4]];
        
        _keyDic[pub] = privateKey;
        
        data = [data copyWithRange:NSMakeRange(finalSize + stringSize, data.length - (finalSize + stringSize))];
    }
    
    NSAssert(data.length == 0, @"Data size not correct");
    
    return YES;
}

- (BOOL)lockWithPassword:(NSString *)password {
    if (password.length == 0) {
        password = self.password;
    }
    
    if (password.length == 0) return NO;
    
    NSData *sha512Data = [[password dataUsingEncoding:4] sha512Data];
    
    NSMutableData *data = [NSMutableData dataWithCapacity:200];
    
    [data appendData:[PackData packUnsigedInteger:self.keyDic.count]];
    
    for (PublicKey *public in self.keyDic.allKeys) {
        [data appendData:public.keyData];
        NSData *privateData = [self.keyDic[public].description dataUsingEncoding:4];
        [data appendData:[PackData packUnsigedInteger:privateData.length]];
        [data appendData:privateData];
    }
    
    [data appendData:sha512Data];

    NSData *encryData = [data aes256Encrypt:[sha512Data copyWithRange:NSMakeRange(0, 32)] ivData:[sha512Data copyWithRange:NSMakeRange(32, 16)]];
    
    self.password = password;
    
    self.cipherKey = [encryData base16EncodedStringWithOptions:(NSDataBase16EncodingOptionsLowerCase)];
    
    [self.keyDic removeAllObjects];
    return YES;
}

- (void)addPrivateKey:(PrivateKey *)privateKey {
    _keyDic[privateKey.publicKey] = privateKey;
}

- (PrivateKey *)getPrivateKey:(PublicKey *)pubKey {
    return _keyDic[pubKey];
}

+ (instancetype)generateFromObject:(id)object {
    if (![object isKindOfClass:[NSString class]]) return nil;
    
    return [[self alloc] initWithCipherKey:object];
}

- (id)generateToTransferObject {
    [self lockWithPassword:nil];
    return self.cipherKey;
}

- (BOOL)isNew {
    return !(self.cipherKey || self.password);
}

@end
