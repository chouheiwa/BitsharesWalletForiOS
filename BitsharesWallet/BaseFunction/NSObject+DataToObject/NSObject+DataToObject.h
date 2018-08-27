//
//  NSObject+DataToObject.h
//  BitsharesWallet
//
//  Created by flh on 2018/8/18.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DataToObject)

+ (NSDictionary *)getPropertyType;

+ (NSArray *)getPropertyNameArray;

+ (NSArray *)generateFromDataArray:(NSArray *)dataArray;

+ (NSArray *)generateToTransferArray:(NSArray *)objectArray;

- (id)defaultGetValue:(id)value forKey:(NSString *)key;

- (NSDictionary *)defaultGetDictionary;

@end
