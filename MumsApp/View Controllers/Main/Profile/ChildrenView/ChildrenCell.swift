import UIKit
import SwipeCellKit

protocol ChildrenCellDelgate: class {
    
    func editButtonPressed(children: Children)
    
}

class ChildrenCell: SwipeTableViewCell, Reusable {

    @IBOutlet weak var childrenLabel: UILabel!
    
    @IBOutlet weak var editButton: UIButton!
    
    private weak var delegateChildren: ChildrenCellDelgate?
    
    private var children: Children?
    
    func configureWith(children: Children, delegate: ChildrenCellDelgate) {
        
        self.children = children

//        let title = String(children.age!) + String(children.ageUnit!) + String(children.sex!)

        self.childrenLabel.text = self.formatter(child: children)
        
        self.delegateChildren = delegate
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.configureView()
        
    }
    
    private func configureView() {
        
        self.selectionStyle = .none
        
        self.childrenLabel.font = .regular(size: 12)
        
        self.childrenLabel.textColor = .black
        
        self.editButton.titleLabel?.font = .regular(size: 12)
        
        self.editButton.setTitleColor(.mainGreen, for: .normal)
        
    }

    @IBAction func editButtonPressed(_ sender: UIButton) {
        
        self.delegateChildren?.editButtonPressed(children: self.children!)
        
    }
    
    
    func formatter(child: Children) -> String {
        
        var title = ""

        guard let sex = child.sex, let ageUnit = child.ageUnit, let age = child.age else { return title }
        
        
//        Child sex
//        1 - male
//        2 - female
//        3 - to come
        
//        Child age unit
//        1 - weeks
//        2 - months
//        3 - years
        
        switch sex {
            
        case 1:
            
            title += "Girl " + String(age)
            
        case 2:
            
            title += "Boy " + String(age)
            
        case 3:
            
            title += "To come " + String(age)
         
        default:
            
            break
            
        }
        
        switch ageUnit {
            
        case 1:
        
            title += age == 1 ? " week old" : " weeks old"
        
        case 2:
        
            title += age == 1 ? " month old" : " months old"
        
        case 3:
        
            title += age == 1 ? " year old" : " years old"

        default:
        
            break
            
        }
        
        return title
      
    }
    
}
