import Foundation
import UIKit

protocol ViewControllerFactory {
    
    associatedtype Factory
    
    static func viewControllerFactory() -> Factory
    
}

/// Used to create a factory of View Controllers contained in Main Storyboard
class PrimaryViewControllerFactory: ViewControllerFactory {
    
    typealias Factory = PrimaryViewControllerFactory
    
    /// Used to save data to UserDefaults
    private var userDefaults: MOUserDefaults
    
    /// Used as a storage helper
    private var dataStore: DataStore
    
    /// Used to create access to ServiceFactory
    private let serviceFactory = ServiceFactory.serviceFactory()
    
    /// Used to create an access to storyboard name and keep the code clean
    private let main = Storyboard.Main.rawValue
    
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
    
    func registerViewController() -> RegisterViewController {
        
        let controller = UIStoryboard.controllerWithIdentifier(identifier: PrimaryViewController.RegisterViewController.rawValue, storyboard: main) as! RegisterViewController
        
        controller.configureWith(registerService: self.serviceFactory.registerService(),
                                 loginService: self.serviceFactory.loginService())
        
        return controller
        
    }
   
}

