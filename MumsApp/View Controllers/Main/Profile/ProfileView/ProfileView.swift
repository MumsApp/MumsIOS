import UIKit

class ProfileView: UIView {

    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var userImageView: UIImageView!
   
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userDescriptionLabel: UITextView!

    @IBOutlet weak var changeButton: UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
    
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.commonInit()
        
    }
 
    private func commonInit() {
        
        Bundle.main.loadNibNamed("ProfileView", owner: self, options: nil)
        
        self.addSubview(self.contentView)
        
        self.contentView.frame = self.bounds
        
        self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        self.configureView()
        
    }
    
    private func configureView() {
        
        self.backgroundColor = .clear
        
        self.userImageView.layer.cornerRadius = 35
        
        self.userNameLabel.font = .regular(size: 20)
        
        self.userNameLabel.textColor = .black

        self.userDescriptionLabel.font = .regular(size: 12)
        
        self.userDescriptionLabel.textColor = .mainDarkGrey
        
    }
    
    @IBAction func changeButtonPressed(_ sender: UIButton) {

        
    
    }

}
