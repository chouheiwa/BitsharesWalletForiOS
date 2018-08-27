//
//  ChainDynamicGlobalPropertiesTest.m
//  BitsharesWalletTests
//
//  Created by flh on 2018/8/27.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ChainDynamicGlobalProperties.h"
@interface ChainDynamicGlobalPropertiesTest : XCTestCase

@end

@implementation ChainDynamicGlobalPropertiesTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGenerate {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSString *jsonString = @"{\"id\":\"2.1.0\",\"head_block_number\":7813634,\"head_block_id\":\"00773a023b11c5474266ef231399e4892f1b468b\",\"time\":\"2018-08-23T09:59:32\",\"current_witness\":\"1.6.1\",\"next_maintenance_time\":\"2018-08-24T00:00:00\",\"last_budget_time\":\"2018-08-23T00:00:00\",\"witness_budget\":1035680000,\"accounts_registered_this_interval\":22,\"recently_missed_count\":0,\"current_aslot\":8293502,\"recent_slots_filled\":\"340282366762482128990110714705559412735\",\"dynamic_flags\":0,\"last_irreversible_block_num\":7813616}";
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:(NSJSONReadingAllowFragments) error:NULL];
    
    ChainDynamicGlobalProperties *properties = [ChainDynamicGlobalProperties generateFromObject:dic];
    
    dic = properties.generateToTransferObject;
    
    XCTAssert([dic[@"last_irreversible_block_num"] isKindOfClass:[NSString class]]);
    
}

@end
