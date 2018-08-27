//
//  AccountOptionsTest.m
//  BitsharesWalletTests
//
//  Created by flh on 2018/8/19.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BaseConfig.h"
#import "AccountOptionObject.h"
@interface AccountOptionsTest : XCTestCase

@end

@implementation AccountOptionsTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    [BaseConfig setPrefix:@"BDS"];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    NSString *jsonString = @"{\"memo_key\":\"BDS5YE8WjcitYgHk8LxDPbrk1Der3nXbuaxVj4ZiF1ur7jvbGAs2T\",\"voting_account\":\"1.2.5\",\"num_witness\":25,\"num_committee\":0,\"votes\":[\"1:0\",\"1:1\",\"1:5\",\"1:6\",\"1:7\",\"1:8\",\"1:31\",\"1:32\",\"1:97\",\"1:101\",\"1:111\",\"1:112\",\"1:113\",\"1:114\",\"1:115\",\"1:116\",\"1:117\",\"1:118\",\"1:119\",\"1:120\",\"1:121\",\"1:126\",\"1:151\",\"1:152\",\"1:153\"],\"extensions\":[]}";
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:(NSJSONReadingAllowFragments) error:nil];
    
    AccountOptionObject *acc = [AccountOptionObject generateFromObject:dic];
    
    NSLog(@"%@",acc.generateToTransferObject);
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
