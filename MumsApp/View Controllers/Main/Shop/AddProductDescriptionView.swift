import UIKit

protocol AddProductDescriptionViewDelegate: class {
    
    func showCategoryButtonPressed()
    
}

class AddProductDescriptionView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var itemTitleTextField: UITextField!
    
    @IBOutlet weak var selectCategoryButton: UIButton!
    
    @IBOutlet weak var askForCategoryButton: UIButton!
    
    @IBOutlet weak var itemPriceTextField: UITextField!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    private var delegate: AddProductDescriptionViewDelegate?
    
    func configureWith(delegate: AddProductDescriptionViewDelegate?) {
        
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
        
        Bundle.main.loadNibNamed("AddProductDescriptionView", owner: self, options: nil)
        
        self.addSubview(self.contentView)
        
        self.contentView.frame = self.bounds
        
        self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        self.configureView()
        
    }
    
    func configureView() {
        
        self.contentView.addShadow()
        
        self.backgroundColor = .clear
     
        self.itemTitleTextField.font = .regular(size: 17)
        
        self.selectCategoryButton.titleLabel?.font = .regular(size: 17)
        
        self.itemPriceTextField.font = .regular(size: 17)
        
        self.descriptionTextView.font = .regular(size: 12)
        
        self.descriptionTextView.textColor = .mainDarkGrey
        
        self.askForCategoryButton.titleLabel?.font = .regular(size: 10)
    
        self.askForCategoryButton.tintColor = .mainGreen

        self.descriptionTextView.layer.cornerRadius = 4
        
        self.descriptionTextView.layer.borderColor = UIColor.lineGreyColor.cgColor
        
        self.descriptionTextView.layer.borderWidth = 1
     
        self.itemTitleTextField.delegate = self
        
        self.itemPriceTextField.delegate = self
        
        self.descriptionTextView.delegate = self
        
    }
    
    @IBAction func selectCategoryButtonPressed(_ sender: UIButton) {
        
        self.delegate?.showCategoryButtonPressed()
    
    }
    
    @IBAction func askForCategoryButtonPressed(_ sender: UIButton) {
    
        if let url = URL(string: "mailto:\(SUPPORT_EMAIL)") {
            
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
           
        }

    }
    
}

extension AddProductDescriptionView: UITextFieldDelegate, UITextViewDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
     
        return true
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.text == "Add description" {
            
            textView.text = ""

        }
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    
        if(text == "\n") {
        
            textView.resignFirstResponder()
        
            return false
        
        }
    
        return true
    
    }

}

