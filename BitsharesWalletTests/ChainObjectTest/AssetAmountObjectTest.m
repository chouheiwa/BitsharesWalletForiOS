//
//  AssetAmountObjectTest.m
//  BitsharesWalletTests
//
//  Created by flh on 2018/8/15.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AssetAmountObject.h"
@interface AssetAmountObjectTest : XCTestCase



@end

@implementation AssetAmountObjectTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testAssetAmountObjectCreate {
    NSString *jsonString = @"{\"amount\": 12500,\"asset_id\": \"1.3.3\"}";
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:(NSJSONReadingAllowFragments) error:NULL];
    
    AssetAmountObject *obj = [AssetAmountObject generateFromObject:dic];
    
    NSLog(@"%@",obj);
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
