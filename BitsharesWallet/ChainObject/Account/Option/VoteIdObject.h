//
//  VoteIdObject.h
//  BitsharesWallet
//
//  Created by flh on 2018/8/18.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectToDataProtocol.h"
typedef NS_ENUM(int,VoteIdType) {
    VoteIdTypeCommitteeMember,
    VoteIdTypeWitness,
};

@class ObjectId;

@interface VoteIdObject : NSObject<ObjectToDataProtocol>

@property (nonatomic, assign, readonly) VoteIdType voteType;
/**
 voteId is @"1.6.???"
 */
@property (nonatomic, strong, readonly) ObjectId *voteId;

- (instancetype)initWithVoteIdType:(VoteIdType)voteType voteId:(ObjectId *)voteId;

@end
