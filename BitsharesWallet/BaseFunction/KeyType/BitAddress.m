//
//  BitAddress.m
//  BitsharesWallet
//
//  Created by flh on 2018/8/17.
//  Copyright © 2018年 flh. All rights reserved.
//

#import "BitAddress.h"
#import "PublicKey.h"
#import "NSData+HashData.h"
#import "BaseConfig.h"
#import "Base58Object.h"

@interface BitAddress ()

@property (nonatomic, strong) NSString *addressString;

@end

@implementation BitAddress

- (instancetype)initWithKeyData:(NSData *)keyData {
    if (self = [super init]) {
        _keyData = [[keyData sha512Data] RIPEMD160Data];
        
        _addressString = [Base58Object encodeWithRIPEMD160CheckSum:_keyData];
    }
    
    return self;
}

- (instancetype)initWithBitAddressString:(NSString *)bitAddressString {
    if (self = [super init]) {
        _addressString = bitAddressString;
        
        _keyData = [Base58Object decodeWithRIPEMD160Base58StringCheckSum:bitAddressString];
    }
    return self;
}

- (instancetype)initWithAllBitAddressString:(NSString *)allBitAddressString {
    allBitAddressString = [allBitAddressString substringFromIndex:[BaseConfig prefix].length];
    
    return [self initWithBitAddressString:allBitAddressString];
}

- (instancetype)initWithPublicKey:(PublicKey *)publicKey {
    if (self = [super init]) {
        _keyData = [[publicKey.keyData sha512Data] RIPEMD160Data];
        
        _addressString = [Base58Object encodeWithRIPEMD160CheckSum:_keyData];
    }
    
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@%@",[BaseConfig prefix],_addressString];
}

@end
