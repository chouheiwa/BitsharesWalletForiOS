//
//  AuthoriyTest.m
//  BitsharesWalletTests
//
//  Created by flh on 2018/8/17.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AuthorityObject.h"
#import "BaseConfig.h"
@interface AuthoriyTest : XCTestCase

@end

@implementation AuthoriyTest

- (void)setUp {
    [super setUp];
    [BaseConfig setPrefix:@"BDS"];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSString *string = @"{\"weight_threshold\":1,\"account_auths\":[],\"key_auths\":[[\"BDS5YE8WjcitYgHk8LxDPbrk1Der3nXbuaxVj4ZiF1ur7jvbGAs2T\",1]],\"address_auths\":[]}";
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:4] options:(NSJSONReadingAllowFragments) error:nil];
    
    AuthorityObject *authoriy = [AuthorityObject generateFromObject:dic];
    
    NSLog(@"%@",[authoriy generateToTransferObject]);
    
}

@end
