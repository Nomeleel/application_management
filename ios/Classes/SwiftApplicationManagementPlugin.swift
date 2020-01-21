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
                result(isInstalledMap(urlSchemeList: call.value(forKey: "appKeyList") as! Dictionary<String, Bool>))
                break
            default:
                result(nil)
        }
    }
    
    private func openApp(urlScheme: String){
        let urlSchemeURL = URL(string: urlScheme)!
        if UIApplication.shared.canOpenURL(urlSchemeURL)
        {
            UIApplication.shared.open(urlSchemeURL)
        }
    }
    
    private func openInAppStore(bundleId: String){
        openApp("itms-apps://apps.apple.com/cn/app/id" + bundleId)
    }
    
    private func isInstalled(urlScheme: String) -> Bool {
        let urlSchemeURL = URL(string: urlScheme)!
        return UIApplication.shared.canOpenURL(urlSchemeURL)
    }
    
    private func isInstalledMap(urlSchemeList: Array<String>) -> Dictionary<String, Bool> {
        var isInstalledMap: [String: Bool] = [:]
        urlSchemeList.forEach { item in
            isInstalledMap[item] = isInstalled(item)
        }
        return isInstalledMap
    }
}
