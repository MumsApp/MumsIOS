import Foundation
import UIKit

extension UIView {

    func addShadow() {
        
        self.layer.cornerRadius = 4
        
        self.layer.shadowColor = UIColor.shadowColor.cgColor
        
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        
        self.layer.shadowOpacity = 0.15
        
        self.layer.shadowRadius = 10.0
        
        self.layer.masksToBounds = false
        
    }
    
}
