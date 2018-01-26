import Foundation
import UIKit

class OnboardingGreenButton: UIButton {
    
    override func awakeFromNib() {
        
        self.backgroundColor = .mainGreen
        
        self.tintColor = .white
        
        self.titleLabel?.font = .medium(size: 15)
        
        self.layer.cornerRadius = 4
        
    }
    
}
