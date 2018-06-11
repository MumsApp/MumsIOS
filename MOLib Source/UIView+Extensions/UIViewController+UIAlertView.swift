import UIKit

extension UIViewController {
    
    public func showOkAlertWith(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in
            
            mainRootVC?.showButtons()
            
        }))
        
        self.presentViewController(alertController)
        
    }
    
    public func showOkAlertWith(title: String, message: String, completion: @escaping (UIAlertAction) -> ()) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in
            
            mainRootVC?.showButtons()
            
            completion(action)

        }))
        
        self.presentViewController(alertController)
        
    }
    
    public func showErrorWith(_ title: String, message: String, completion: @escaping (UIAlertAction) -> ()) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { action in
            
            mainRootVC?.showButtons()
 
            completion(action)
            
        }))
        
        self.presentViewController(alertController)
        
    }

}
