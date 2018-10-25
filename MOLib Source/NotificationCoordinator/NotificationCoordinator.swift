import UIKit
import UserNotifications

protocol NotificationDelegate {
    
    func didRegisterForRemoteNotificationsWithDeviceToken(deviceToken: String)
    
    func didFailToRegisterForRemoteNotificationsWithError(error: Error)
    
    func didReceiveRemoteNotification(userInfo: [AnyHashable: Any])
    
}

let notify = Notification.Name("NotificationIdentifier")

class NotificationCoordinator {
    
    var socket: MOSocket?
    
    var userDefaults: MOUserDefaults
    
    var presented: Bool = false
    
    init(socket: MOSocket?, userDefaults: MOUserDefaults) {
        
        self.socket = socket
        
        self.userDefaults = userDefaults
        
    }
    
    func getNotificationsStatus() -> Bool {
        
        return UIApplication.shared.isRegisteredForRemoteNotifications
        
    }
    
    func performDeviceRegistrationIfRequired() {
        
        self.registerForNotifications()
        
    }
    
    private func registerForNotifications() {
        
        UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]) {
            granted, error in
            
            if !granted {
                
                self.postNotification()
                
            }
            
        }
        
        UIApplication.shared.registerForRemoteNotifications()
        
    }
    
    private func checkAccess() {
        
        NotificationCenter.default.addObserver(forName: Notification.Name.UIApplicationDidBecomeActive, object: nil, queue: OperationQueue.main) { notification in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                
                if UIApplication.shared.isRegisteredForRemoteNotifications == false {
                    
                    if self.presented { return }
                    
                    self.presented = true
                    
                    self.postNotification()
                    
                }
                
            })
            
        }
        
    }
    
    func registerDeviceWithDeviceToken(token: String, deviceToken: String) {
        
        self.socket?.emitUpdatePushToken(token: token, deviceToken: deviceToken)
        
    }
    
    private func postNotification() {
        
        let isInitialized = self.userDefaults.boolForKey(k_is_app_initialized)
        
        if isInitialized == nil || isInitialized == false  {
            
            NotificationCenter.default.post(name: notify, object: nil)
            
        }
        
    }
    
    func receiveRemoteNotification(_ alert: String) {
        
        self.showLocalNotification(alert)
        
    }
    
    //MARK: Helpers
    
    private func showLocalNotification(_ alert: String) {
        
        print(alert)
        
    }
    
}
