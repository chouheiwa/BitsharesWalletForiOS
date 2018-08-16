//
//  Memo.m
//  BitsharesWallet
//
//  Created by flh on 2018/8/15.
//  Copyright © 2018年 flh. All rights reserved.
//

#import "Memo.h"
#import "PublicKey.h"
#import "PrivateKey.h"
#import "NSData+HashData.h"
#import "NSData+CopyWithRange.h"
#import "NSData+Base16.h"
#import "PackData.h"
@interface Memo ()

@property (nonatomic, copy) NSString *nonce;

@property (nonatomic, copy) NSData *message;

@end

@implementation Memo

- (instancetype)initWithSend:(BOOL)isSend privateKey:(PrivateKey *)priKey anotherPublickKey:(PublicKey *)anotherPubKey customerNonce:(NSString *)customerNonce totalMessage:(NSString *)totalMessage {
    if (self = [super init]) {
        
        if ([customerNonce integerValue] == 0) {
            customerNonce = [NSString stringWithFormat:@"%u",arc4random()];
        }
        
        _nonce = customerNonce;
        
        if (isSend) {
            _from = [priKey publicKey];
            _to = anotherPubKey;
        }else {
            _from = [priKey publicKey];
            _to = anotherPubKey;
        }
        
        NSData *sha512SharedSecret = [priKey getSharedSecret:anotherPubKey];
        
        NSString *strNoncePlusSecret = [sha512SharedSecret base16EncodedStringWithOptions:(NSDataBase16EncodingOptionsLowerCase)];
        
        NSMutableData *customData = [[[NSString stringWithFormat:@"%@%@",_nonce,strNoncePlusSecret] dataUsingEncoding:NSASCIIStringEncoding] copy];
        
        sha512SharedSecret = [customData sha512Data];
        
        NSData *plainTestData = [totalMessage dataUsingEncoding:NSUTF8StringEncoding];
        
        NSData *checkSumData = [[plainTestData sha256Data] copyWithRange:NSMakeRange(0, 4)];
        
        customData = [NSMutableData dataWithCapacity:checkSumData.length + plainTestData.length];
        
        [customData appendData:checkSumData];
        
        [customData appendData:plainTestData];
        
        NSData *keyData = [sha512SharedSecret copyWithRange:NSMakeRange(0, 32)];
        
        NSData *ivData = [sha512SharedSecret copyWithRange:NSMakeRange(32, 16)];
        
        self.message = [customData aes256Encrypt:keyData ivData:ivData];
    }
    return self;
}

- (NSString *)getMessageWithPrivateKey:(PrivateKey *)privateKey {
    NSData *sha512SharedSecret = nil;
    
    if ([privateKey.publicKey isEqual:_from]) {
        sha512SharedSecret = [privateKey getSharedSecret:_to];
    }else if ([privateKey.publicKey isEqual:_to]) {
        sha512SharedSecret = [privateKey getSharedSecret:_from];
    }
    
    NSString *strNoncePlusSecret = [sha512SharedSecret base16EncodedStringWithOptions:(NSDataBase16EncodingOptionsLowerCase)];
    
    NSMutableData *customData = [[[NSString stringWithFormat:@"%@%@",_nonce,strNoncePlusSecret] dataUsingEncoding:NSASCIIStringEncoding] copy];
    
    sha512SharedSecret = [customData sha512Data];
    
    if (!sha512SharedSecret) return nil;
    
    NSData *keyData = [sha512SharedSecret copyWithRange:NSMakeRange(0, 32)];
    
    NSData *ivData = [sha512SharedSecret copyWithRange:NSMakeRange(32, 16)];
    
    NSData *decryptData = [self.message aes256Decrypt:keyData ivData:ivData];
    
    if (!decryptData) return nil;
    
    NSData *checkSumData = [decryptData copyWithRange:NSMakeRange(0, 4)];
    
    NSData *messageData = [decryptData copyWithRange:NSMakeRange(4, decryptData.length - 4)];
    
    NSData *sha256Data = [messageData sha256Data];
    
    if (![[sha256Data copyWithRange:NSMakeRange(0, 4)] isEqualToData:checkSumData]) return nil;
    
    return [[NSString alloc] initWithData:messageData encoding:NSUTF8StringEncoding];
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([value isKindOfClass:[NSNull class]]) return;
    
    if ([key isEqualToString:@"from"]) {
        _from = [[PublicKey alloc] initWithAllPubkeyString:value];
        
        return;
    }
    
    if ([key isEqualToString:@"to"]) {
        _to = [[PublicKey alloc] initWithAllPubkeyString:value];
        
        return;
    }
    
    if ([key isEqualToString:@"message"]) {
        NSString *sign = value;
        
        _message = [[NSData alloc] initWithBase16EncodedString:sign options:0];
        
        return;
    }
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (instancetype)generateFromObject:(NSDictionary *)object {
    if (![object isKindOfClass:[NSDictionary class]]) return nil;
    
    Memo *memo = [[Memo alloc] init];

    [memo setValuesForKeysWithDictionary:object];
    
    return memo;
}

- (id)generateToTransferObject {
    return @{@"from":_from.description,@"to":_to.description,@"nonce":_nonce,@"message":[_message base16EncodedStringWithOptions:(NSDataBase16EncodingOptionsLowerCase)]};
}

- (NSData *)transformToData {
    NSMutableData *data = [NSMutableData dataWithCapacity:200];
    
    [data appendData:self.from.keyData];
    
    [data appendData:self.to.keyData];

    NSDecimalNumber *de = [NSDecimalNumber decimalNumberWithString:self.nonce];
    
    long value = [de longValue];
    
    NSData *nonceData = [PackData packLongValue:value];
    
    [data appendData:nonceData];
    
    [data appendData:[PackData packUnsigedInteger:self.message.length]];
    
    [data appendData:self.message];
    
    return [data copy];
}

- (NSInteger)dataSize {
    return [self transformToData].length;
}

@end
