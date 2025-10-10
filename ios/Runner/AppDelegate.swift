import UIKit
import Flutter
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Info.plist에서 GMSApiKey 키를 읽어옵니다.
    guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "GMSApiKey") as? String else {
      fatalError("Google Maps API Key not found in Info.plist")
    }
    GMSServices.provideAPIKey(apiKey)

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
