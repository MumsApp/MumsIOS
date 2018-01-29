import Foundation
import FBSDKLoginKit

class ServiceFactory {
    
    private var networkService: NetworkService
    
    private var dataStore: DataStore
    
    private var userDefaults: MOUserDefaults
    
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
        
        let parser = RegisterServiceParser()
        
        let service = RegisterService(networkService: self.networkService, serviceParser: parser)
        
        return service
        
    }
    
    func loginService() -> LoginService {
        
        let parser = LoginServiceParser(userDefaults: self.userDefaults)
        
        let service = LoginService(networkService: self.networkService, serviceParser: parser)
        
        return service
        
    }
    
    func facebookService() -> FacebookService {
        
        let loginManager = FBSDKLoginManager()

        let registerParser = RegisterServiceParser()

        let loginParser = LoginServiceParser(userDefaults: self.userDefaults)
        
        let service = FacebookService(loginManager: loginManager, networkService: self.networkService, serviceParser: registerParser, loginServiceParser: loginParser)
        
        return service
        
    }
    
    func googleService() -> GoogleService {
        
        let registerParser = RegisterServiceParser()
        
        let loginParser = LoginServiceParser(userDefaults: self.userDefaults)
        
        let service = GoogleService(networkService: self.networkService, serviceParser: registerParser, loginServiceParser: loginParser)
        
        return service
        
    }
    
}

