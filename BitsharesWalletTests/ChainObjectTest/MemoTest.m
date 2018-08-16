//
//  MemoTest.m
//  BitsharesWalletTests
//
//  Created by flh on 2018/8/15.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Memo.h"
#import "PrivateKey.h"
#import "PublicKey.h"
#import "NSData+Base16.h"
#import "BaseConfig.h"

#import <objc/runtime.h>



@interface MemoTest : XCTestCase

@end

@implementation MemoTest

- (void)setUp {
    [super setUp];
    
    [BaseConfig setPrefix:@"BDS"];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testMemoEncryptAndDecrypt {
    PrivateKey *pri = [[PrivateKey alloc] initWithPrivateKey:@"5K2EwMLdiYNLFSfiNgH5FZt5fvrCFDqNVEbThAvUewnBPFmTsaP"];
    
    PublicKey *pub = pri.publicKey;
    
    Memo *memo = [[Memo alloc] initWithSend:YES privateKey:pri anotherPublickKey:pub customerNonce:@"100" totalMessage:@"大写的我"];
    
    NSLog(@"%@",[memo getMessageWithPrivateKey:pri]);
}

//- (void)testRuntime {
//    unsigned int count;// 记录属性个数
//    objc_property_t *properties = class_copyPropertyList([Memo class], &count);
//    
//    
//    
//    for (int i = 0; i < count; i++) {
//        // An opaque type that represents an Objective-C declared property.
//        // objc_property_t 属性类型
//        objc_property_t property = properties[i];
//        // 获取属性的名称 C语言字符串
//        const char *cName = property_getName(property);
//        // 转换为Objective C 字符串
//        NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
//        
//        unsigned int attrCount = 0;
//        objc_property_attribute_t * attrs = property_copyAttributeList(property, &attrCount);
//        
//        for (int j = 0; j < attrCount; j ++) {
//            objc_property_attribute_t attr = attrs[j];
//            
//            NSString *names = [NSString stringWithUTF8String:attr.name];
//            
//            NSString *value = [NSString stringWithUTF8String:attr.value];
//            
//            NSLog(@"%@ 属性的描述：%@ 值：%@", name,names, value);
//        }
//    
//        free(attrs);
//    }
//    free(properties);
//}
@end
