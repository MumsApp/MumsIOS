import Foundation
import UIKit

class MainGreenButton: UIButton {
    
    override func awakeFromNib() {
        
        self.tintColor = .mainGreen
        
        self.titleLabel?.font = .regular(size: 12)
        
    }
    
}
