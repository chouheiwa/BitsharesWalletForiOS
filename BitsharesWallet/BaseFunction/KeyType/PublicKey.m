//
//  PublicKey.m
//  BitsharesWallet
//
//  Created by flh on 2018/8/13.
//  Copyright © 2018年 flh. All rights reserved.
//

#include <assert.h>

#import "PublicKey.h"
#import "Base58Object.h"
#import "secp256k1.h"
#import "NSData+Base16.h"
#import "BaseConfig.h"
@interface PublicKey ()

@property (nonatomic, copy) NSString *publickKeyString;

@end

@implementation PublicKey

+ (secp256k1_context_t *)getBaseContext {
    static secp256k1_context_t* ctx = NULL;
    
    if (ctx == NULL) {
        ctx = secp256k1_context_create(SECP256K1_CONTEXT_VERIFY | SECP256K1_CONTEXT_SIGN | SECP256K1_CONTEXT_RANGEPROOF | SECP256K1_CONTEXT_COMMIT );
    }
    
    return ctx;
}

- (instancetype)initWithSignCompactSigntures:(NSString *)signCompactSigntures sha256Data:(NSData *)sha256Data checkCanonical:(BOOL)checkCanonical {
    NSData *data = [[NSData alloc] initWithBase16EncodedString:signCompactSigntures options:0];
    
    return [self initWithSignCompactData:data sha256Data:sha256Data checkCanonical:checkCanonical];
}

- (instancetype)initWithSignCompactData:(NSData *)signCompactData sha256Data:(NSData *)sha256Data checkCanonical:(BOOL)checkCanonical {
    if (self = [super init]) {
        int nV = ((char *)signCompactData.bytes)[0];
        
        assert(nV > 26 && nV < 34);
        
        if (checkCanonical) {
            assert([PublicKey isCanonical:(Byte *)signCompactData.bytes]);
        }
        
        Byte *bytes = (Byte *)malloc(33);
        
        unsigned int pkLength;
        
        int result = secp256k1_ecdsa_recover_compact( [PublicKey getBaseContext], (unsigned char*) sha256Data.bytes, (unsigned char*) (signCompactData.bytes + 1), (unsigned char*) bytes, (int*) &pkLength, 1, (nV - 27) & 3 );
        
        assert(result == 1);
        assert(pkLength == 33);
        
        _keyData = [NSData dataWithBytes:bytes length:33];
        
        self.publickKeyString = [Base58Object encodeWithRIPEMD160CheckSum:_keyData];
    }
    return self;
}

- (instancetype)initWithKeyData:(NSData *)keyData {
    if (self = [super init]) {
        _keyData = [keyData copy];
        
        self.publickKeyString = [Base58Object encodeWithRIPEMD160CheckSum:keyData];
    }
    return self;
}

- (instancetype)initWithPubkeyString:(NSString *)pubKeyString {
    if (self = [super init]) {
        _keyData = [Base58Object decodeWithRIPEMD160Base58StringCheckSum:pubKeyString];
        self.publickKeyString = pubKeyString;
    }
    return self;
}

- (instancetype)initWithAllPubkeyString:(NSString *)pubKeyString {
    pubKeyString = [pubKeyString substringFromIndex:[BaseConfig prefix].length];
    
    return [self initWithPubkeyString:pubKeyString];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@%@",[BaseConfig prefix],self.publickKeyString];
}

+ (BOOL)isCanonical:(Byte *)datas {
    Byte *data = (Byte *)datas;
    
    return !(data[1] & 0x80) && !(data[1] == 0 && !(data[2] & 0x80)) && !(data[33] & 0x80) && !(data[33] == 0 && !(data[34] & 0x80));
}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[NSString class]]) {
        NSData *data = [Base58Object decodeWithSha256Base58StringCheckSum:object];
        
        return [data isEqualToData:self.keyData];
    }
    
    if ([object isKindOfClass:[NSData class]]) {
        return [self.keyData isEqualToData:object];
    }
    
    if ([object isKindOfClass:[self class]]) {
        return [self.keyData isEqualToData:((PublicKey *)object).keyData];
    }
    return NO;
}

@end
