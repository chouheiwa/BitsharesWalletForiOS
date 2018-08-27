//
//  SignedTransaction.m
//  BitsharesWallet
//
//  Created by flh on 2018/8/16.
//  Copyright © 2018年 flh. All rights reserved.
//

#import "SignedTransaction.h"
#import "PrivateKey.h"
#import "NSData+HashData.h"
#import "BaseConfig.h"
#import "ChainId.h"
#import "OperationContent.h"
#import "BaseOperation.h"
@implementation SignedTransaction

- (instancetype)init {
    if (self = [super init]) {
        self.signatures = @[];
    }
    return self;
}

- (void)signWithPrikey:(PrivateKey *)prikey {
    NSMutableArray *array = [self.signatures mutableCopy];
    
    NSData *data = [self transformToData];
    
    [array addObject:[prikey signedCompact:[data sha256Data] requireCanonical:YES]];
    
    self.signatures = array;
}

+ (instancetype)generateFromObject:(id)object {
    SignedTransaction *transcation = [super generateFromObject:object];
    
    return transcation;
}

- (NSData *)transformToData {
    NSData *sigData = [super transformToData];
    
    NSMutableData *data = [NSMutableData dataWithCapacity:sigData.length + 33];
    
    ChainId *chainId = [[ChainId alloc] initWithBase16String:[BaseConfig chainId]];
    
    [data appendData:chainId.keyData];
    
    [data appendData:sigData];
    
    return [data copy];
}

- (id)generateToTransferObject {
    NSMutableDictionary *dic = [[super generateToTransferObject] mutableCopy];
    
    dic[@"signatures"] = self.signatures;
    
    return [dic copy];
}

- (NSArray *)needSignedKeys {
    NSMutableArray *array = [NSMutableArray array];
    
    for (OperationContent *content in self.operations) {
        for (PublicKey *publicKey in ((BaseOperation *)content.operationContent).requiredAuthority) {
            if (![array containsObject:publicKey]) {
                [array addObject:publicKey];
            }
        }
    }
    return array;
}

@end
