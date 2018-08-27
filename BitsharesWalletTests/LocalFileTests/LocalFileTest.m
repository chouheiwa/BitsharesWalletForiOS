
//
//  LocalFileTest.m
//  BitsharesWalletTests
//
//  Created by flh on 2018/8/20.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BaseConfig.h"
#import "BitsharesLocalWalletFile.h"
#import "PlainKey.h"
#import "PrivateKey.h"
#import "PublicKey.h"
#import "NSData+HashData.h"

@interface LocalFileTest : XCTestCase

@end

@implementation LocalFileTest

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
    NSString *json = @"{\"chain_id\":\"eb97e7110ca3e76f4263326c8fe1a35d6d8720f1f435290e3aeca1723ea4a5a1\",\"my_accounts\":[{\"id\":\"1.2.6\",\"membership_expiration_date\":\"1969-12-31T23:59:59\",\"registrar\":\"1.2.6\",\"referrer\":\"1.2.6\",\"lifetime_referrer\":\"1.2.6\",\"network_fee_percentage\":2000,\"lifetime_referrer_fee_percentage\":8000,\"referrer_rewards_percentage\":0,\"name\":\"tusowner\",\"owner\":{\"weight_threshold\":1,\"account_auths\":[],\"key_auths\":[[\"BDS7ANxNXLZG9eYFqsBkLvyJdj7b8VjZFq6tb52ucpvtj2gmJ35fT\",1]],\"address_auths\":[]},\"active\":{\"weight_threshold\":1,\"account_auths\":[],\"key_auths\":[[\"BDS7ANxNXLZG9eYFqsBkLvyJdj7b8VjZFq6tb52ucpvtj2gmJ35fT\",1]],\"address_auths\":[]},\"options\":{\"memo_key\":\"BDS7ANxNXLZG9eYFqsBkLvyJdj7b8VjZFq6tb52ucpvtj2gmJ35fT\",\"voting_account\":\"1.2.5\",\"num_witness\":0,\"num_committee\":0,\"votes\":[],\"extensions\":[]},\"statistics\":\"2.6.6\",\"whitelisting_accounts\":[],\"blacklisting_accounts\":[],\"whitelisted_accounts\":[],\"blacklisted_accounts\":[],\"cashback_vb\":\"1.13.0\",\"owner_special_authority\":[0,{}],\"active_special_authority\":[0,{}],\"top_n_control_flags\":0}],\"cipher_keys\":\"ebbb216cbbfbb218797c376bdce0f80241f268910272e9c4e032608ad96cf91365e493c2735f5805735f307566952ec3d28da9c5b60b31df6cd544111c2146bcfd52135736131a73575f8f7c658ab7ca8a86ac9d617d7b9179867a7340075255a10ef4936623c4e20aeb6aab2cd3bcf41dbdb09c2d3a99a3124b2b5d069d171129411c32159101801b280f5c9bad169e6adb12bd4bff4f45ed22b9fa78a2d1a1\",\"extra_keys\":[[\"1.2.6\",[\"BDS7ANxNXLZG9eYFqsBkLvyJdj7b8VjZFq6tb52ucpvtj2gmJ35fT\"]]],\"pending_account_registrations\":[],\"pending_witness_registrations\":[],\"labeled_keys\":[],\"blind_receipts\":[],\"ws_server\":\"ws://127.0.0.1:8056\",\"ws_user\":\"\",\"ws_password\":\"\"}";
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:(NSJSONReadingAllowFragments) error:nil];
    
    BitsharesLocalWalletFile *local = [BitsharesLocalWalletFile generateFromObject:dic];
    
    XCTAssert(local.isLocked);
    
    XCTAssert([local unlockWithString:@"123456" error:nil]);
    
    XCTAssert(!local.isLocked);
    
    json = @"{\"id\":\"1.2.7\",\"membership_expiration_date\":\"1969-12-31T23:59:59\",\"registrar\":\"1.2.6\",\"referrer\":\"1.2.6\",\"lifetime_referrer\":\"1.2.6\",\"network_fee_percentage\":2000,\"lifetime_referrer_fee_percentage\":8000,\"referrer_rewards_percentage\":0,\"name\":\"tusowner1\",\"owner\":{\"weight_threshold\":1,\"account_auths\":[],\"key_auths\":[[\"BDS6EkSuz4N1grrt3JFrAczEPYSLKszmqoFVKcY8BEHBZKCoyUTtm\",1]],\"address_auths\":[]},\"active\":{\"weight_threshold\":1,\"account_auths\":[],\"key_auths\":[[\"BDS6EkSuz4N1grrt3JFrAczEPYSLKszmqoFVKcY8BEHBZKCoyUTtm\",1]],\"address_auths\":[]},\"options\":{\"memo_key\":\"BDS6EkSuz4N1grrt3JFrAczEPYSLKszmqoFVKcY8BEHBZKCoyUTtm\",\"voting_account\":\"1.2.5\",\"num_witness\":0,\"num_committee\":0,\"votes\":[],\"extensions\":[]},\"statistics\":\"2.6.6\",\"whitelisting_accounts\":[],\"blacklisting_accounts\":[],\"whitelisted_accounts\":[],\"blacklisted_accounts\":[],\"cashback_vb\":\"1.13.0\",\"owner_special_authority\":[0,{}],\"active_special_authority\":[0,{}],\"top_n_control_flags\":0}";
    
    dic = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:(NSJSONReadingAllowFragments) error:nil];
    
    AccountObject *account = [AccountObject generateFromObject:dic];
    
    PrivateKey *private = [[PrivateKey alloc] initWithPrivateKey:@"5K3MYTtLEiszbraZAL4ncBArQB46oB7vdQnoK7XfMcs69j9Jrtn"];
    
    NSError *error = nil;
    
    XCTAssert([local importKey:private ForAccount:account error:&error]);
    
    NSLog(@"Error:%@",error);
    
    NSDictionary *jsonDic = [local generateToTransferObject];
    
    NSString *jsonStr = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:jsonDic options:(NSJSONWritingSortedKeys) error:nil] encoding:4];
    
    NSLog(@"%@",jsonStr);
}

- (void)testPlainKey {
    PlainKey *plainKey = [[PlainKey alloc] initWithCipherKey:@"ebbb216cbbfbb218797c376bdce0f80241f268910272e9c4e032608ad96cf91365e493c2735f5805735f307566952ec3d28da9c5b60b31df6cd544111c2146bcfd52135736131a73575f8f7c658ab7ca8a86ac9d617d7b9179867a7340075255a10ef4936623c4e20aeb6aab2cd3bcf41dbdb09c2d3a99a3124b2b5d069d171129411c32159101801b280f5c9bad169e6adb12bd4bff4f45ed22b9fa78a2d1a1"];
    
    PrivateKey *priKey = [[PrivateKey alloc] initWithPrivateKey:@"5KcTYx3RKi4h1wnQQ8xJCMtK8P5JTXSqbnZCA1ed7qWQDQsEeFz"];
    
    NSLog(@"Private String Data Length:%ld",[priKey.description dataUsingEncoding:4].length);
    
    [[priKey.description dataUsingEncoding:4] logDataDetail:@"PrivateKey String"];
    
    [priKey.publicKey.keyData logDataDetail:@"PublicKey"];
    
    [priKey.keyData logDataDetail:@"PrivateKey"];
    
    NSLog(@"%@",priKey.publicKey);
    
    [plainKey unlockWithPassword:@"123456"];
}

@end
