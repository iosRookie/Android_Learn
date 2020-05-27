#import "CoreLogPlugin.h"
#if __has_include(<core_log/core_log-Swift.h>)
#import <core_log/core_log-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "core_log-Swift.h"
#endif

@implementation CoreLogPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftCoreLogPlugin registerWithRegistrar:registrar];
}
@end
