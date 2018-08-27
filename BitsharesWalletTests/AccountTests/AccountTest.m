//
//  AccountTest.m
//  BitsharesWalletTests
//
//  Created by flh on 2018/8/19.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AccountObject.h"
#import "BaseConfig.h"
@interface AccountTest : XCTestCase

@end

@implementation AccountTest

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
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    NSString *json =@"{\"id\":\"1.2.6\",\"membership_expiration_date\":\"1969-12-31T23:59:59\",\"registrar\":\"1.2.6\",\"referrer\":\"1.2.6\",\"lifetime_referrer\":\"1.2.6\",\"network_fee_percentage\":2000,\"lifetime_referrer_fee_percentage\":8000,\"referrer_rewards_percentage\":0,\"name\":\"init0\",\"owner\":{\"weight_threshold\":1,\"account_auths\":[],\"key_auths\":[[\"BDS5YE8WjcitYgHk8LxDPbrk1Der3nXbuaxVj4ZiF1ur7jvbGAs2T\",1]],\"address_auths\":[]},\"active\":{\"weight_threshold\":1,\"account_auths\":[],\"key_auths\":[[\"BDS5YE8WjcitYgHk8LxDPbrk1Der3nXbuaxVj4ZiF1ur7jvbGAs2T\",1]],\"address_auths\":[]},\"options\":{\"memo_key\":\"BDS5YE8WjcitYgHk8LxDPbrk1Der3nXbuaxVj4ZiF1ur7jvbGAs2T\",\"voting_account\":\"1.2.5\",\"num_witness\":25,\"num_committee\":0,\"votes\":[\"1:0\",\"1:1\",\"1:5\",\"1:6\",\"1:7\",\"1:8\",\"1:31\",\"1:32\",\"1:97\",\"1:101\",\"1:111\",\"1:112\",\"1:113\",\"1:114\",\"1:115\",\"1:116\",\"1:117\",\"1:118\",\"1:119\",\"1:120\",\"1:121\",\"1:126\",\"1:151\",\"1:152\",\"1:153\"],\"extensions\":[]},\"statistics\":\"2.6.6\",\"whitelisting_accounts\":[],\"blacklisting_accounts\":[],\"whitelisted_accounts\":[],\"blacklisted_accounts\":[],\"cashback_vb\":\"1.13.1033\",\"owner_special_authority\":[0,{}],\"active_special_authority\":[0,{}],\"top_n_control_flags\":0}";
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:(NSJSONReadingAllowFragments) error:nil];
    
    AccountObject *obj = [AccountObject generateFromObject:dic];
    
    NSLog(@"%@",[obj generateToTransferObject]);
}



@end
