//
//  NSDataCopyWithRangeTests.m
//  BitsharesWalletTests
//
//  Created by flh on 2018/8/10.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSData+CopyWithRange.h"
@interface NSDataCopyWithRangeTests : XCTestCase

@end

@implementation NSDataCopyWithRangeTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCopyWithRange {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    NSString *testString = @"1234";
    
    NSData *testData = [testString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *finalData = [testData copyWithRange:NSMakeRange(2, 2)];
    
    XCTAssert([[[NSString alloc] initWithData:finalData encoding:NSUTF8StringEncoding] isEqualToString:@"34"]);
    
    @try {
        finalData = [testData copyWithRange:NSMakeRange(4, 4)];
        
        XCTAssert(false);
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}

@end
