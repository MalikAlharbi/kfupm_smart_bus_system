import Flutter
import UIKit
import GoogleMaps                                          

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    var mapKey: String = Bundle.main.infoDictionary?["GOOGLE_MAPS_API_KEY"] as? String ?? ""
    GMSServices.provideAPIKey(mapKey)

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
