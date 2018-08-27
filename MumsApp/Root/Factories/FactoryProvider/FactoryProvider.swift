import Foundation

class FactoryProvider {
    
    private static var networkService: NetworkService!
    
    private static var userDefaults: MOUserDefaults!
    
    private static var dataStore: DataStore!
    
    private static var storageDictionary: NSMutableDictionary!

    private static weak var introDelegate: IntroDelegate?
    
    private static var socket: MOSocket!

    class func setupFactory(networkService: NetworkService, introDelegate: IntroDelegate) {
        
        self.networkService = networkService
        
        self.userDefaults = UserDefaultsImpl()
        
        self.dataStore = DataStoreImpl(userDefaults: userDefaults)
        
        self.introDelegate = introDelegate
        
        self.socket = MOSocket()

        AppContextFactory.setupFactory(userDefaults: self.userDefaults, dataStore: self.dataStore)
        

    }
    
    func provide() -> MOUserDefaults {
        
        return FactoryProvider.userDefaults
        
    }
    
    func provide() -> DataStore {
        
        return FactoryProvider.dataStore
        
    }
    
    func provide() -> NetworkService {
        
        return FactoryProvider.networkService
        
    }
    
    func provide() -> IntroDelegate? {

        return FactoryProvider.introDelegate

    }
    
    func provide() -> MOSocket {
        
        return FactoryProvider.socket
        
    }
    
    class func tearDown() {
                
        _ = self.userDefaults.synchronize()
        
    }
    
    class func clearDataSource() {

        
    }
    
}
