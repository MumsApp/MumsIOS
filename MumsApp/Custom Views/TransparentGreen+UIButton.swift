import Foundation
import UIKit

class TransparentGreenButton: UIButton {
    
    override func awakeFromNib() {
        
        self.tintColor = .mainGreen
        
        self.titleLabel?.font = .medium(size: 15)
        
    }
    
}
