//
//  AssetTest.m
//  BitsharesWalletTests
//
//  Created by flh on 2018/8/23.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AssetObject.h"
@interface AssetTest : XCTestCase



@end

@implementation AssetTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testAssetGenerate {
    NSString *json = @"{\"id\":\"1.3.2\",\"symbol\":\"USD\",\"precision\":5,\"issuer\":\"1.2.89565\",\"options\":{\"max_supply\":\"20000000000000\",\"market_fee_percent\":0,\"max_market_fee\":0,\"issuer_permissions\":511,\"flags\":16,\"core_exchange_rate\":{\"base\":{\"amount\":1,\"asset_id\":\"1.3.2\"},\"quote\":{\"amount\":26,\"asset_id\":\"1.3.0\"}},\"whitelist_authorities\":[],\"blacklist_authorities\":[],\"whitelist_markets\":[],\"blacklist_markets\":[],\"description\":\"\",\"extensions\":[]},\"dynamic_asset_data_id\":\"2.3.2\",\"bitasset_data_id\":\"2.4.0\"}";
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:(NSJSONReadingAllowFragments) error:nil];
    
    AssetObject *obj = [AssetObject generateFromObject:dic];
    
    NSLog(@"%@",[obj generateToTransferObject]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
