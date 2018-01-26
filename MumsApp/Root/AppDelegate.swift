import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    fileprivate var rootNavigationController: UINavigationController!
    
    private var alertWindow: UIWindow?
    
    var window: UIWindow?
    
    var rootViewController: RootViewController!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.configureRootViewController()
        
        printFonts()
        
        return true
        
    }
    
    func printFonts() {
        let fontFamilyNames = UIFont.familyNames
        for familyName in fontFamilyNames {
            print("------------------------------")
            print("Font Family Name = [\(familyName)]")
            let names = UIFont.fontNames(forFamilyName: familyName as! String)
            print("Font Names = [\(names)]")
        }
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
    
    private func configureRootViewController() {
        
        let navController = self.window!.rootViewController as! UINavigationController
        
        self.rootNavigationController = navController
        
        self.rootViewController = navController.topViewController as! RootViewController
        
        self.rootViewController.delegate = self
        
    }

}

extension AppDelegate: RootViewControllerDelegate {
    
    func rootViewControllerDidFinish(controller: RootViewController) {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let rootViewController = factory.mainRootViewController()
        
        self.window!.rootViewController = rootViewController
        
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
        //            UIApplication.shared.statusBarStyle = .lightContent
        
    }
    
    func rootViewControllerDidLogout(controller: RootViewController) {
        
        self.window!.rootViewController = self.rootNavigationController
        
    }

}
