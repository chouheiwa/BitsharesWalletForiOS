//
//  VoteIdObject.m
//  BitsharesWallet
//
//  Created by flh on 2018/8/18.
//  Copyright © 2018年 flh. All rights reserved.
//

#import "VoteIdObject.h"
#import "ObjectId.h"
#import "PackData.h"
@implementation VoteIdObject


- (instancetype)initWithVoteIdType:(VoteIdType)voteType voteId:(ObjectId *)voteId {
    if (self = [ super init]) {
        _voteId = voteId;
        _voteType = voteType;
    }
    return self;
}

+ (instancetype)generateFromObject:(NSString *)object {
    if (![object isKindOfClass:[NSString class]]) return nil;
    
    NSArray *array = [object componentsSeparatedByString:@":"];
    
    VoteIdType type = [array.firstObject intValue];
    
    ObjectId *objcId = [[ObjectId alloc] initFromSpaceId:1 typeId:6 instance:[array.lastObject integerValue]];
    
    return [[self alloc] initWithVoteIdType:type voteId:objcId];
}

- (id)generateToTransferObject {
    return [NSString stringWithFormat:@"%d:%ld",_voteType,_voteId.instance];
}

- (NSData *)transformToData {
    return [PackData packUnsigedInteger:_voteId.instance];
}

- (NSInteger)dataSize {
    return self.transformToData.length;
}

@end
