//
//  OperationContent.m
//  BitsharesWallet
//
//  Created by flh on 2018/8/16.
//  Copyright © 2018年 flh. All rights reserved.
//

#import "OperationContent.h"
#import "TransferOperation.h"
#import "LimitOrderCreateOperation.h"
#import "PackData.h"
typedef NS_ENUM(NSInteger,OperationType) {
    OperationTypeNotFind = -1,
    OperationTypeTransfer = 0,
    OperationTypeLimitOrderCreate,
};

@implementation OperationContent

+ (NSDictionary *)opertionToTypeDictionary {
    static NSDictionary *dic = nil;
    
    if (!dic) {
        dic = @{
                NSStringFromClass([TransferOperation class]):@(OperationTypeTransfer)
                };
    }
    return dic;
}

+ (NSDictionary *)typeToOperationDictionary {
    static NSDictionary *dic = nil;
    
    if (!dic) {
        dic = @{
                @(OperationTypeTransfer):NSStringFromClass([TransferOperation class]),
                @(OperationTypeLimitOrderCreate):NSStringFromClass([LimitOrderCreateOperation class]);
                };
    }
    return dic;
}

- (instancetype)initWithOperation:(BaseOperation *)operation {
    if (self = [super init]) {
        _operationContent = operation;
        
        NSNumber *classType = [[[self class] opertionToTypeDictionary] objectForKey:NSStringFromClass([operation class])];
        
        NSAssert(classType, @"Could'not find type from operation class:%@",NSStringFromClass([operation class]));
        
        _operationType = classType?[classType integerValue]:-1;
    }
    return self;
}

- (instancetype)initWithOperation:(id)operation type:(NSInteger)type{
    if (self = [super init]) {
        _operationContent = operation;
        
        _operationType = type;
    }
    return self;
}

+ (instancetype)generateFromObject:(NSArray *)object {
    if (![object isKindOfClass:[NSArray class]]) return nil;
    
    if (object.count < 2) return nil;
    
    NSInteger type = [object[0] integerValue];
    
    id content = object[1];
    
    NSString *className = [[self typeToOperationDictionary] objectForKey:@(type)];
    
    if (className) {
        content = [NSClassFromString(className) performSelector:@selector(generateFromObject:) withObject:content];
    }
    
    return [[self alloc] initWithOperation:content type:type];
}

- (id)generateToTransferObject {
    id content = self.operationContent;
    
    if ([self.operationContent isKindOfClass:[BaseOperation class]]) {
        BaseOperation *baseOperation = self.operationContent;
        
        content = [baseOperation generateToTransferObject];
    }
    
    
    return @[@(self.operationType),content];
}

- (NSInteger)dataSize {
    return [self transformToData].length;
}

- (NSData *)transformToData {
    if ([self.operationContent isKindOfClass:[BaseOperation class]]) {
        BaseOperation *baseOperation = self.operationContent;
        NSData *data = [baseOperation transformToData];
        
        NSMutableData *finaData = [NSMutableData dataWithCapacity:data.length + 10];
        
        [finaData appendData:[PackData packUnsigedInteger:self.operationType]];
        
        [finaData appendData:data];
        
        return [finaData copy];
    }
    
    return nil;
}

@end
