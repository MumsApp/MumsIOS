import Foundation
import UIKit

class ReachabilityView: UIView {
    
    var label: UILabel
    
    override init(frame: CGRect) {
        
        self.label = UILabel()
        
        super.init(frame: frame)
        
        self.setupView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        self.backgroundColor = .lightGray
        
        label = UILabel(frame: self.bounds)
        
        label.text = "No internet connection!"
        
        label.font = .systemFont(ofSize: 12)
        
        label.textColor = .black
        
        label.textAlignment = .center
        
        label.center.x = self.center.x
        
        if UIDevice().userInterfaceIdiom == .phone {
            
            switch UIScreen.main.nativeBounds.height {
                
            case 2436:
                
                print("iPhone X")
                
                label.center.y = self.center.y + 15
                
            default:
                
                label.center.y = self.center.y
                
            }
            
        }
        
        self.addSubview(label)
        
        self.alpha = 0
        
        self.showView()
        
    }
    
    func showView() {
        
        UIView.animate(withDuration: 0.3, animations: {
            
            self.alpha = 1
            
        }) { _ in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                
                UIView.animate(withDuration: 0.3, animations: {
                    
                    self.alpha = 0
                    
                }, completion: { _ in
                    
                    self.showView()
                    
                })
                
            }
        }
        
    }
    
    func hideView() {
        
        UIView.animate(withDuration: 0.3) {
            
            self.alpha = 0
            
        }
        
    }
    
}

