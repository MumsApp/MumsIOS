import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    /// Navigation controller for RootViewController
    fileprivate var rootNavigationController: UINavigationController!
    
    /// Used to handle problems with internet connection
    //        private var reachability: Reachability!
    
    /// Used to display reachability alerts above status bar
    private var alertWindow: UIWindow?
    
//    private var notificationDelegate: NotificationDelegate!
    
    /// Main window
    var window: UIWindow?
    
    /// RootViewController is an initial view controller
    var rootViewController: RootViewController!
    
    // MARK: - Application configuration and appDelegate methods
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.configureRootViewController()
        
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
    
    
    // MARK: - Configuration
    
    /// Used to configure and set RootViewController
    private func configureRootViewController() {
        
        let navController = self.window!.rootViewController as! UINavigationController
        
        self.rootNavigationController = navController
        
        self.rootViewController = navController.topViewController as! RootViewController
        
        self.rootViewController.delegate = self
        
//        self.notificationDelegate = self.rootViewController
        
    }

}

extension AppDelegate: RootViewControllerDelegate {
    
    /// Used to set MainMenuViewController as a new RootViewController
    func rootViewControllerDidFinish(controller: RootViewController) {
        //
        //            let factory = SecondaryViewControllerFactory.viewControllerFactory()
        //
        //            let rootViewController = factory.mainRootViewController()
        //
        //            self.window!.rootViewController = rootViewController
        //
        //            UIApplication.shared.statusBarStyle = .lightContent
        
    }
    
    /// Used to set MainRootViewController as a new RootViewController with animation
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
    
    /// Used to set RootViewController as a new window rootViewController
    func rootViewControllerDidLogout(controller: RootViewController) {
        
        self.window!.rootViewController = self.rootNavigationController
        
        UIApplication.shared.statusBarStyle = .lightContent
        
    }

}


//    // MARK: - Core Data stack
//
//    lazy var persistentContainer: NSPersistentContainer = {
//        /*
//         The persistent container for the application. This implementation
//         creates and returns a container, having loaded the store for the
//         application to it. This property is optional since there are legitimate
//         error conditions that could cause the creation of the store to fail.
//         */
//        let container = NSPersistentContainer(name: "MumsApp")
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//
//                /*
//                 Typical reasons for an error here include:
//                 * The parent directory does not exist, cannot be created, or disallows writing.
//                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
//                 * The device is out of space.
//                 * The store could not be migrated to the current model version.
//                 Check the error message to determine what the actual problem was.
//                 */
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        return container
//    }()
//
//    // MARK: - Core Data Saving support
//
//    func saveContext () {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }
//
//}

