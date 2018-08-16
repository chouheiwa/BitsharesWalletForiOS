//
//  NSDate+UTCDate.m
//  BitsharesWallet
//
//  Created by flh on 2018/8/16.
//  Copyright © 2018年 flh. All rights reserved.
//

#import "NSDate+UTCDate.h"
#import "PackData.h"
@implementation NSDate (UTCDate)

+ (instancetype)generateFromObject:(id)object {
    if (![object isKindOfClass:[NSString class]]) return nil;
    
    NSDateFormatter *matter = [[NSDateFormatter alloc] init];
    
    matter.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];;
    
    matter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss";
    
    NSDate *date = [matter dateFromString:object];
    
    return date;
}

- (id)generateToTransferObject {
    NSDateFormatter *matter = [[NSDateFormatter alloc] init];
    
    matter.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];;
    
    matter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss";
    
    NSString *date = [matter stringFromDate:self];
    
    return date;
}

- (NSData *)transformToData {
    return [PackData packDate:self];
}

- (NSInteger)dataSize {
    return [self transformToData].length;
}

@end
