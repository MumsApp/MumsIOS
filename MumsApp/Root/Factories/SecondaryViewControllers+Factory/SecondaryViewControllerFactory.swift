import Foundation
import UIKit

class SecondaryViewControllerFactory: ViewControllerFactory {
    
    typealias Factory = SecondaryViewControllerFactory
    
    private var userDefaults: MOUserDefaults
    
    private var dataStore: DataStore
    
    private let serviceFactory = ServiceFactory.serviceFactory()
    
    private let storyboard = Storyboard.Secondary.rawValue
    
    class func viewControllerFactory() -> SecondaryViewControllerFactory {
        
        let factoryProvider = FactoryProvider()
        
        let factory = SecondaryViewControllerFactory(factoryProvider: factoryProvider)
        
        return factory
        
    }
    
    private init(factoryProvider: FactoryProvider) {
        
        self.userDefaults = factoryProvider.provide()
        
        self.dataStore = factoryProvider.provide()
        
    }
    
    // MARK: - Main
    
    func mainRootViewController() -> MainRootViewController {
        
        let controller = UIStoryboard.controllerWithIdentifier(identifier: SecondaryViewController.MainRootViewController.rawValue, storyboard: storyboard) as! MainRootViewController
        
        return controller
        
    }
 
    func profileViewController() -> ProfileViewController {
        
        let controller = UIStoryboard.controllerWithIdentifier(identifier: SecondaryViewController.ProfileViewController.rawValue, storyboard: storyboard) as! ProfileViewController
        
        return controller
        
    }
    
    func locationPopupViewController() -> LocationPopupViewController {
        
        let controller = UIStoryboard.controllerWithIdentifier(identifier: SecondaryViewController.LocationPopupViewController.rawValue, storyboard: storyboard) as! LocationPopupViewController
        
        return controller
        
    }
    
    func lobbyViewController() -> LobbyViewController {
        
        let controller = UIStoryboard.controllerWithIdentifier(identifier: SecondaryViewController.LobbyViewController.rawValue, storyboard: storyboard) as! LobbyViewController
        
        return controller
        
    }
    
    func profileSettingsPopupViewController(mainRootViewController: UIViewController?) -> ProfileSettingsPopupViewController {
        
        let controller = UIStoryboard.controllerWithIdentifier(identifier: SecondaryViewController.ProfileSettingsPopupViewController.rawValue, storyboard: storyboard) as! ProfileSettingsPopupViewController
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let rootViewController = appDelegate.rootViewController
        
        controller.configureWith(delegate: rootViewController!, rootViewController: mainRootViewController)
        
        return controller
        
    }
    
    func chatViewController() -> ChatViewController {
        
        let controller = UIStoryboard.controllerWithIdentifier(identifier: SecondaryViewController.ChatViewController.rawValue, storyboard: storyboard) as! ChatViewController
        
        return controller
        
    }
    
    func chatSettingsPopupViewController() -> ChatSettingsPopupViewController {
        
        let controller = UIStoryboard.controllerWithIdentifier(identifier: SecondaryViewController.ChatSettingsPopupViewController.rawValue, storyboard: storyboard) as! ChatSettingsPopupViewController
        
        return controller
        
    }
    
    func shopViewController() -> ShopViewController {
        
        let controller = UIStoryboard.controllerWithIdentifier(identifier: SecondaryViewController.ShopViewController.rawValue, storyboard: storyboard) as! ShopViewController
        
        return controller
        
    }
    
}
