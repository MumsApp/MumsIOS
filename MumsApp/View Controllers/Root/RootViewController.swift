import UIKit

protocol RootViewControllerDelegate: class {
    
    func rootViewControllerDidFinish(controller: RootViewController)
    
    func rootViewControllerDidFinishStartup(controller: RootViewController)
    
    func rootViewControllerDidLogout(controller: RootViewController)
    
}

protocol IntroDelegate: class {
    
    func didFinishIntro()
    
    func didFinishIntroWithSuccess()
    
}

protocol LogoutDelegate: class {
    
    func didLogout()
    
}

class RootViewController: UIViewController {
    
    /// Used to handle requests and refresh user session
    fileprivate var authenticatedNetworkService: AuththenticatedNetworkService!
    
    /// Used to handle push notifications
//    fileprivate var notificationCoordinator: NotificationCoordinator!
    
    /// Used to display reachability alert above status bar
//    fileprivate var reachabilityView: ReachabilityView?
    
    /// Used to handle reachabilityController
    fileprivate var reachabilityWindow: UIWindow?
    
    /// Used to handle reachabilityView
    fileprivate var reachabilityController: UIViewController?
    
    /// Used to save properties into UserDefaults
    private var userDefaults: MOUserDefaults!
    
    /// Access to rootViewController delegate
    weak var delegate: RootViewControllerDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let networkService = NetworkServiceFactory.networkService()
        
        self.userDefaults = UserDefaultsImpl()
        
        self.authenticatedNetworkService = AuththenticatedNetworkService(networkService: networkService, userDefaults: self.userDefaults)
        
        self.authenticatedNetworkService.delegate = self
        
        FactoryProvider.setupFactory(networkService: self.authenticatedNetworkService, introDelegate: self)
        
//        self.notificationCoordinator = ServiceFactory.serviceFactory().notificationCoordinatorService()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let isInitialized = self.userDefaults.boolForKey(k_is_app_initialized)
        
        let isUserLoggedIn = self.appContext.isUserLoggedIn()
        
        switch (isInitialized, isUserLoggedIn) {
            
        case (true?, true):
            
            self.didFinishIntro()
            
        default:
            
            self.showIntroViewController()
            
            
        }
        
    }
    
    func showIntroViewController() {

        let viewControllerFactory = PrimaryViewControllerFactory.viewControllerFactory()

        let controller = viewControllerFactory.registerViewController()

        self.navigationController?.pushViewController(controller, animated: false)

    }
    
}

extension RootViewController: AuththenticatedNetworkServiceDelegate {
    
    /// Used if authenticate service should reauthenticate is successfully
    func authenticatedNetworkServiceShouldReAuthenticate(service: AuththenticatedNetworkService) -> Bool {
        
        return true
        
    }
    
    /// Returns refresh session URL
    func authenticatedNetworkServiceURLForAuthentication(service: AuththenticatedNetworkService) -> String {
        
        let refreshSessionURL = "refreshSessionURL"
        
        return refreshSessionURL
        
    }
    
    /// Used if reauthenticate is successfully
    func authenticatedNetworkService(service: AuththenticatedNetworkService, didReauthenticateWithToken: String) {
        
        print("Did reauthenticate")
        
    }
    
    /// Used if reauthenticate failed and logout user
    func authenticatedNetworkService(service: AuththenticatedNetworkService, failedToAuthenticateWithToken: String) {
        
        print("Filed to authenticate")
        
        self.didLogout()
        
    }
    
    /// Used if authenticated service received timout and display reachabilityView
    func authenticatedNetworkServiceTimeout(service: AuththenticatedNetworkService) {
        
//        self.notReachable(type: .timeout)
        
    }
    
    /// Used if authenticated service received connection and removes reachabilityView
    func authenticatedNetworkServiceConnected(service: AuththenticatedNetworkService) {
        
//        self.reachable()
        
    }
    
}

extension RootViewController: IntroDelegate, LogoutDelegate {
    
    /// Used to setup correct user id on Mixpanel
    func didBecomeActive() {
        
    }
    
