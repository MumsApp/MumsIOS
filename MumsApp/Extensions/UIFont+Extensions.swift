import Foundation
import UIKit

extension UIFont {
    
    class func regular(size: CGFloat) -> UIFont {
        
        return UIFont(name: "Poppins-Regular", size: size)!
        
    }
    
    class func medium(size: CGFloat) -> UIFont {
        
        return UIFont(name: "Poppins-Medium", size: size)!
        
    }
    
    class func semiBold(size: CGFloat) -> UIFont {
        
        return UIFont(name: "Poppins-SemiBold", size: size)!
        
    }
    
    class func customRegular(size: CGFloat) -> UIFont {
        
        return UIFont(name: "GardenGrownCaps-Regular", size: size)!
        
    }
    
    class func menuRegular(size: CGFloat) -> UIFont {
        
        return UIFont(name: "BebasNeueRegular", size: size)!
        
    }
    
    class func menuBold(size: CGFloat) -> UIFont {
        
        return UIFont(name: "BebasNeueBold", size: size)!
        
    }
    
}

