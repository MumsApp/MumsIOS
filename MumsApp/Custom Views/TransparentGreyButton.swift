import Foundation
import UIKit

class TransparentGreyButton: UIButton {
    
    override func awakeFromNib() {
        
        self.tintColor = .mainDarkGrey
        
        self.titleLabel?.font = .medium(size: 15)
    
    }
    
}
