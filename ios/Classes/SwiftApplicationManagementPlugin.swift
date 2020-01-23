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
            case "isInstalledMap":
                result(isInstalledMap(urlSchemeList: call.value(forKey: "appKeyList") as! Array<String>))
                break
            default:
                result(nil)
        }
    }
    
    private func openApp(urlScheme: String){
        let urlSchemeURL = URL(string: urlScheme)!
        if UIApplication.shared.canOpenURL(urlSchemeURL)
        {
            if #available(iOS 10.0, *)
            {
                UIApplication.shared.open(urlSchemeURL)
            }
        }
    }
    
    private func openInAppStore(bundleId: String){
        openApp(urlScheme: "itms-apps://apps.apple.com/cn/app/id\(bundleId)")
    }
    
    private func isInstalled(urlScheme: String) -> Bool {
        let urlSchemeURL = URL(string: urlScheme)!
        return UIApplication.shared.canOpenURL(urlSchemeURL)
    }
    
    private func isInstalledMap(urlSchemeList: Array<String>) -> Dictionary<String, Bool> {
        var isInstalledMap: [String: Bool] = [:]
        urlSchemeList.forEach { item in
            isInstalledMap[item] = isInstalled(urlScheme: item)
        }
        return isInstalledMap
    }
}
