//
//  SignedTransaction.m
//  BitsharesWalletTests
//
//  Created by flh on 2018/8/16.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BaseConfig.h"
#import "SignedTransaction.h"
#import "PrivateKey.h"
#import "PublicKey.h"
#import "NSData+HashData.h"
@interface SignedTransactionTest : XCTestCase

@end

@implementation SignedTransactionTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    [BaseConfig setPrefix:@"BDS"];
    [BaseConfig setChainId:@"4a93e8abe6ab5f2b935d692e13eea73cdbfb288959fb41640b829d25b7f4bd84"];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGenerateFromJson {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSString *json = @"{\"ref_block_num\":16447,\"ref_block_prefix\":612447143,\"expiration\":\"2018-08-15T06:38:10\",\"operations\":[[0,{\"fee\":{\"amount\":50000,\"asset_id\":\"1.3.0\"},\"from\":\"1.2.1174\",\"to\":\"1.2.13\",\"amount\":{\"amount\":100000,\"asset_id\":\"1.3.0\"},\"memo\":{\"from\":\"BDS6VdkZYfdrpZ8da8chVTDfXYGiAxBn6cNraVunH2EvKzd5SWnBR\",\"to\":\"BDS6VdkZYfdrpZ8da8chVTDfXYGiAxBn6cNraVunH2EvKzd5SWnBR\",\"nonce\":\"16574780943785152036\",\"message\":\"e24713a8566ed7a47cfce5476ccfbda0\"},\"extensions\":[]}]],\"extensions\":[],\"signatures\":[\"1f6e20b140f1c1e35e7e24ea58742e2b05eb2589ce4e3f8da0b375139a8920e8fe6a64bb3d116ff21c962a52a75946811aba2f1c99db4408998e149f694543c9d8\"]}";
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:(NSJSONReadingAllowFragments) error:nil];
    
    SignedTransaction *sig = [SignedTransaction generateFromObject:dic];
    
    NSArray *array = sig.signatures;
    
    sig.signatures = @[];
    
    PrivateKey *priKey = [[PrivateKey alloc] initWithPrivateKey:@"5K2EwMLdiYNLFSfiNgH5FZt5fvrCFDqNVEbThAvUewnBPFmTsaP"];
    
    [sig signWithPrikey:priKey];
    
    NSData *sha256Data = [[sig transformToData] sha256Data];
    
    PublicKey *pub = [[PublicKey alloc] initWithSignCompactSigntures:array.firstObject sha256Data:sha256Data checkCanonical:YES];
    
    PublicKey *pub1 = [[PublicKey alloc] initWithSignCompactSigntures:@"1c0afd2670066d00fe9d0b55685b76310d2fb203b018e966316773c1916c84384607579988acf5c8ed52a1c6958ef8ab6fda9c68469fddd00ccc10e371205961e1" sha256Data:sha256Data checkCanonical:YES];
    
    XCTAssert([pub1.keyData isEqualToData:pub.keyData]);
    
    XCTAssert([pub.keyData isEqualToData:priKey.publicKey.keyData]);
    
    XCTAssert([array.firstObject isEqualToString:sig.signatures.firstObject]);
}

@end
