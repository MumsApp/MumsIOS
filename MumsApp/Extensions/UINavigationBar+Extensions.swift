import Foundation
import UIKit

extension UINavigationController {
    
    func configureNavigationBarWithTitle(title: String, textColor: UIColor = .black) -> UILabel {
        
        let topText = NSLocalizedString(title, comment: "")
        
        let titleParameters = [NSForegroundColorAttributeName : textColor,
                               NSFontAttributeName : UIFont.medium(size: 20)]
        
        let title = NSMutableAttributedString(string: topText, attributes: titleParameters)
        
        let size = title.size()
        
        let width = size.width
        
        let height = navigationBar.frame.size.height
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: height))
        
        titleLabel.attributedText = title
        
        titleLabel.numberOfLines = 1
        
        titleLabel.textAlignment = .center
        
        return titleLabel
        
    }
    
}

