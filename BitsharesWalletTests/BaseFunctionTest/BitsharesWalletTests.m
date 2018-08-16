//
//  BitsharesWalletTests.m
//  BitsharesWalletTests
//
//  Created by flh on 2018/8/8.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSData+HashData.h"
#import "PrivateKey.h"
#import "PublicKey.h"
#import "Base58Object.h"
@interface BitsharesWalletTests : XCTestCase

@end

@implementation BitsharesWalletTests

- (void)testRIPEMD160Data {
    PrivateKey *pri = [[PrivateKey alloc] initWithPrivateKey:@"5K2EwMLdiYNLFSfiNgH5FZt5fvrCFDqNVEbThAvUewnBPFmTsaP"];
    
    XCTAssert([[Base58Object encodeWithRIPEMD160CheckSum:pri.publicKey.keyData] isEqualToString:@"6VdkZYfdrpZ8da8chVTDfXYGiAxBn6cNraVunH2EvKzd5SWnBR"]);
}

@end
