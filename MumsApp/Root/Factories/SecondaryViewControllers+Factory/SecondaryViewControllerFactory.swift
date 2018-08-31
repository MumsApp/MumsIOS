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
        
        controller.configureWith(socket: self.serviceFactory.socketService())
        
        return controller
        
    }
 
    func profileViewController() -> ProfileViewController {
        
        let controller = UIStoryboard.controllerWithIdentifier(identifier: SecondaryViewController.ProfileViewController.rawValue, storyboard: storyboard) as! ProfileViewController
        
        controller.configureWith(userDetailsService: self.serviceFactory.userDetailsService(),
                                 childService: self.serviceFactory.childService(),
                                 userImageService: self.serviceFactory.userImageService(),
                                 userDefaults: self.userDefaults,
                                 friendsService: self.serviceFactory.friendsService())
        
        return controller
        
    }
    
    func locationPopupViewController(delegate: LocationPopupDelegate?, type: LocationPopupType) -> LocationPopupViewController {
        
        let controller = UIStoryboard.controllerWithIdentifier(identifier: SecondaryViewController.LocationPopupViewController.rawValue, storyboard: storyboard) as! LocationPopupViewController
        
        controller.configureWith(userDetailsService: self.serviceFactory.userDetailsService(), delegate: delegate, type: type)
        
        return controller
        
    }
    
    func lobbyViewController() -> LobbyViewController {
        
        let controller = UIStoryboard.controllerWithIdentifier(identifier: SecondaryViewController.LobbyViewController.rawValue, storyboard: storyboard) as! LobbyViewController
        
        controller.configureWith(lobbyService: self.serviceFactory.lobbyService())
        
        return controller
        
    }
    
    func profileSettingsPopupViewController(mainRootViewController: UIViewController?) -> ProfileSettingsPopupViewController {
        
        let controller = UIStoryboard.controllerWithIdentifier(identifier: SecondaryViewController.ProfileSettingsPopupViewController.rawValue, storyboard: storyboard) as! ProfileSettingsPopupViewController
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let rootViewController = appDelegate.rootViewController
        
        controller.configureWith(delegate: rootViewController!, rootViewController: mainRootViewController)
        
        return controller
        
    }
    
    func organisationViewController() -> OrganisationViewController {
        
        let controller = UIStoryboard.controllerWithIdentifier(identifier: SecondaryViewController.OrganisationViewController.rawValue, storyboard: storyboard) as! OrganisationViewController
        
        return controller
        
    }
    
    func chatViewController() -> ChatViewController {
        
        let controller = UIStoryboard.controllerWithIdentifier(identifier: SecondaryViewController.ChatViewController.rawValue, storyboard: storyboard) as! ChatViewController
        
        controller.configureWith(friendsService: self.serviceFactory.friendsService())
        
        return controller
        
    }
    
    func chatSettingsPopupViewController() -> ChatSettingsPopupViewController {
        
        let controller = UIStoryboard.controllerWithIdentifier(identifier: SecondaryViewController.ChatSettingsPopupViewController.rawValue, storyboard: storyboard) as! ChatSettingsPopupViewController
        
        return controller
        
    }
    
    func shopViewController(type: ShopViewType) -> ShopViewController {
        
        let controller = UIStoryboard.controllerWithIdentifier(identifier: SecondaryViewController.ShopViewController.rawValue, storyboard: storyboard) as! ShopViewController
        
        controller.configureWith(type: type, shopService: self.serviceFactory.shopService())
        
        return controller
        
    }
    
    func productDetailsViewController(product: Product, type: ShopViewType) -> ProductDetailsViewController {
        
        let controller = UIStoryboard.controllerWithIdentifier(identifier: SecondaryViewController.ProductDetailsViewController.rawValue, storyboard: storyboard) as! ProductDetailsViewController
        
        controller.configureWith(product: product, type: type)
        
        return controller
        
    }
    
    func shopMenuViewController(delegate: ShopMenuDelegate?, type: ShopViewType) -> ShopMenuViewController {
        
        let controller = UIStoryboard.controllerWithIdentifier(identifier: SecondaryViewController.ShopMenuViewController.rawValue, storyboard: storyboard) as! ShopMenuViewController
        
        controller.configureWith(delegate: delegate, type: type)
        
        return controller
        
    }
    
    func myProductViewController(type: ShopViewType) -> MyProductsViewController {
        
        let controller = UIStoryboard.controllerWithIdentifier(identifier: SecondaryViewController.MyProductsViewController.rawValue, storyboard: storyboard) as! MyProductsViewController
        
        controller.configureWith(shopService: self.serviceFactory.shopService(), type: type)
        
        return controller
        
    }
    
    func addProductViewController(productOptional: Product? = nil, type: ShopViewType) -> AddProductViewController {
        
        let controller = UIStoryboard.controllerWithIdentifier(identifier: SecondaryViewController.AddProductViewController.rawValue, storyboard: storyboard) as! AddProductViewController
        
        controller.configureWith(shopService: self.serviceFactory.shopService(), imageLoader: self.serviceFactory.imageCacheLoader(), productOptional: productOptional, type: type)
        
        return controller
        
    }
    
    func createCategoryViewController(reloadDelegate: ReloadDelegate?) -> CreateCategoryViewController {
        
        let controller = UIStoryboard.controllerWithIdentifier(identifier: SecondaryViewController.CreateCategoryViewController.rawValue, storyboard: storyboard) as! CreateCategoryViewController
        
        controller.configureWith(addLobbyService: self.serviceFactory.addLobbyService(), reloadDelegate: reloadDelegate)
        
        return controller
        
    }
    
    func createTopicViewController(roomId: String, reloadDelegate: ReloadDelegate?) -> CreateTopicViewController {
        
        let controller = UIStoryboard.controllerWithIdentifier(identifier: SecondaryViewController.CreateTopicViewController.rawValue, storyboard: storyboard) as! CreateTopicViewController
        
        controller.configureWith(roomId: roomId, lobbyTopicService: self.serviceFactory.lobbyTopicService(), reloadDelegate: reloadDelegate)
        
        return controller
        
    }
    
    func lobbyDetailsViewController(roomId: String, title: String, backButton: Bool) -> LobbyDetailsViewController {
        
        let controller = UIStoryboard.controllerWithIdentifier(identifier: SecondaryViewController.LobbyDetailsViewController.rawValue, storyboard: storyboard) as! LobbyDetailsViewController
        
        controller.configureWith(roomId: roomId, title: title, backButton: backButton, lobbyTopicService: self.serviceFactory.lobbyTopicService(), lobbyService: self.serviceFactory.lobbyService())
        
        return controller
        
    }
    
    func myWishlistViewController(type: ShopViewType) -> MyWishlistViewController {
        
        let controller = UIStoryboard.controllerWithIdentifier(identifier: SecondaryViewController.MyWishlistViewController.rawValue, storyboard: storyboard) as! MyWishlistViewController
        
        controller.configureWith(shopService: self.serviceFactory.shopService(), type: type)
        
        return controller
        
    }
    
    func shopFilterViewController(delegate: ShopFilterViewControllerDelegate?, type: ShopViewType) -> ShopFilterViewController {
        
        let controller = UIStoryboard.controllerWithIdentifier(identifier: SecondaryViewController.ShopFilterViewController.rawValue, storyboard: storyboard) as! ShopFilterViewController
        
        controller.configureWith(shopService: self.serviceFactory.shopService(), delegate: delegate, type: type)
        
        return controller
        
    }
    
    func addMembersViewController() -> AddMembersViewController {
        
        let controller = UIStoryboard.controllerWithIdentifier(identifier: SecondaryViewController.AddMembersViewController.rawValue, storyboard: storyboard) as! AddMembersViewController
        
        return controller
        
    }
    
    func userViewController(userId: String) -> UserViewController {
        
        let controller = UIStoryboard.controllerWithIdentifier(identifier: SecondaryViewController.UserViewController.rawValue, storyboard: storyboard) as! UserViewController
        
        controller.configureWith(userId: userId,
                                 userDetailsService: self.serviceFactory.userDetailsService(),
                                 friendsService: self.serviceFactory.friendsService())
        
        return controller
        
    }
    
    func removeContactPopupViewController(delegate: RemoveContactPopupViewControllerDelegate?, userDetails: UserDetails?) -> RemoveContactPopupViewController {
        
        let controller = UIStoryboard.controllerWithIdentifier(identifier: SecondaryViewController.RemoveContactPopupViewController.rawValue, storyboard: storyboard) as! RemoveContactPopupViewController
        
        controller.configureWith(delegate: delegate, userDetails: userDetails)
        
        return controller
        
    }
    
    func removeCompanyPopupViewController() -> RemoveCompanyPopupViewController {
        
        let controller = UIStoryboard.controllerWithIdentifier(identifier: SecondaryViewController.RemoveCompanyPopupViewController.rawValue, storyboard: storyboard) as! RemoveCompanyPopupViewController
        
        return controller
        
    }

    func removeProductPopupViewController(product: Product, productImage: UIImage, delegate: RemoveProductPopupViewControllerDelegate?) -> RemoveProductPopupViewController {
        
        let controller = UIStoryboard.controllerWithIdentifier(identifier: SecondaryViewController.RemoveProductPopupViewController.rawValue, storyboard: storyboard) as! RemoveProductPopupViewController
        
        controller.configureWith(product: product, productImage: productImage, shopService: self.serviceFactory.shopService(), delegate: delegate)
        
        return controller
        
    }
    
    func productAddedPopupViewController() -> ProductAddedPopupViewController {
        
        let controller = UIStoryboard.controllerWithIdentifier(identifier: SecondaryViewController.ProductAddedPopupViewController.rawValue, storyboard: storyboard) as! ProductAddedPopupViewController
        
        return controller
        
    }
    
    func conversationViewController() -> ConversationViewController {
        
        let controller = UIStoryboard.controllerWithIdentifier(identifier: SecondaryViewController.ConversationViewController.rawValue, storyboard: storyboard) as! ConversationViewController
        
        return controller
        
    }
    
    func userNamePopupViewController() -> UserNamePopupViewController {
        
        let controller = UIStoryboard.controllerWithIdentifier(identifier: SecondaryViewController.UserNamePopupViewController.rawValue, storyboard: storyboard) as! UserNamePopupViewController
        
        return controller
        
    }
    
    func offersViewController() -> OffersViewController {
        
        let controller = UIStoryboard.controllerWithIdentifier(identifier: SecondaryViewController.OffersViewController.rawValue, storyboard: storyboard) as! OffersViewController
        
        return controller
        
    }
    
    func shopCategoriesViewController(delegate: ShopCategoriesViewControllerDelegate?) -> ShopCategoriesViewController {
        
        let controller = UIStoryboard.controllerWithIdentifier(identifier: SecondaryViewController.ShopCategoriesViewController.rawValue, storyboard: storyboard) as! ShopCategoriesViewController
        
        controller.configureWith(delegate: delegate, shopCategoryService: self.serviceFactory.shopCategoryService())
        
        return controller
        
    }
    
    func promotionViewController() -> PromotionViewController {
        
        let controller = UIStoryboard.controllerWithIdentifier(identifier: SecondaryViewController.PromotionViewController.rawValue, storyboard: storyboard) as! PromotionViewController
        
        return controller
        
    }
    
    func promotionPopupViewController() -> PromotionPopupViewController {
        
        let controller = UIStoryboard.controllerWithIdentifier(identifier: SecondaryViewController.PromotionPopupViewController.rawValue, storyboard: storyboard) as! PromotionPopupViewController
        
        return controller
        
    }
    
    func schoolsViewController() -> SchoolsViewController {
        
        let controller = UIStoryboard.controllerWithIdentifier(identifier: SecondaryViewController.SchoolsViewController.rawValue, storyboard: storyboard) as! SchoolsViewController
        
        return controller

    }

    func addSchoolViewController() -> AddSchoolViewController {
        
        let controller = UIStoryboard.controllerWithIdentifier(identifier: SecondaryViewController.AddSchoolViewController.rawValue, storyboard: storyboard) as! AddSchoolViewController
        
        return controller
        
    }
    
    func addChildrenPopupViewController(type: ChildrenType, delegate: AddChildrenPopupViewControllerDelegate?, children: Children?) -> AddChildrenPopupViewController {
        
        let controller = UIStoryboard.controllerWithIdentifier(identifier: SecondaryViewController.AddChildrenPopupViewController.rawValue, storyboard: storyboard) as! AddChildrenPopupViewController
        
        controller.configureWith(type: type, delegate: delegate, childService: self.serviceFactory.childService(), children: children)
        
        return controller
        
    }
    
    func addToMenuViewController() -> AddToMenuViewController {
        
        let controller = UIStoryboard.controllerWithIdentifier(identifier: SecondaryViewController.AddToMenuViewController.rawValue, storyboard: storyboard) as! AddToMenuViewController
        
        return controller
        
    }
    
    func lobbyConversationViewController(shouldReply: Bool, roomId: String, topicId: String, title: String) -> LobbyConversationViewController {
        
        let controller = UIStoryboard.controllerWithIdentifier(identifier: SecondaryViewController.LobbyConversationViewController.rawValue, storyboard: storyboard) as! LobbyConversationViewController
        
        controller.configureWith(shouldReply: shouldReply, roomId: roomId, topicId: topicId, title: title, lobbyPostService: self.serviceFactory.lobbyPostService())
        
        return controller
        
    }
    
    func friendsViewController() -> FriendsViewController {
        
        let controller = UIStoryboard.controllerWithIdentifier(identifier: SecondaryViewController.FriendsViewController.rawValue, storyboard: storyboard) as! FriendsViewController
        
        controller.configureWith(friendsService: self.serviceFactory.friendsService())
        
        return controller
        
    }
    
    func servicePaymentPopupViewController(delegate: ServicePaymentPopupViewControllerDelegate?) -> ServicePaymentPopupViewController {
        
        let controller = UIStoryboard.controllerWithIdentifier(identifier: SecondaryViewController.ServicePaymentPopupViewController.rawValue, storyboard: storyboard) as! ServicePaymentPopupViewController
        
        controller.configureWith(inAppPurchaseHelper: self.serviceFactory.inAppPurchaseHelper(), delegate: delegate)
        
        return controller
        
    }
    
}
