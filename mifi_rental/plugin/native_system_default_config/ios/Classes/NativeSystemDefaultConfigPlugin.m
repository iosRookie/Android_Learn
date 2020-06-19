#import "NativeSystemDefaultConfigPlugin.h"
#if __has_include(<native_system_default_config/native_system_default_config-Swift.h>)
#import <native_system_default_config/native_system_default_config-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "native_system_default_config-Swift.h"
#endif

@implementation NativeSystemDefaultConfigPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftNativeSystemDefaultConfigPlugin registerWithRegistrar:registrar];
}
@end
