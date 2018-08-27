//
//  PrivateKeyTests.m
//  BitsharesWalletTests
//
//  Created by flh on 2018/8/10.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PrivateKey.h"
#import "PublicKey.h"
#import "ChainId.h"
#import "NSData+HashData.h"
#import "BaseConfig.h"
#import "BitAddress.h"
@interface KeyTests : XCTestCase

@end

@implementation KeyTests

- (void)setUp {
    [super setUp];
    [BaseConfig setPrefix:@"BDS"];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPrivateKeyAndPublic {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    PrivateKey *pri = [[PrivateKey alloc] initWithPrivateKey:@"5K2EwMLdiYNLFSfiNgH5FZt5fvrCFDqNVEbThAvUewnBPFmTsaP"];
    
    PublicKey *public = pri.publicKey;
    
    NSString *pubStr = [NSString stringWithFormat:@"%@6VdkZYfdrpZ8da8chVTDfXYGiAxBn6cNraVunH2EvKzd5SWnBR",[BaseConfig prefix]];
    
    XCTAssert([[public description] isEqualToString:pubStr]);
}

- (void)testPrivateKeyWithBrainKey {
    PrivateKey *pri = [[PrivateKey alloc] initWithBrainKey:@"CTC123456 0"];
    
    XCTAssert([pri.description isEqualToString:@"5K2EwMLdiYNLFSfiNgH5FZt5fvrCFDqNVEbThAvUewnBPFmTsaP"]);
    
    PublicKey *public = pri.publicKey;
    
    NSString *pubStr = [NSString stringWithFormat:@"%@6VdkZYfdrpZ8da8chVTDfXYGiAxBn6cNraVunH2EvKzd5SWnBR",[BaseConfig prefix]];
    
    XCTAssert([public.description isEqualToString:pubStr]);
}

- (void)testPublicKeyGenerateWithPubString {
    PublicKey *pub = [[PublicKey alloc] initWithPubkeyString:@"6VdkZYfdrpZ8da8chVTDfXYGiAxBn6cNraVunH2EvKzd5SWnBR"];
    
    XCTAssert(pub.keyData != nil);
}

- (void)testPublicKeyArrayContain {
    PublicKey *pub = [[PublicKey alloc] initWithPubkeyString:@"6VdkZYfdrpZ8da8chVTDfXYGiAxBn6cNraVunH2EvKzd5SWnBR"];
    
    PublicKey * pub1 = [pub copy];
    
    XCTAssert(pub != pub1);
    
    NSArray *array = @[pub1];
    
    XCTAssert([array containsObject:pub]);
}

- (void)testSignCompact {
    PrivateKey *pri = [[PrivateKey alloc] initWithPrivateKey:@"5JzhaUrXLTrAXmFqEF1AMnNJN9oCPgJN66NLHb2rZ9d8VQaeQiQ"];
    
    char c[] = {-72,46,90,81,28,-49,42,87,26,98,114,-125,-89,115,-79,-99,76,89,-78,-5,29,46,-115,-1,-105,-78,79,69,-128,-92,-113,-60};
    
    NSData *sha256Data = [NSData dataWithBytes:c length:32];
    
    NSString *data = [pri signedCompact:sha256Data requireCanonical:YES];
    
    PublicKey *pubKey = [[PublicKey alloc] initWithSignCompactSigntures:data sha256Data:sha256Data checkCanonical:YES];
    
    PublicKey *pubKey1 = pri.publicKey;
    
    XCTAssert([pubKey.keyData isEqualToData:pubKey1.keyData]);
}

- (void)testBitAddress {
    PrivateKey *pri = [[PrivateKey alloc] initWithPrivateKey:@"5JzhaUrXLTrAXmFqEF1AMnNJN9oCPgJN66NLHb2rZ9d8VQaeQiQ"];
    
    NSLog(@"%ld",pri.keyData.length);
    
    BitAddress *address = [[BitAddress alloc] initWithKeyData:pri.publicKey.keyData];
    
    XCTAssert(address.keyData.length == 20);
    
    BOOL result = [address.description isEqualToString:[NSString stringWithFormat:@"%@HAvmpngiExPpiaYXGGPjwoK2ciH6xNbSx",[BaseConfig prefix]]];
    
    XCTAssert(result);
}
@end
