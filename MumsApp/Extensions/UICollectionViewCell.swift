import Foundation
import UIKit

extension UICollectionViewCell {

    func removeTopView() {
        
        for view in self.subviews {
            
            if view.gestureRecognizers?.count != 0 {
                
                if let gestureRecognizers = view.gestureRecognizers {
                    
                    for gesture in gestureRecognizers {
                        
                        if gesture.isKind(of: UILongPressGestureRecognizer.self) {
                            
                            view.removeFromSuperview()
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }

    }
    
    
}
