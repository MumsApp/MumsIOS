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
    
    fileprivate var authenticatedNetworkService: AuththenticatedNetworkService!
    
    fileprivate var reachabilityView: ReachabilityView?
    fileprivate var reachabilityWindow: UIWindow?
    
    fileprivate var reachabilityController: UIViewController?
    
    private var userDefaults: MOUserDefaults!
    
    weak var delegate: RootViewControllerDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let networkService = NetworkServiceFactory.networkService()
        
        self.userDefaults = UserDefaultsImpl()
        
        self.authenticatedNetworkService = AuththenticatedNetworkService(networkService: networkService, userDefaults: self.userDefaults)
        
        self.authenticatedNetworkService.delegate = self
        
        FactoryProvider.setupFactory(networkService: self.authenticatedNetworkService, introDelegate: self)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let isInitialized = self.userDefaults.boolForKey(k_is_app_initialized)
        
        let isUserLoggedIn = self.appContext.isUserLoggedIn()
        
        switch (isInitialized, isUserLoggedIn) {
            
        case (true?, true):
            
            self.didFinishIntro()
            
        default:
            
            self.showWelcomeViewController()
            
        }
        
    }
    
    func showWelcomeViewController() {

        let viewControllerFactory = PrimaryViewControllerFactory.viewControllerFactory()

        let controller = viewControllerFactory.welcomeViewController()

        self.navigationController?.pushViewController(controller, animated: false)

    }
    
}

extension RootViewController: AuththenticatedNetworkServiceDelegate {
    
    func authenticatedNetworkServiceShouldReAuthenticate(service: AuththenticatedNetworkService) -> Bool {
        
        return true
        
    }
    
    func authenticatedNetworkServiceURLForAuthentication(service: AuththenticatedNetworkService) -> String {
        
        let refreshSessionURL = "refreshSessionURL"
        
        return refreshSessionURL
        
    }
    
    func authenticatedNetworkService(service: AuththenticatedNetworkService, didReauthenticateWithToken: String) {
        
        print("Did reauthenticate")
        
    }
    
    func authenticatedNetworkService(service: AuththenticatedNetworkService, failedToAuthenticateWithToken: String) {
        
        print("Filed to authenticate")
        
        self.didLogout()
        
    }
    
    func authenticatedNetworkServiceTimeout(service: AuththenticatedNetworkService) {
        
//        self.notReachable(type: .timeout)
        
    }
    
    func authenticatedNetworkServiceConnected(service: AuththenticatedNetworkService) {
        
//        self.reachable()
        
    }
    
}

extension RootViewController: IntroDelegate, LogoutDelegate {

    func didBecomeActive() {
        
    }
    
    func didEnterBackground() {
 
        FactoryProvider.tearDown()
        
    }
    
    func willTerminate() {
        
        FactoryProvider.tearDown()
        
    }
    
    func didFinishIntroWithSuccess() {
        
        self.delegate?.rootViewControllerDidFinish(controller: self)
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    /// Used when user finished intro with success. ViewControllers changed with animation.
    func didFinishIntro() {
        
        self.delegate?.rootViewControllerDidFinish(controller: self)
        
        self.navigationController?.popToRootViewController(animated: false)
        
    }
    
    func didLogout() {
        
        self.appContext.clearDefaults()
        
        self.appContext.clearDataStore()
        
        self.cancelAllRequests()
        
//        self.logout()
        
        FactoryProvider.clearDataSource()
        
        FactoryProvider.tearDown()
        
        UIApplication.shared.endIgnoringInteractionEvents()
        
        self.delegate?.rootViewControllerDidLogout(controller: self)
        
        self.showWelcomeViewController()
        
    }
    
    private func cancelAllRequests() {
        
        self.authenticatedNetworkService.sessionManager.session.getAllTasks { tasks in
            
            tasks.forEach({ $0.cancel() })
            
        }
        
    }
    
    func reachable() {

        self.reachabilityView?.hideView()

        self.reachabilityView?.removeFromSuperview()

        self.reachabilityView = nil

        self.reachabilityController = nil

        self.reachabilityWindow?.removeFromSuperview()

        self.reachabilityWindow = nil

    }
    
    func notReachable(type: ReachabilityType) {

        self.reachable()

        if let mainWindow = UIApplication.shared.keyWindow {

            if self.reachabilityView == nil {

                let height = UIApplication.shared.statusBarFrame.height

                let width = mainWindow.frame.width

                self.reachabilityController = UIViewController()

                self.reachabilityController!.view.frame = CGRect(x: 0, y: 0, width: width, height: height)

                self.reachabilityController!.view.backgroundColor = .clear

                let frame = CGRect(x: 0, y: 0, width: width, height: height)

                if type == .timeout {

                    self.reachabilityView = TimeoutView(frame: frame)

                } else {

                    self.reachabilityView = ReachabilityView(frame: frame)

                }

                self.reachabilityController!.view.addSubview(self.reachabilityView!)

                self.reachabilityWindow = UIWindow(frame: CGRect(x: 0, y: 0, width: width, height: height))

                self.reachabilityWindow!.backgroundColor = .clear

                self.reachabilityWindow!.rootViewController = self.reachabilityController

                self.reachabilityWindow!.windowLevel = UIWindowLevelStatusBar

                self.reachabilityWindow!.isHidden = false

            }

        }

    }
    
}
