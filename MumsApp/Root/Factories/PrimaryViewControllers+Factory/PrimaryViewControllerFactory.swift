import Foundation
import UIKit

protocol ViewControllerFactory {
    
    associatedtype Factory
    
    static func viewControllerFactory() -> Factory
    
}

class PrimaryViewControllerFactory: ViewControllerFactory {
    
    typealias Factory = PrimaryViewControllerFactory
    
    private var userDefaults: MOUserDefaults
    
    private var dataStore: DataStore
    
    private let serviceFactory = ServiceFactory.serviceFactory()
    
    private let storyboard = Storyboard.Main.rawValue
    
    class func viewControllerFactory() -> PrimaryViewControllerFactory {
        
        let factoryProvider = FactoryProvider()
        
        let factory = PrimaryViewControllerFactory(factoryProvider: factoryProvider)
        
        return factory
        
    }
    
    private init(factoryProvider: FactoryProvider) {
        
        self.userDefaults = factoryProvider.provide()
        
        self.dataStore = factoryProvider.provide()
        
    }
    
    // MARK: - Intro
    
    func welcomeViewController() -> WelcomeViewController {
        
        let controller = UIStoryboard.controllerWithIdentifier(identifier: PrimaryViewController.WelcomeViewController.rawValue, storyboard: storyboard) as! WelcomeViewController
        
        return controller
        
    }
    
    func signUpViewController() -> SignUpViewController {
        
        let controller = UIStoryboard.controllerWithIdentifier(identifier: PrimaryViewController.SignUpViewController.rawValue, storyboard: storyboard) as! SignUpViewController
        
        controller.configureWith(registerService: self.serviceFactory.registerService(),
                                 loginService: self.serviceFactory.loginService(),
                                 facebookService: self.serviceFactory.facebookService(),
                                 googleService: self.serviceFactory.googleService(),
                                 delegate: FactoryProvider().provide())
        
        return controller
        
    }
    
    func signInViewController() -> SignInViewController {
        
        let controller = UIStoryboard.controllerWithIdentifier(identifier: PrimaryViewController.SignInViewController.rawValue, storyboard: storyboard) as! SignInViewController

        controller.configureWith(loginService: self.serviceFactory.loginService(),
                                 facebookService: self.serviceFactory.facebookService(),
                                 googleService: self.serviceFactory.googleService(),
                                 delegate: FactoryProvider().provide())
        
        return controller
        
    }
    
    func createOfficialPageViewController() -> CreateOfficialPageViewController {
        
        let controller = UIStoryboard.controllerWithIdentifier(identifier: PrimaryViewController.CreateOfficialPageViewController.rawValue, storyboard: storyboard) as! CreateOfficialPageViewController
        
        return controller
        
    }
    
    func forgotPasswordViewController() -> ForgotPasswordViewController {
        
        let controller = UIStoryboard.controllerWithIdentifier(identifier: PrimaryViewController.ForgotPasswordViewController.rawValue, storyboard: storyboard) as! ForgotPasswordViewController
        
        return controller
        
    }
    
}

