//
//  Base58ObjectTests.m
//  BitsharesWalletTests
//
//  Created by flh on 2018/8/8.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Base58Object.h"
#import "NSData+Base16.h"
@interface Base58ObjectTests : XCTestCase

@end

@implementation Base58ObjectTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testBase58Encode {
    NSString *test = @"中文";
    
    NSString *encodeString = [Base58Object encode:[test dataUsingEncoding:NSUTF8StringEncoding]];
    
    XCTAssert([encodeString isEqualToString:@"2xu16HBbU"],"Base58Object encode function wrong");
}

- (void)testBase58Decode {
    NSString *test = @"2xu16HBbU";
    
    NSString *decodeString = [[NSString alloc] initWithData:[Base58Object decodeWithBase58String:test] encoding:NSUTF8StringEncoding];
    
    XCTAssert([decodeString isEqualToString:@"中文"],"Base58Object decodeWithBase58String function wrong");
}

- (void)testBase58EncodeWithCheckSum {
    NSString *test = @"1111";
    
    NSString *encodeString = [Base58Object encodeWithSha256CheckSum:[test dataUsingEncoding:NSUTF8StringEncoding]];
    
    XCTAssert([encodeString isEqualToString:@"9EE5j4SbtMH"],"Base58Object encodeWithCheckSum function wrong");
}

- (void)testBase58EncodeAndDecode {
    NSString *test = @"1234567890";
    
    NSString *encodeString = [Base58Object encodeWithSha256CheckSum:[test dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *data = [Base58Object decodeWithSha256Base58StringCheckSum:encodeString];
    
    XCTAssert([[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] isEqual:test]);
}

- (void)testBase58DecodeWithCheckSum {
    NSString *test = @"9EE5j4SbtMH";
    
    NSString *decodeString = [[NSString alloc] initWithData:[Base58Object decodeWithSha256Base58StringCheckSum:test] encoding:NSUTF8StringEncoding];
    
    XCTAssert([decodeString isEqualToString:@"1111"],"Base58Object decodeWithBase58StringCheckSum function decode normal wrong");
    
    test = @"2xu16HBbU";
    
    decodeString = [[NSString alloc] initWithData:[Base58Object decodeWithSha256Base58StringCheckSum:test] encoding:NSUTF8StringEncoding];
    
    XCTAssert([decodeString isEqualToString:@""],"Base58Object decodeWithBase58StringCheckSum function decode error wrong");
}

- (void)testBase16 {
    NSData *data = [[NSData alloc] initWithBase16EncodedString:@"a3b8ef27e8992d68df66532650ab4edd814b52becec9e6fc12ab33d1c8785e93" options:NSDataBase16DecodingOptionsDefault];
    
    XCTAssert(data.length == 32);
    
    NSArray *array = @[@(-93),@(-72),@(-17),@(39),@(-24),@(-103),@(45),@(104),@(-33),@(102),@(83),@(38),@(80),@(-85),@(78),@(-35),@(-127),@(75),@(82),@(-66),@(-50),@(-55),@(-26),@(-4),@(18),@(-85),@(51),@(-47),@(-56),@(120),@(94),@(-109)];
    
    for (int i = 0; i < data.length; i ++) {
        char c = [array[i] intValue];
        
        char b = ((char *)data.bytes)[i];
        
        XCTAssert(c == b);
    }

    
}

@end
