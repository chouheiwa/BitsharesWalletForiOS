//
//  ObjectIdTest.m
//  BitsharesWalletTests
//
//  Created by flh on 2018/8/15.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ObjectId.h"
@interface ObjectIdTest : XCTestCase

@end

@implementation ObjectIdTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testObjectIdCreate {
    NSString *test = @"1.2.5";
    
    ObjectId *object = [ObjectId generateFromObject:test];
    
    XCTAssert(object != nil);
    
    XCTAssert([test isEqualToString:[object generateToTransferObject]]);
    
    XCTAssert([object isEqual:test]);
    
    XCTAssert(![object isEqual:@"1.0.5"]);
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

@end