    /// Used to close session on mixpanel and save DataStore and UserDefaults
    func didEnterBackground() {
 
        FactoryProvider.tearDown()
        
    }
    
    /// Used to save DataStore and UserDefaults
    func willTerminate() {
        
        FactoryProvider.tearDown()
        
    }
    
    /// Used when user finished intro with success. ViewControllers changed without animation.
    func didFinishIntroWithSuccess() {
        
        self.delegate?.rootViewControllerDidFinish(controller: self)
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    /// Used when user finished intro with success. ViewControllers changed with animation.
    func didFinishIntro() {
        
        self.delegate?.rootViewControllerDidFinish(controller: self)
        
        self.navigationController?.popToRootViewController(animated: false)
        
    }
    
    /// Used to logout user and clean all data
    func didLogout() {
        
        self.appContext.clearDefaults()
        
        self.appContext.clearDataStore()
        
        self.cancelAllRequests()
        
//        self.logout()
        
        FactoryProvider.clearDataSource()
        
        FactoryProvider.tearDown()
        
        UIApplication.shared.endIgnoringInteractionEvents()
        
        self.delegate?.rootViewControllerDidLogout(controller: self)
        
//        self.showIntroViewController()
        
    }
    
    /// Used to cancel all active requests
    private func cancelAllRequests() {
        
        self.authenticatedNetworkService.sessionManager.session.getAllTasks { tasks in
            
            tasks.forEach({ $0.cancel() })
            
        }
        
    }
    
    /// Used to remove and dealloc reachabilityView
//    func reachable() {
//
//        self.reachabilityView?.hideView()
//
//        self.reachabilityView?.removeFromSuperview()
//
//        self.reachabilityView = nil
//
//        self.reachabilityController = nil
//
//        self.reachabilityWindow?.removeFromSuperview()
//
//        self.reachabilityWindow = nil
//
//    }
    
    /// Used to display reachabilityView. Timeout or Closed connection possible.
//    func notReachable(type: ReachabilityType) {
//
//        self.reachable()
//
//        if let mainWindow = UIApplication.shared.keyWindow {
//
//            if self.reachabilityView == nil {
//
//                let height = UIApplication.shared.statusBarFrame.height
//
//                let width = mainWindow.frame.width
//
//                self.reachabilityController = UIViewController()
//
//                self.reachabilityController!.view.frame = CGRect(x: 0, y: 0, width: width, height: height)
//
//                self.reachabilityController!.view.backgroundColor = .clear
//
//                let frame = CGRect(x: 0, y: 0, width: width, height: height)
//
//                if type == .timeout {
//
//                    self.reachabilityView = TimeoutView(frame: frame)
//
//                } else {
//
//                    self.reachabilityView = ReachabilityView(frame: frame)
//
//                }
//
//                self.reachabilityController!.view.addSubview(self.reachabilityView!)
//
//                self.reachabilityWindow = UIWindow(frame: CGRect(x: 0, y: 0, width: width, height: height))
//
//                self.reachabilityWindow!.backgroundColor = .clear
//
//                self.reachabilityWindow!.rootViewController = self.reachabilityController
//
//                self.reachabilityWindow!.windowLevel = UIWindowLevelStatusBar
//
//                self.reachabilityWindow!.isHidden = false
//
//            }
//
//        }
//
//    }
    
}

//extension RootViewController: NotificationDelegate {
//
//    /// Used to register push notifications on beckend
//    func didRegisterForRemoteNotificationsWithDeviceToken(deviceToken: String) {
//
//        guard let id = self.appContext.user()?.id, let tokens = self.appContext.accessToken() else { return }
//
////        self.notificationCoordinator.registerDeviceWithDeviceToken(id: id, parameters: tokens, deviceToken: deviceToken)
//
//    }
//
//    /// Used if notificationCoordinator receive error
//    func didFailToRegisterForRemoteNotificationsWithError(error: Error) {
//
//        print("Show alert informing them to update at any time in settings")
//
//    }
//
//    /// Used to handle push notifications
//    func didReceiveRemoteNotification(userInfo: [AnyHashable: Any]) {
//
//        UIApplication.shared.applicationIconBadgeNumber = 0
//
//    }
//
//}

