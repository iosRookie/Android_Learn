//
//  NativeLogHelper.h
//  flutter_native_log_plugin
//
//  Created by yyg on 2020/5/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NativeLogHelper : NSObject

+ (void)initXlogger;

+ (void)deinitXlogger;

+ (void)logWithLevel:(int)logLevel moduleName:(NSString *)moduleName fileName:(NSString *)fileName lineNumber:(int)lineNumber funcName:(NSString *)funcName message:(NSString *)message;
+ (void)logWithLevel:(int)logLevel moduleName:(NSString *)moduleName fileName:(NSString *)fileName lineNumber:(int)lineNumber funcName:(NSString *)funcName format:(NSString *)format, ...;

@end

#define LogInternal(level, module, file, line, func, prefix, format, ...) \
do { \
    if ([LogHelper shouldLog:level]) { \
        NSString *aMessage = [NSString stringWithFormat:@"%@%@", prefix, [NSString stringWithFormat:format, ##__VA_ARGS__, nil]]; \
        [LogHelper logWithLevel:level moduleName:module fileName:file lineNumber:line funcName:func message:aMessage]; \
    } \
} while(0)

NS_ASSUME_NONNULL_END
