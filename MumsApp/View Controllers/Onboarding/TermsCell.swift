import UIKit

class TermsCell: UITableViewCell, Reusable {
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var answerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        
        self.questionLabel.textColor = .black
        
        self.answerLabel.textColor = .black
        
        self.questionLabel.font = .semiBold(size: 15)
        
        self.answerLabel.font = .regular(size: 15)
        
    }
    
    func configureWith(result: Terms) {
        
        self.questionLabel.text = result.question
        
        self.answerLabel.text = result.answer
        
    }
    
}
