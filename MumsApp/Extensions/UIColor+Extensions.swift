import Foundation
import UIKit

extension UIColor {
    
    enum Colors: Int {
        
        case BackgroundWhite = 0xfbfdff
        case MainGreen = 0x1fdcc8
        case MainGrey = 0xc8d6e6
        case MainDarkGrey = 0x9ba4bb

    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        
        assert(red >= 0 && red <= 255, "Invalid red component")
        
        assert(green >= 0 && green <= 255, "Invalid green component")
        
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
        
    }
    
    convenience init(netHex:Int) {
        
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
        
    }
    
    public class var backgroundWhite: UIColor {
        
        return UIColor(netHex: Colors.BackgroundWhite.rawValue)
        
    }
    
    
    public class var mainGreen: UIColor {
        
        return UIColor(netHex: Colors.MainGreen.rawValue)
        
    }
    
    public class var mainGrey: UIColor {
        
        return UIColor(netHex: Colors.MainGrey.rawValue)
        
    }

    public class var mainDarkGrey: UIColor {
        
        return UIColor(netHex: Colors.MainDarkGrey.rawValue)
        
    }
    
}
