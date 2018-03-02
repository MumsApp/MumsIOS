import Foundation
import UIKit

extension UIViewController {
    
    func showPhotoAlert(imagePicker: UIImagePickerController) {
    
        let actionSheet = UIAlertController(title: "Choose image source", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: UIAlertActionStyle.default, handler: { (_) -> Void in
            
            imagePicker.allowsEditing = false
            
            imagePicker.sourceType = .photoLibrary
            
            self.present(imagePicker, animated: true, completion: nil)
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: UIAlertActionStyle.default, handler: { (_) -> Void in
            
            imagePicker.allowsEditing = false
            
            imagePicker.sourceType = .camera
            
            self.present(imagePicker, animated: true, completion: nil)
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (_) -> Void in
            
            self.dismissViewController()
            
        }))
        
        self.presentViewController(actionSheet)
    
    }
    
}
