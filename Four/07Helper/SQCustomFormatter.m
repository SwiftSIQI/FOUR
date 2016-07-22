//
//  SQCustomFormatter.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/6/25.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "SQCustomFormatter.h"

@implementation SQCustomFormatter

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage{
    
    NSString *logLevel = nil;
    switch (logMessage -> _flag)
    {
        case DDLogFlagError:
            logLevel = @"[ERROR]> ";
            break;
        case DDLogFlagWarning:
            logLevel = @"[WARN]> ";
            break;
        case DDLogFlagInfo:
            logLevel = @"[INFO]> ";
            break;
        case DDLogFlagDebug:
            logLevel = @"[DEBUG]> ";
            break;
        default:
            logLevel = @"[VBOSE]> ";
            break;
    }
    
    NSString *formatStr = [NSString stringWithFormat:@"%@[%@ %@][line %lu] %@",
                           logLevel,
                           logMessage.fileName,
                           logMessage->_function,
                           (unsigned long)logMessage-> _line,
                           logMessage-> _message
                           
                           ];
    
    return formatStr;
}

@end
