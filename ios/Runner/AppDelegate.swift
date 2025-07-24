import Flutter
import UIKit
import CoreNFC

@main
@objc class AppDelegate: FlutterAppDelegate {
    private let channel = "com.example.nfcapp/nfc"

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)

        // Set up MethodChannel for NFC intent handling
        let controller = window?.rootViewController as! FlutterViewController
        let nfcChannel = FlutterMethodChannel(name: channel, binaryMessenger: controller.binaryMessenger)

        nfcChannel.setMethodCallHandler { (call, result) in
            if call.method == "checkNfcIntent" {
                // Handle NFC intent (e.g., check if launched via NFC)
                result("NFC_INTENT") // Return a dummy response for now
            } else {
                result(FlutterMethodNotImplemented)
            }
        }

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}