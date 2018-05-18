import UIKit

enum ChildrenType {
    
    case female
    case male
    case tocome
    
}

protocol AddChildrenPopupViewControllerDelegate: class {
    
    func saveChildrenButtonPressed()
    
}

class AddChildrenPopupViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var smallContainerView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var closeButton: UIButton!

    @IBOutlet weak var typeImageView: UIImageView!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var ageLabel: UILabel!
    
    @IBOutlet weak var ageCountLabel: UILabel!
    
    @IBOutlet weak var minusButton: UIButton!
    
    @IBOutlet weak var plusButton: UIButton!
    
    @IBOutlet weak var weeksButton: UIButton!
    
    @IBOutlet weak var monthsButton: UIButton!
    
    @IBOutlet weak var yearsButton: UIButton!
    
    @IBOutlet weak var saveButton: UIButton!
    
    private var type: ChildrenType = .female

    private var count = 0
    
    private weak var delegate: AddChildrenPopupViewControllerDelegate?
    
    func configureWith(type: ChildrenType, delegate: AddChildrenPopupViewControllerDelegate?) {
        
        self.type = type
        
        self.delegate = delegate
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureView()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.containerView.layer.cornerRadius = 4
        
        self.containerView.backgroundColor = .white
        
    }
    
    private func configureView() {
        
        self.titleLabel.font = .regular(size: 33)

        self.ageLabel.font = .regular(size: 13)
        
        self.ageLabel.textColor = .mainDarkGrey
        
        self.minusButton.setTitleColor(.mainGreen, for: .normal)
        
        self.minusButton.titleLabel?.font = .regular(size: 12)
        
        self.plusButton.setTitleColor(.mainGreen, for: .normal)

        self.plusButton.titleLabel?.font = .regular(size: 12)

        self.ageCountLabel.font = .regular(size: 14)
        
        self.weeksButton.titleLabel?.font = .regular(size: 12)

        self.monthsButton.titleLabel?.font = .regular(size: 12)

        self.yearsButton.titleLabel?.font = .regular(size: 12)
        
        self.smallContainerView.layer.cornerRadius = 4
        
        self.smallContainerView.layer.borderColor = UIColor.containerLightGreyColor.cgColor
        
        self.smallContainerView.layer.borderWidth = 1
        
        switch self.type {
            
        case .female:
            
            self.typeImageView.image = #imageLiteral(resourceName: "femaleIcon")
            
            self.typeLabel.text = "Female"
            
        case .male:
            
            self.typeImageView.image = #imageLiteral(resourceName: "maleIcon")
            
            self.typeLabel.text = "Male"

        case .tocome:
            
            self.typeImageView.image = #imageLiteral(resourceName: "comeIcon")
            
            self.typeLabel.text = "To come"

        }
        
    }
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        
        self.dismissViewController()
        
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
    
        self.delegate?.saveChildrenButtonPressed()
        
        self.dismissViewController()
    
    }
    
    @IBAction func minusButtonPressed(_ sender: UIButton) {
        
        if self.count > 0 {
            
            self.count -= 1
            
        }
        
        self.ageCountLabel.text = String(count)
        
    }
    
    @IBAction func plusButtonPressed(_ sender: UIButton) {
        
        guard self.count < 99 else { return }
        
        self.count += 1
        
        self.ageCountLabel.text = String(count)
        
    }
    
    @IBAction func weeksButtonPressed(_ sender: UIButton) {
        
        self.weeksButton.setImage(#imageLiteral(resourceName: "onIcon"), for: .normal)
        self.monthsButton.setImage(#imageLiteral(resourceName: "offIcon"), for: .normal)
        self.yearsButton.setImage(#imageLiteral(resourceName: "offIcon"), for: .normal)

    }
    
    @IBAction func monthsButtonPressed(_ sender: UIButton) {
        
        self.weeksButton.setImage(#imageLiteral(resourceName: "offIcon"), for: .normal)
        self.monthsButton.setImage(#imageLiteral(resourceName: "onIcon"), for: .normal)
        self.yearsButton.setImage(#imageLiteral(resourceName: "offIcon"), for: .normal)
        
    }
    
    @IBAction func yearsButtonPressed(_ sender: UIButton) {
        
        self.weeksButton.setImage(#imageLiteral(resourceName: "offIcon"), for: .normal)
        self.monthsButton.setImage(#imageLiteral(resourceName: "offIcon"), for: .normal)
        self.yearsButton.setImage(#imageLiteral(resourceName: "onIcon"), for: .normal)
        
    }
    
}
