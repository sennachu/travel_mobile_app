import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSServices provideAPIKey:@"AIzaSyCAj2o8UWa7wPajNM5_fp2ncDVCsb4Pnw8";
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
