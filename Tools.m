//
//  Tools.m
//  剑灵帮帮
//
//  Created by coderss on 14-11-14.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import "Tools.h"

@implementation Tools

+(NSString *)replaceUnicodeStr:(NSString *)unicodeStr
{
    NSString *str=unicodeStr;
    NSString *ohStr=[[[[[str stringByReplacingOccurrencesOfString:@"text:" withString:@""] stringByReplacingOccurrencesOfString:@"[" withString:@""] stringByReplacingOccurrencesOfString:@"]" withString:@""] stringByReplacingOccurrencesOfString:@"\"" withString:@""] stringByReplacingOccurrencesOfString:@"," withString:@" "];
    NSString *finalStr=[self replaceUnicode:ohStr];
    
    return finalStr;
}

+ (NSString *)replaceUnicode:(NSString *)unicodeStr
{
    
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}

@end
