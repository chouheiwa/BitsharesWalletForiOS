//
//  AccountObject.m
//  BitsharesWallet
//
//  Created by flh on 2018/8/17.
//  Copyright © 2018年 flh. All rights reserved.
//

#import "AccountObject.h"
#import "AccountOptionObject.h"
#import "ObjectId.h"
#import "NSObject+DataToObject.h"
#import "AuthorityObject.h"
#import "PublicKey.h"
@implementation AccountObject

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([value isKindOfClass:[NSNull class]]) return;
    
    if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"identifier"];
        return;
    }
    
    NSArray *array = @[@"whitelisting_accounts",@"blacklisting_accounts",@"whitelisted_accounts",@"blacklisted_accounts"];
    if ([array containsObject:key]) {
        [super setValue:[ObjectId generateFromDataArray:value] forKey:key];
        return;
    }
    
    id obj = [self defaultGetValue:value forKey:key];
    
    if (!obj) obj = value;
    
    [super setValue:obj forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (instancetype)generateFromObject:(id)object {
    if (![object isKindOfClass:[NSDictionary class]]) return nil;
    
    return [[self alloc] initWithDic:object];
}
//
- (id)generateToTransferObject {
    NSMutableDictionary *dic = [[self defaultGetDictionary] mutableCopy];
    
    dic[@"id"] = dic[@"identifier"];
    
    dic[@"identifier"] = nil;
    
    return [dic copy];
}

- (BOOL)containPublicKey:(PublicKey *)publicKey {
    return [self.owner containPublicKey:publicKey] || [self.active containPublicKey:publicKey] || [self.options.memo_key isEqual:publicKey];
}

- (NSUInteger)hash {
    return [self.name hash];
}

- (BOOL)isEqual:(AccountObject *)object {
    if (![object isKindOfClass:[self class]]) return NO;
    
    return [object.name isEqualToString:self.name] && [object.identifier.generateToTransferObject isEqual:self.identifier.generateToTransferObject];
}

@end
