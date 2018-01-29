import Foundation
import UIKit

class ChildrenView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var childrenLabel: UILabel!
    
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var ageLabel: UILabel!
    
    @IBOutlet weak var numberTextField: UITextField!
    
    @IBOutlet weak var minusButton: UIButton!
    
    @IBOutlet weak var plusButton: UIButton!
    
    @IBOutlet weak var minLabel: UILabel!
    
    @IBOutlet weak var maxLabel: UILabel!
    
    @IBOutlet weak var slider: RangeSeekSlider!
    
    var count = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.commonInit()
        
    }
    
    private func commonInit() {
        
        Bundle.main.loadNibNamed("ChildrenView", owner: self, options: nil)
        
        self.addSubview(self.contentView)
        
        self.contentView.frame = self.bounds
        
        self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        self.configureView()
        
    }
    
    private func configureView() {
        
        self.contentView.addShadow()
        
        self.backgroundColor = .clear
        
        self.childrenLabel.font = .semiBold(size: 15)
        
        self.childrenLabel.textColor = .black
        
        self.numberLabel.font = .regular(size: 12)
        
        self.numberLabel.textColor = .mainDarkGrey
        
        self.ageLabel.font = .regular(size: 12)
        
        self.ageLabel.textColor = .mainDarkGrey

        self.numberTextField.font = .regular(size: 13)
        
        self.minLabel.font = .regular(size: 12)
        
        self.maxLabel.font = .regular(size: 12)

        self.minusButton.layer.cornerRadius = 4
        
        self.plusButton.layer.cornerRadius = 4
        
        self.slider.delegate = self
        
    }
    
    @IBAction func minusButtonPressed(_ sender: UIButton) {
    
        if self.count > 0 {
            
            self.count -= 1
            
        }
    
        self.numberTextField.text = String(count)

    }
    
    @IBAction func plusButtonPressed(_ sender: UIButton) {
    
        self.count += 1
    
        self.numberTextField.text = String(count)
    
    }
    
}

extension ChildrenView: RangeSeekSliderDelegate {
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        
        self.minLabel.text = String(describing: Int(minValue))
        
        self.maxLabel.text = String(describing: Int(maxValue))
        
    }
    
}
