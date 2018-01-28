import UIKit

class LocationView: UIView {

    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var locationLabel: UILabel!

    @IBOutlet weak var userLocationLabel: UILabel!
    
    @IBOutlet weak var changeButton: UIButton!
    
    @IBOutlet weak var mapView: CustomMapView!
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.commonInit()
        
    }
    
    private func commonInit() {
        
        Bundle.main.loadNibNamed("LocationView", owner: self, options: nil)
        
        self.addSubview(self.contentView)
        
        self.contentView.frame = self.bounds
        
        self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        self.configureView()
        
    }
    
    private func configureView() {
        
        self.contentView.addShadow()
        
        self.backgroundColor = .clear
        
        self.locationLabel.font = .semiBold(size: 20)
        
        self.locationLabel.textColor = .black
        
        self.userLocationLabel.font = .regular(size: 12)
        
        self.userLocationLabel.textColor = .mainDarkGrey
        
    }
    
    @IBAction func changeButtonPressed(_ sender: UIButton) {
    }
    
}
