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

        self.childrenLabel.text = children.formatter()
        
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
    
}
