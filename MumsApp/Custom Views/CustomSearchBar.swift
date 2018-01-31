import UIKit

class CustomSearchBar: UISearchBar {
    
    override func awakeFromNib() {
        
        self.tintColor = .mainDarkGrey
        
        self.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)

        self.setImage(UIImage(), for: .search, state: .normal)

        self.setImage(UIImage(), for: .clear, state: .normal)
        
        for view : UIView in (self.subviews[0]).subviews {
            
            if let textField = view as? UITextField {
            
                textField.textColor = .black
    
                textField.attributedPlaceholder = NSAttributedString(string: "Search",
                                                                       attributes: [NSForegroundColorAttributeName: UIColor.mainDarkGrey])

                textField.font = .regular(size: 13)
            
            }
            
        }
        
    }
    
}
