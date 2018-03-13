import UIKit

protocol LocationViewDelegate: class {
    
    func showSwitchValueChanged(isVisible: Bool)
    func changeLocationButtonPressed()
    
}

class LocationView: UIView {

    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var locationLabel: UILabel!

    @IBOutlet weak var userLocationLabel: UILabel!
    
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var mapView: CustomMapView!
   
    @IBOutlet weak var showSwitch: UISwitch!
    
    private weak var delegate: LocationViewDelegate?
    
    func configureWith(delegate: LocationViewDelegate) {
        
        self.delegate = delegate
        
    }
    
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
    
    func configureView() {
        
        self.contentView.addShadow()
        
        self.backgroundColor = .clear
        
        self.locationLabel.font = .semiBold(size: 15)
        
        self.locationLabel.textColor = .black
        
        self.userLocationLabel.font = .regular(size: 12)
        
        self.userLocationLabel.textColor = .mainDarkGrey
        
        self.editButton.isHidden = true
        
        self.showSwitch.isOn = false
        
        self.mapView.animate(toZoom: 15)
        
    }
    
    @IBAction func showSwitchValueChanged(_ sender: UISwitch) {
    
        self.editButton.isHidden = sender.isOn ? false : true
        
        self.delegate?.showSwitchValueChanged(isVisible: sender.isOn)
    
    }
    
    @IBAction func editButtonPressed(_ sender: UIButton) {
        
        self.delegate?.changeLocationButtonPressed()
        
    }
    
}
