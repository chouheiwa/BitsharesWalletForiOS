//
//  SHA256DiggestTests.m
//  BitsharesWalletTests
//
//  Created by flh on 2018/8/10.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SHA256Diggest.h"
#import "NSData+HashData.h"
#import "Base58Object.h"
#import "NSData+CopyWithRange.h"
@interface SHA256DiggestTests : XCTestCase

@end

@implementation SHA256DiggestTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testShaUpdateAndDoFinal {
    SHA256Diggest *sha = [[SHA256Diggest alloc] init];
    
    NSString *privateKey = @"5K2EwMLdiYNLFSfiNgH5FZt5fvrCFDqNVEbThAvUewnBPFmTsaP";
    
    NSData *data = [Base58Object decodeWithBase58String:privateKey];
    
    [sha updateWithInData:data range:NSMakeRange(0, data.length - 4)];
    
    Byte *bytes = (Byte *)malloc(32);
    
    [sha doFinalWithByteData:bytes outOffSet:0];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
