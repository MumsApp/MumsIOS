import Foundation
import FBSDKLoginKit

class ServiceFactory {
    
    private var networkService: NetworkService
    
    private var dataStore: DataStore
    
    private var userDefaults: MOUserDefaults
    
    private var parser = Parser()
    
    static func serviceFactory() -> ServiceFactory {
        
        let factoryProvider = FactoryProvider()
        
        let factory = ServiceFactory(factoryProvider: factoryProvider)
        
        return factory
        
    }
    
    private init(factoryProvider: FactoryProvider) {
        
        self.networkService = factoryProvider.provide()
        
        self.dataStore = factoryProvider.provide()
        
        self.userDefaults = factoryProvider.provide()
        
    }
    
    // MARK: - Service Implementation
    
    func registerService() -> RegisterService {
        
        let service = RegisterService(networkService: self.networkService, serviceParser: self.parser)
        
        return service
        
    }
    
    func loginService() -> LoginService {
        
        let parser = LoginServiceParser(userDefaults: self.userDefaults)
        
        let service = LoginService(networkService: self.networkService, serviceParser: parser)
        
        return service
        
    }
    
    func facebookService() -> FacebookService {
        
        let loginManager = FBSDKLoginManager()

        let loginParser = LoginServiceParser(userDefaults: self.userDefaults)
        
        let service = FacebookService(loginManager: loginManager, networkService: self.networkService, serviceParser: self.parser, loginServiceParser: loginParser)
        
        return service
        
    }
    
    func googleService() -> GoogleService {
        
        let loginParser = LoginServiceParser(userDefaults: self.userDefaults)
        
        let service = GoogleService(networkService: self.networkService, serviceParser: self.parser, loginServiceParser: loginParser)
        
        return service
        
    }
    
    func userImageService() -> UserImageService {
        
        let service = UserImageService(networkService: self.networkService)
        
        return service
        
    }
    
    func userDetailsService() -> UserDetailsService {
        
        let service = UserDetailsService(networkService: self.networkService, serviceParser: self.parser)
        
        return service
        
    }
    
    func forgotPasswordService() -> ForgotPasswordService {
        
        let service = ForgotPasswordService(networkService: self.networkService, serviceParser: self.parser)
        
        return service
        
    }
    
    func childService() -> ChildService {
        
        let service = ChildService(networkService: self.networkService, serviceParser: self.parser)
        
        return service
        
    }

    func lobbyService() -> LobbyService {
        
        let service = LobbyService(networkService: self.networkService, serviceParser: self.parser)
        
        return service
        
    }
    
    func addLobbyService() -> AddLobbyService {
        
        let service = AddLobbyService(serviceParser: self.parser, networkService: self.networkService)
        
        return service
        
    }
    
    func lobbyTopicService() -> LobbyTopicService {
        
        let service = LobbyTopicService(networkService: self.networkService, serviceParser: self.parser)
        
        return service
        
    }
    
    func lobbyPostService() -> LobbyPostService {
        
        let service = LobbyPostService(networkService: self.networkService, serviceParser: self.parser)
        
        return service
        
    }
    
    func imageCacheLoader() -> ImageCacheLoader {
        
        return ImageCacheLoader()

    }
    
    func shopCategoryService() -> ShopCategoryService {
        
        let service = ShopCategoryService(networkService: self.networkService, serviceParser: self.parser)
        
        return service
        
    }
    
    func shopService() -> ShopService {
        
        let service = ShopService(networkService: self.networkService, serviceParser: self.parser)
        
        return service
        
    }
}
