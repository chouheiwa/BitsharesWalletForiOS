//
//  TransferOperationTest.m
//  BitsharesWalletTests
//
//  Created by flh on 2018/8/16.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BaseConfig.h"
#import "TransferOperation.h"
#import "ObjectId.h"
#import "AssetAmountObject.h"
#import "Memo.h"
#import "PrivateKey.h"
#import "PublicKey.h"

@interface TransferOperationTest : XCTestCase

@end

@implementation TransferOperationTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    [BaseConfig setPrefix:@"BDS"];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testFromJson {
    NSString *json = @"{\"fee\":{\"amount\":50000,\"asset_id\":\"1.3.0\"},\"from\":\"1.2.1174\",\"to\":\"1.2.13\",\"amount\":{\"amount\":100000,\"asset_id\":\"1.3.0\"},\"memo\":{\"from\": \"BDS6VdkZYfdrpZ8da8chVTDfXYGiAxBn6cNraVunH2EvKzd5SWnBR\",\"to\":\"BDS6VdkZYfdrpZ8da8chVTDfXYGiAxBn6cNraVunH2EvKzd5SWnBR\",\"nonce\": \"16574780943785152036\",\"message\":\"e24713a8566ed7a47cfce5476ccfbda0\"},\"extensions\":[]}";
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:(NSJSONReadingAllowFragments) error:nil];
    
    TransferOperation *transfer = [TransferOperation generateFromObject:dic];
    
    NSString *message = [transfer.memo getMessageWithPrivateKey:[[PrivateKey alloc] initWithPrivateKey:@"5K2EwMLdiYNLFSfiNgH5FZt5fvrCFDqNVEbThAvUewnBPFmTsaP"]];
    
    XCTAssert([message isEqualToString:@"111"]);
}

- (void)testTransferOperationCreate {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    PrivateKey *privateKey = [[PrivateKey alloc] initWithPrivateKey:@"5K2EwMLdiYNLFSfiNgH5FZt5fvrCFDqNVEbThAvUewnBPFmTsaP"];
    
    PublicKey *pubkey = [[PublicKey alloc] initWithAllPubkeyString:@"BDS6VdkZYfdrpZ8da8chVTDfXYGiAxBn6cNraVunH2EvKzd5SWnBR"];
    
    AssetAmountObject *fee = [[AssetAmountObject alloc] initFromAssetId:[[ObjectId alloc] initFromSpaceId:1 typeId:3 instance:0] amount:50000];
    
    ObjectId *from = [ObjectId generateFromObject:@"1.2.1174"];
    
    ObjectId *to = [ObjectId generateFromObject:@"1.2.13"];
    
    AssetAmountObject *amount = [[AssetAmountObject alloc] initFromAssetId:[[ObjectId alloc] initFromSpaceId:1 typeId:3 instance:0] amount:100000];
    
    Memo *memo = [[Memo alloc] initWithSend:YES privateKey:privateKey anotherPublickKey:pubkey customerNonce:@"16574780943785152036" totalMessage:@"111"];
    
    TransferOperation *transfer = [[TransferOperation alloc] init];
    
    transfer.fee = fee;
    
    transfer.from = from;
    
    transfer.to = to;
    
    transfer.amount = amount;
    
    transfer.memo = memo;
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:[transfer generateToTransferObject] options:(NSJSONWritingSortedKeys) error:nil];
    
    NSLog(@"TransferOperation:%ld  dic:%@",[transfer dataSize],[[NSString alloc] initWithData:data encoding:4]);
}
@end
