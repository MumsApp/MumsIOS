import Foundation

/// Used to create a factory of services
class ServiceFactory {
    
    /// Used to call requrests to backend
    private var networkService: NetworkService
    
    /// Used as a storage helper
    private var dataStore: DataStore
    
    /// Used to save data to UserDefaults
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
    
    func sessionService() -> SessionService {
        
        let parser = SessionServiceParser(userDefaults: self.userDefaults)
        
        let service = SessionService(networkService: self.networkService, serviceParser: parser)
        
        return service
        
    }
    
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
    
//    func notificationCoordinatorService() -> NotificationCoordinator {
//
//        let parser = NotificationServiceParser()
//
//        let service = NotificationService(networkService: self.networkService, serviceParser: parser)
//
//        let userEmailServiceParser = UserEmailServiceParser(dataStore: self.dataStore)
//
//        let userEmailService = UserEmailService(networkService: self.networkService, serviceParser: userEmailServiceParser)
//
//        let coordinator = NotificationCoordinator(notificationService: service, userEmailService: userEmailService, userDefaults: self.userDefaults)
//
//        return coordinator
//
//    }

    
}

