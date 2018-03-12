import UIKit

class OrganisationProfileView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var organisationImageView: UIImageView!
    
    @IBOutlet weak var organisationNameLabel: UILabel!
    
    @IBOutlet weak var organisationDescriptionTextView: UITextView!
    
    @IBOutlet weak var followButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.commonInit()
        
    }
    
    private func commonInit() {
        
        Bundle.main.loadNibNamed("OrganisationProfileView", owner: self, options: nil)
        
        self.addSubview(self.contentView)
        
        self.contentView.frame = self.bounds
        
        self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        self.configureView()
        
    }
    
    private func configureView() {
        
        self.backgroundColor = .clear
        
        self.contentView.backgroundColor = .clear
        
        self.organisationImageView.layer.cornerRadius = 35

        self.organisationNameLabel.font = .regular(size: 20)

        self.organisationNameLabel.textColor = .black

        self.organisationDescriptionTextView.font = .regular(size: 12)

        self.organisationDescriptionTextView.textColor = .mainDarkGrey
        
    }

}

