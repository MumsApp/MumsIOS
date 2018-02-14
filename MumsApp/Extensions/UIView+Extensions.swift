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

extension UIView {
    
    public func roundCorners(corners: UIRectCorner, withRadius radius:CGFloat) {
        
        self.layer.cornerRadius = radius
        
        let maskPath = UIBezierPath(roundedRect:self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
        
    }
 
    
}
