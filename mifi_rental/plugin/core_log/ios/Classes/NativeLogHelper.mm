//
//  NativeLogHelper.m
//  flutter_native_log_plugin
//
//  Created by yyg on 2020/5/21.
//

#import "NativeLogHelper.h"
#include <stdio.h>
#import <mars/xlog/xlogger.h>
#import <mars/xlog/appender.h>
#import <sys/xattr.h>
#import <mars/xlog/xloggerbase.h>

static NSUInteger g_processID = 0;

@implementation NativeLogHelper
// 封装了初始化 Xlogger 方法
// initialize Xlogger
+ (void)initXlogger {
    
    const char* prefix = "Test";
    NSString* logPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:@"/xlog"];
    
    // set do not backup for logpath
    const char* attrName = "io.jinkey";
    u_int8_t attrValue = 1;
    setxattr([logPath UTF8String], attrName, &attrValue, sizeof(attrValue), 0, 0);
    
    // init xlog
    #if DEBUG
    // 设置debug环境
    xlogger_SetLevel(kLevelDebug);
    // 控制台日志输出开启
    appender_set_console_log(true);
    // 同步输出
    appender_open_with_cache(kAppednerSync, "", [logPath UTF8String], prefix, 15, "6516116691dd720626980048302867b13dd16cce0a88f2112d037bd81b006b779c2df77b46905c1b330fc61bef48f27d7266bb4310c8fe870a33e55fc886bfbf");
    #else
   // 设置release环境
    xlogger_SetLevel(kLevelInfo);
    // 控制台日志输出关闭
    appender_set_console_log(false);
    // 异步输出
    appender_open_with_cache(kAppednerAsync, "", [logPath UTF8String], prefix, 15, "6516116691dd720626980048302867b13dd16cce0a88f2112d037bd81b006b779c2df77b46905c1b330fc61bef48f27d7266bb4310c8fe870a33e55fc886bfbf");
    #endif
    
    
}

// 封装了关闭 Xlogger 方法
// deinitialize Xlogger
+ (void)deinitXlogger {
    appender_close();
}

+ (void)logWithLevel:(int)logLevel moduleName:(NSString *)moduleName fileName:(NSString *)fileName lineNumber:(int)lineNumber funcName:(NSString *)funcName message:(NSString *)message {
    XLoggerInfo info;
    info.level = (TLogLevel)logLevel;
    info.tag = moduleName.UTF8String;
    info.filename = fileName.UTF8String;
    info.func_name = funcName.UTF8String;
    info.line = lineNumber;
    gettimeofday(&info.timeval, NULL);
    info.tid = (uintptr_t)[NSThread currentThread];
    info.maintid = (uintptr_t)[NSThread mainThread];
    info.pid = g_processID;
    xlogger_Write(&info, message.UTF8String);
}

+ (void)logWithLevel:(int)logLevel moduleName:(NSString *)moduleName fileName:(NSString *)fileName lineNumber:(int)lineNumber funcName:(NSString *)funcName format:(NSString *)format, ... {
    va_list argList;
    va_start(argList, format);
    NSString* message = [[NSString alloc] initWithFormat:format arguments:argList];
    [self logWithLevel:logLevel moduleName:moduleName fileName:fileName lineNumber:lineNumber funcName:funcName message:message];
    va_end(argList);
}

@end
