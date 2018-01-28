import Foundation
import UIKit

class SchoolView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var v1: UIView!
    
    @IBOutlet weak var v2: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.commonInit()
        
    }
    

    @IBAction func hideButtonPressed(_ sender: UIButton) {
    
        self.v2.isHidden = true
        
        UIView.animate(withDuration: 1) {
        
            self.layoutIfNeeded()
            
        }
    
    }
    
    private func commonInit() {
        
        Bundle.main.loadNibNamed("SchoolView", owner: self, options: nil)
        
        self.addSubview(self.contentView)
        
        self.contentView.frame = self.bounds
        
        self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        self.configureView()
        
    }
    
    private func configureView() {
        
        self.contentView.addShadow()
        
        self.backgroundColor = .clear
        
    }
   
}
