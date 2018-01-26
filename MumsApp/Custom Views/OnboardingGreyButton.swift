import Foundation
import UIKit

class OnboardingGreyButton: UIButton {
    
    override func awakeFromNib() {
        
        self.backgroundColor = .mainGrey
        
        self.tintColor = .white
        
        self.titleLabel?.font = .medium(size: 15)
        
        self.layer.cornerRadius = 4
        
    }
    
}
