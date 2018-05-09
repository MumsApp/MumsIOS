import Foundation
import UIKit

class CardsView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var cardsLabel: UILabel!
    
    @IBOutlet weak var containerStackView: UIStackView!

    @IBOutlet weak var detailsView: UIView!

    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var scanButton: UIButton!
    
    @IBOutlet weak var cardNameLabel: UILabel!
    
    @IBOutlet weak var emergencyLabel: UILabel!
    
    @IBOutlet weak var containerStackViewHeightConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.commonInit()
        
    }
    
    private func commonInit() {
        
        Bundle.main.loadNibNamed("CardsView", owner: self, options: nil)
        
        self.addSubview(self.contentView)
        
        self.contentView.frame = self.bounds
        
        self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        self.configureView()
        
    }
    
    private func configureView() {
        
        self.contentView.addShadow()
        
        self.backgroundColor = .clear
        
        self.cardsLabel.font = .semiBold(size: 15)
        
        self.cardsLabel.textColor = .black

        self.addButton.titleLabel?.font = .medium(size: 15)
        
        self.addButton.tintColor = .mainGreen
        
        self.cardNameLabel.font = .regular(size: 12)
        
        self.emergencyLabel.font = .regular(size: 12)
        
        self.scanButton.titleLabel?.font = .medium(size: 13)
    
    }

    @IBAction func switchChanged(_ sender: UISwitch) {
        
        
    }
    
    @IBAction func scanButtonPressed(_ sender: UIButton) {
    
        
    
    }
    
}
