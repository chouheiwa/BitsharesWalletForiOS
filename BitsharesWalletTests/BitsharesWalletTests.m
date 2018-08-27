//
//  BitsharesWalletTests.m
//  BitsharesWalletTests
//
//  Created by flh on 2018/8/8.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BitsharesWalletObject.h"
#import "AssetObject.h"
#import "PrivateKey.h"

#import "NSData+HashData.h"
#import "NSData+Base16.h"

@interface BitsharesWalletTests : XCTestCase

@property (nonatomic, strong) BitsharesWalletObject *wallet;

@end

@implementation BitsharesWalletTests

- (void)testBitsharesGetAccount {
    XCTestExpectation *websocketTestException = [self expectationWithDescription:@"websocket test"];
    
    
    [self connectSuccessDone:^(BitsharesWalletObject *wallet) {
        [wallet getAccount:@"init0" success:^(AccountObject *result) {
            XCTAssert(result != nil);
            [websocketTestException fulfill];
        } error:^(NSError *error) {
            
        }];
    }];
    
    [self waitForExpectationsWithTimeout:5 handler:^(NSError * _Nullable error) {
        
    }];
}

- (void)testBitsharesGetAsset {
    XCTestExpectation *websocketTestException = [self expectationWithDescription:@"websocket test"];
    
    [self connectSuccessDone:^(BitsharesWalletObject *wallet) {
        [wallet getAsset:@"BDS" success:^(AssetObject *result) {
            XCTAssert(result != nil);
            [websocketTestException fulfill];
        } error:^(NSError *error) {
            
        }];
    }];
    
    [self waitForExpectationsWithTimeout:5 handler:^(NSError * _Nullable error) {
        
    }];
}

- (void)testBitsharesGetDynamicGlobalProperties {
    XCTestExpectation *websocketTestException = [self expectationWithDescription:@"websocket test"];
    
    [self connectSuccessDone:^(BitsharesWalletObject *wallet) {
        [wallet getDynamicGlobalPropertiesWithSuccess:^(id result) {
            [websocketTestException fulfill];
        } error:^(NSError *error) {
            
        }];
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        
    }];
}

- (void)testTransfer {
    XCTestExpectation *websocketTestException = [self expectationWithDescription:@"websocket test"];
    
    [self connectSuccessDone:^(BitsharesWalletObject *wallet) {
        [wallet getAccount:@"tusowner5" success:^(AccountObject *tusowner) {
            NSError *error;
            
            [wallet importKey:[[PrivateKey alloc] initWithPrivateKey:@"5JzhaUrXLTrAXmFqEF1AMnNJN9oCPgJN66NLHb2rZ9d8VQaeQiQ"] forAccount:tusowner error:&error];
            
            
            
            [wallet getAccount:@"tusowner6" success:^(AccountObject *tusowner1) {
                [wallet getAsset:@"1.3.0" success:^(AssetObject *BDS) {
                    [wallet transferFromAccount:tusowner toAccount:tusowner1 assetAmount:[BDS getAmountFromNormalFloatString:@"100"] memo:@"1111" feePayingAsset:BDS success:^(SignedTransaction *sign) {
                        [websocketTestException fulfill];
                    } error:^(NSError *error) {
                        XCTFail(@"%@",error);
                    }];
                } error:^(NSError *error) {
                    XCTFail(@"%@",error);
                }];
            } error:^(NSError *error) {
                XCTFail(@"%@",error);
            }];
        } error:^(NSError *error) {
            XCTFail(@"%@",error);
        }];
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        
    }];
}

- (void)testBitsharesGetFee {
    XCTestExpectation *websocketTestException = [self expectationWithDescription:@"websocket test"];
    
    [self connectSuccessDone:^(BitsharesWalletObject *wallet) {
        [wallet getOperationBaseFeeObjectWithSuccess:^(id result) {
            NSLog(@"%@",result);
            
            [websocketTestException fulfill];
        } error:^(NSError *error) {
            
        } lazyLoad:YES];
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        
    }];
}

- (void)connectSuccessDone:(void (^) (BitsharesWalletObject *wallet))successDone {
    _wallet = [[BitsharesWalletObject alloc] initWithChainId:@"eb97e7110ca3e76f4263326c8fe1a35d6d8720f1f435290e3aeca1723ea4a5a1" prefix:@"BDS"];

    [_wallet connectUrl:@"ws://127.0.0.1:8056" timeOut:2 connectedError:^(NSError *error) {
        XCTAssert(NO);
    }];
    
    __weak typeof(_wallet) weakWallet = _wallet;
    
    _wallet.connectStatusChange = ^(WebsocketConnectStatus status) {
        __strong typeof(weakWallet) wallet = weakWallet;
        if (status == WebsocketConnectStatusConnected) {
            successDone(wallet);
        }
    };
}

@end
