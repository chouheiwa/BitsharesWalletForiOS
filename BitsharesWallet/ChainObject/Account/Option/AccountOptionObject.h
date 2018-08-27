//
//  AccountOptionObject.h
//  BitsharesWallet
//
//  Created by flh on 2018/8/18.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectToDataProtocol.h"
@class PublicKey;
@class ObjectId;
@class VoteIdObject;
@interface AccountOptionObject : NSObject<ObjectToDataProtocol>

@property (nonatomic, strong) PublicKey *memo_key;

@property (nonatomic, strong) ObjectId *voting_account;

@property (nonatomic, assign) NSInteger num_witness;

@property (nonatomic, assign) NSInteger num_committee;

@property (nonatomic, copy) NSArray <VoteIdObject *>*votes;

@property (nonatomic, copy) NSArray *extensions;

@end
