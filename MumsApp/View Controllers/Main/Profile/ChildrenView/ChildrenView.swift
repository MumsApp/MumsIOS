import Foundation
import UIKit
import SwipeCellKit

protocol ChildrenViewDelegate: class {
    
    func addChildrenButtonPressed(type: ChildrenType)
    func editChildrenButtonPressed(children: Children)
    func deleteChildrenButtonPressed(children: Children)

}

class ChildrenView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var childrenLabel: UILabel!
    
    @IBOutlet weak var femaleButton: UIButton!
    
    @IBOutlet weak var maleButton: UIButton!
    
    @IBOutlet weak var toComeButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var separatorView: UIView!
    
    fileprivate weak var delegate: ChildrenViewDelegate?
    
    var childrenList: Array<Children> = []
    
    func configureWith(delegate: ChildrenViewDelegate) {
        
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
        
        Bundle.main.loadNibNamed("ChildrenView", owner: self, options: nil)
        
        self.addSubview(self.contentView)
        
        self.contentView.frame = self.bounds
        
        self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        self.configureView()
        
        self.tableView.registerNib(ChildrenCell.self)

    }
    
    private func configureView() {
        
        self.contentView.addShadow()
        
        self.backgroundColor = .clear
        
        self.childrenLabel.font = .semiBold(size: 15)
        
        self.childrenLabel.textColor = .black
        
        self.femaleButton.titleLabel?.font = .regular(size: 12)
        
        self.femaleButton.setTitleColor(.mainDarkGrey, for: .normal)
        
        self.maleButton.titleLabel?.font = .regular(size: 12)

        self.maleButton.setTitleColor(.mainDarkGrey, for: .normal)

        self.toComeButton.titleLabel?.font = .regular(size: 12)

        self.toComeButton.setTitleColor(.mainDarkGrey, for: .normal)

        self.tableView.delegate = self
        
        self.tableView.dataSource = self
        
        self.separatorView.isHidden = true
        
    }
    
    @IBAction func addFemaleButtonPressed(_ sender: UIButton) {
        
        self.delegate?.addChildrenButtonPressed(type: .female)
        
    }
    
    @IBAction func addMaleButtonPressed(_ sender: UIButton) {
    
        self.delegate?.addChildrenButtonPressed(type: .male)

    }
    
    @IBAction func addToComeButtonPressed(_ sender: UIButton) {

        self.delegate?.addChildrenButtonPressed(type: .tocome)

    }
    
}

extension ChildrenView: UITableViewDelegate, UITableViewDataSource, SwipeTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.childrenList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(ChildrenCell.self)
        
        let children = self.childrenList[indexPath.row]
                
        cell.configureWith(children: children, delegate: self)
        
        cell.delegate = self
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: nil) { action, indexPath in
            
            let children = self.childrenList[indexPath.row]

            self.delegate?.deleteChildrenButtonPressed(children: children)
            
        }
        
        deleteAction.backgroundColor = .clear
        
        deleteAction.image = #imageLiteral(resourceName: "deleteIcon").resizeImage(CGSize(width: 30, height: 30))
        
        return [deleteAction]
        
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        
        var options = SwipeTableOptions()
        
        options.backgroundColor = .clear
        
        return options
        
    }
    
}

extension ChildrenView: ChildrenCellDelgate {
    
    func editButtonPressed(children: Children) {
    
        self.delegate?.editChildrenButtonPressed(children: children)
        
    }
    
}
