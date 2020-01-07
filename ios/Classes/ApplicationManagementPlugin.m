#import "ApplicationManagementPlugin.h"
#if __has_include(<application_management/application_management-Swift.h>)
#import <application_management/application_management-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "application_management-Swift.h"
#endif

@implementation ApplicationManagementPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftApplicationManagementPlugin registerWithRegistrar:registrar];
}
@end
