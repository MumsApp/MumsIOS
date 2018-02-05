import UIKit
import FBSDKCoreKit
import Fabric
import Crashlytics
import GoogleMaps
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    fileprivate var rootNavigationController: UINavigationController!
    
    private var alertWindow: UIWindow?
    
    var window: UIWindow?
    
    var rootViewController: RootViewController!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.configureRootViewController()
        
        self.configureAdditionalLibraries(application: application, launchOptions: launchOptions)
        
        self.window?.backgroundColor = .white
        
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
        
        let handled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        
        return handled
        
    }
    
    private func configureRootViewController() {
        
        let navController = self.window!.rootViewController as! UINavigationController
        
        self.rootNavigationController = navController
        
        self.rootViewController = navController.topViewController as! RootViewController
        
        self.rootViewController.delegate = self
         
    }
    
    private func configureAdditionalLibraries(application: UIApplication, launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        Fabric.with([Crashlytics.self])
        
        GMSServices.provideAPIKey(GOOGLE_MAPS_KEY)
        
        GIDSignIn.sharedInstance().clientID = GOOGLE_SIGNIN_KEY
        
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

}
