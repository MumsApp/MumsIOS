import Foundation

/// Used to create as a factory of all required classes
class FactoryProvider {
    
    /// Used to call requrests to backend
    private static var networkService: NetworkService!
    
    /// Used to save data to UserDefaults
    private static var userDefaults: MOUserDefaults!
    
    /// Used as a storage helper
    private static var dataStore: DataStore!
    
    /// Used as a main storage dictionary
    private static var storageDictionary: NSMutableDictionary!
    
    /** Access to intro delegate
     * func didFinishIntro()
     * func didFinishIntroWithSuccess()
     */
    private static weak var introDelegate: IntroDelegate?
    
    class func setupFactory(networkService: NetworkService, introDelegate: IntroDelegate) {
        
        self.networkService = networkService
        
        self.userDefaults = UserDefaultsImpl()
        
        self.dataStore = DataStoreImpl(userDefaults: userDefaults)
        
//        self.introDelegate = introDelegate
        
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
    
//    func provideUser() -> DataSourceUser {
//
//        return FactoryProvider.dataSourceUser
//
//    }
    
    /// Used to save data to UserDefaults
    class func tearDown() {
        
        self.dataStore.synchronize()
        
        _ = self.userDefaults.synchronize()
        
    }
    
    /// Used to clean all dataSources and searching properties
    class func clearDataSource() {

        
    }
    
}

