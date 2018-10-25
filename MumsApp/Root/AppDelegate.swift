import UIKit
import FBSDKCoreKit
import Fabric
import Crashlytics
import GoogleMaps
import GoogleSignIn
import GooglePlaces
import SVProgressHUD
import UserNotifications

var DEVICETOKEN = ""

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    fileprivate var rootNavigationController: UINavigationController!
    
    private var alertWindow: UIWindow?
    
    var window: UIWindow?
    
    var rootViewController: RootViewController!
    
    var notificationDelegate: NotificationDelegate!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.configureRootViewController()
        
        self.configureAdditionalLibraries(application: application, launchOptions: launchOptions)
        
        self.window?.backgroundColor = .white
        
        UNUserNotificationCenter.current().delegate = self

        return true
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
        self.rootViewController.didEnterBackground()
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
        self.rootViewController.willTerminate()
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
        self.rootViewController.didBecomeActive()
        
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let handled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        
        return handled
        
    }
    
    private func configureRootViewController() {
        
        let navController = self.window!.rootViewController as! UINavigationController
        
        self.rootNavigationController = navController
        
        self.rootViewController = navController.topViewController as? RootViewController
        
        self.rootViewController.delegate = self
        
        self.notificationDelegate = self.rootViewController

    }
    
    private func configureAdditionalLibraries(application: UIApplication, launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        Fabric.with([Crashlytics.self])
        
        GMSServices.provideAPIKey(GOOGLE_MAPS_KEY)
        
        GMSPlacesClient.provideAPIKey(GOOGLE_MAPS_KEY)
        
        GIDSignIn.sharedInstance().clientID = GOOGLE_SIGNIN_KEY
        
        SVProgressHUD.setDefaultStyle(.custom)
        
        SVProgressHUD.setDefaultMaskType(.gradient)
        
    }
    
}

extension AppDelegate: RootViewControllerDelegate {
    
    func rootViewControllerDidFinish(controller: RootViewController) {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let rootViewController = factory.mainRootViewController()
        
        let navController = UINavigationController(rootViewController: rootViewController)
        
        navController.navigationBar.backgroundColor = .white
        
        navController.navigationBar.isTranslucent = false
        
        self.window!.rootViewController = navController
        
    }
    
    func rootViewControllerDidFinishStartup(controller: RootViewController) {
        
        //            let factory = SecondaryViewControllerFactory.viewControllerFactory()
        //
        //            let rootViewController = factory.mainRootViewController()
        //
        //            showViewControllerWith(newViewController: rootViewController, completion: {
        //
        //                self.window!.rootViewController = rootViewController
        //
        //                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
        //
        //                    if self.receivedRemoteNotification {
        //
        //                        self.rootViewController.showNewMatches()
        //
        //                    }
        //
        //                })
        //
        //            })
        //
        
    }
    
    func rootViewControllerDidLogout(controller: RootViewController) {
        
        self.window!.rootViewController = self.rootNavigationController
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([UNNotificationPresentationOptions.alert,
                           UNNotificationPresentationOptions.sound,
                           UNNotificationPresentationOptions.badge])
        
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        
        DEVICETOKEN = deviceTokenString
        
        self.notificationDelegate.didRegisterForRemoteNotificationsWithDeviceToken(deviceToken: deviceTokenString)
        
        print("APNs device token: \(deviceTokenString)")
        
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
        print("APNs registration failed: \(error)")
        
        self.notificationDelegate.didFailToRegisterForRemoteNotificationsWithError(error: error)
        
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification data: [AnyHashable : Any]) {
        
        print("Push notification received: \(data)")
        
        self.notificationDelegate.didReceiveRemoteNotification(userInfo: data)
        
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        self.notificationDelegate.didReceiveRemoteNotification(userInfo: userInfo)
        
    }

}
