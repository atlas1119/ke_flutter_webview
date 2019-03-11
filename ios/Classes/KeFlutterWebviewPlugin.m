#import "KeFlutterWebviewPlugin.h"
#import <ke_flutter_webview/ke_flutter_webview-Swift.h>

@implementation KeFlutterWebviewPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftKeFlutterWebviewPlugin registerWithRegistrar:registrar];
}
@end
