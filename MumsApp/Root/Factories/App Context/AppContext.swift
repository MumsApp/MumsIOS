import Foundation
import UIKit

let k_token = "token"
let k_is_app_initialized = "is_app_initialized"

protocol AppContext {
    
    func isUserLoggedIn() -> Bool?
    
    func user() -> User?
    
    func clearDataStore()
    
    func token() -> String?
    
    func clearDefaults()
    
    func isAppInitialized() -> Bool
    
    func userId() -> String?
    
}

class AppContextFactory {
    
    private static var dataStore: DataStore!
    
    private static var userDefaults: MOUserDefaults!
    
    class func setupFactory(userDefaults: MOUserDefaults, dataStore: DataStore) {
        
        self.userDefaults = userDefaults
        
        self.dataStore = dataStore
        
    }
    
    class func defaultContext() -> AppContext {
        
        return DefaultAppContext(userDefaults: self.userDefaults, dataStore: self.dataStore)
        
    }
    
}

extension UIViewController {
    
    var appContext: AppContext {
        
        get {
            
            let context = AppContextFactory.defaultContext()
            
            return context
            
        }
        
    }
    
}

struct DefaultAppContext: AppContext {
    
    let dataStore: DataStore
    
    let userDefaults: MOUserDefaults
    
    init(userDefaults: MOUserDefaults, dataStore: DataStore) {
        
        self.userDefaults = userDefaults
        
        self.dataStore = dataStore
        
    }
    
    func isUserLoggedIn() -> Bool? {
        
        let user = self.dataStore.fetchAllEntities(User.self).first as? User
        
        return user != nil
        
    }
    
    func isAppInitialized() -> Bool {
        
        var isInitialized = false
        
        if let initalized =  self.userDefaults.boolForKey(k_is_app_initialized) {
            
            if initalized {
                
                isInitialized = initalized
                
            }
            
        }
        
        return isInitialized
        
    }
    
    func user() -> User? {
        
        if let user = self.dataStore.fetchAllEntities(User.self).first as? User {
            
            return user
            
        }
        
        return nil
        
    }
    
    func clearDataStore() {
        
        self.dataStore.removeAllObjects()
        
        self.dataStore.synchronize()
        
    }
    
    func token() -> String? {
        
        return self.userDefaults.secureStringForKey(k_token)
        
    }
    
    func userId() -> String? {
        
        guard let id = self.userDefaults.integerForKey(k_id) else { return nil }
        
        return String(id)
        
    }
    
    func clearDefaults() {
      
        defaultsDictionary.removeAllObjects()
        
        secureItemsDictionary.removeAllObjects()
        
    }
    
}

