import UIKit

enum ChildrenType: Int {
    
    case female = 1, male, tocome
    
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
    
    private weak var delegate: AddChildrenPopupViewControllerDelegate?

    private var childService: ChildService!
    
    private var type: ChildrenType = .female

    private var count = 0
    
    private var ageUnit: Int?
    
    private var children: Children?
    
    func configureWith(type: ChildrenType, delegate: AddChildrenPopupViewControllerDelegate?, childService: ChildService, children: Children?) {
        
        self.type = type
        
        self.delegate = delegate
        
        self.childService = childService
        
        self.children = children
             
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
        
        self.configureChildren()
        
    }
    
    private func configureChildren() {
        
        guard let children = self.children else { return }
        
        self.ageCountLabel.text = String(children.age!)
        
        self.count = children.age!
        
        switch children.ageUnit! {
            
        case 1:
            
            self.weeksButtonPressed(self.weeksButton)
            
        case 2:
            
            self.monthsButtonPressed(self.monthsButton)

        case 3:

            self.yearsButtonPressed(self.yearsButton)
            
        default: return
            
        }
        
    }
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        
        self.dismissViewController()
        
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
    
        self.prepareToSaveChild()
    
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

        self.ageUnit = 1

    }
    
    @IBAction func monthsButtonPressed(_ sender: UIButton) {
        
        self.weeksButton.setImage(#imageLiteral(resourceName: "offIcon"), for: .normal)
        self.monthsButton.setImage(#imageLiteral(resourceName: "onIcon"), for: .normal)
        self.yearsButton.setImage(#imageLiteral(resourceName: "offIcon"), for: .normal)
        
        self.ageUnit = 2

    }
    
    @IBAction func yearsButtonPressed(_ sender: UIButton) {
        
        self.weeksButton.setImage(#imageLiteral(resourceName: "offIcon"), for: .normal)
        self.monthsButton.setImage(#imageLiteral(resourceName: "offIcon"), for: .normal)
        self.yearsButton.setImage(#imageLiteral(resourceName: "onIcon"), for: .normal)
        
        self.ageUnit = 3
        
    }
    
    private func prepareToSaveChild() {
        
        guard let id = self.appContext.userId(), let token = self.appContext.token() else { return }
        
        guard let age = Int(self.ageCountLabel.text!) else { return }
        
        guard let ageUnit = self.ageUnit else {
            
            self.showOkAlertWith(title: "Info", message: "Please choose the type of age.")
            
            return
            
        }
        
        var sex = 1
        
        switch self.type {
            
        case .female:
            
            sex = 1
            
        case .male:
            
            sex = 2
            
        case .tocome:
            
            sex = 3
            
        }
        
        if self.children == nil {
            
            self.addChild(id: id, token: token, age: age, ageUnit: ageUnit, sex: sex)
            
        } else {
            
            guard let children_id = self.children?.id else { return }
            
            self.updateChild(id: id, child_id: children_id, token: token, age: age, ageUnit: ageUnit, sex: sex)
            
        }
        
    }
    
    private func addChild(id: String, token: String, age: Int, ageUnit: Int, sex: Int) {
        
        self.childService.addChildDetails(id: id, token: token, age: age, ageUnit: ageUnit, sex: sex) { errorOptional in
            
            if let error = errorOptional {
                
                self.showOkAlertWith(title: "Error", message: error.localizedDescription)
                
            } else {
                
                self.delegate?.saveChildrenButtonPressed()
                
                self.dismissViewController()
                
            }
            
        }
        
    }
    
    func updateChild(id: String, child_id: Int, token: String, age: Int, ageUnit: Int, sex: Int) {
        
        self.childService.updateChildDetails(id: id, child_id: child_id, token: token, age: age, ageUnit: ageUnit, sex: sex) { errorOptional in
            
            if let error = errorOptional {
                
                self.showOkAlertWith(title: "Error", message: error.localizedDescription)
                
            } else {
                
                self.delegate?.saveChildrenButtonPressed()
                
                self.dismissViewController()
                
            }
            
        }
        
    }
    
}
