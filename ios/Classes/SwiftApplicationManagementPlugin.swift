import Flutter
import UIKit

public class SwiftApplicationManagementPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "application_management", binaryMessenger: registrar.messenger())
        let instance = SwiftApplicationManagementPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
            case "openApp":
                result(openApp(urlScheme: call.value(forKey: "openKeyStr") as! String))
                break
            case "openInAppStore":
                result(openInAppStore(bundleId: call.value(forKey: "appKey") as! String))
                break
            case "isInstalled":
                result(isInstalled(urlScheme: call.value(forKey: "appKey") as! String))
                break
            case "isInstalledList":
                result(isInstalledList(urlSchemeList: call.value(forKey: "appKeyList") as! Array<String>))
                break
            default:
                result(nil)
        }
    }
    
    private func openApp(urlScheme: String){
        
    }
    
    private func openInAppStore(bundleId: String){
        
    }
    
    private func isInstalled(urlScheme: String) -> Bool {
        return true
    }
    
    private func isInstalledList(urlSchemeList: Array<String>) -> Array<String> {
        return Array<String>()
    }
}
