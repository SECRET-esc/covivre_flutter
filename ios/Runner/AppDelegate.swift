import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        
        
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let flatterChanel = FlutterMethodChannel(name: "covivre/scan",
                                                 binaryMessenger: controller.binaryMessenger)
        flatterChanel.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
            // Note: this method is invoked on the UI thread.
            guard call.method == "startScan" else {
                result(FlutterMethodNotImplemented)
                return
            }
            
            self?.startScan(call: call, result: result)
        })
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func startScan(call: FlutterMethodCall, result: FlutterResult) {
        //        result(FlutterError(code: "UNAVAILABLE",
        //                            message: "info unavailable",
        //                            details: nil))
        
        guard let args = call.arguments else {
            return
        }
        if let myArgs = args as? [String: Any],
           let risk = myArgs["risk"] as? Bool,
           let positive = myArgs["positive"] as? Bool,
           let closeContact = myArgs["closeContact"] as? Bool,
           let showAtRisk = myArgs["showAtRisk"] as? Bool,
           let showMeetingRooms = myArgs["showMeetingRooms"] as? Bool
        {
            let bleModule = BleModule()
            bleModule.StartInspect()
        } else {
            result(FlutterError(code: "-1", message: "iOS could not extract " +
                                    "flutter arguments in method: (sendParams)", details: nil))
        }
        
        
        result(Int(0))
        
    }
}
