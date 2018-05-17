import Foundation
import UIKit

protocol ChildrenViewDelegate: class {
    
    func childrenAdded()
    
}

class ChildrenView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var childrenLabel: UILabel!
    
    @IBOutlet weak var femaleButton: UIButton!
    
    @IBOutlet weak var maleButton: UIButton!
    
    @IBOutlet weak var toComeButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var separatorView: UIView!
    
    private var delegate: ChildrenViewDelegate?
    
    func configureWith(delegate: ChildrenViewDelegate) {
        
        self.delegate = delegate
        
    }
    
    var list: Array<String> = []
    
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
        
    }
    
    @IBAction func addFemaleButtonPressed(_ sender: UIButton) {
        
        self.list.append("Boy (2 yrs)")
        
        self.tableView.reloadData()
        
        self.delegate?.childrenAdded()
        
    }
    
    @IBAction func addMaleButtonPressed(_ sender: UIButton) {
    
        self.delegate?.childrenAdded()

    }
    
    @IBAction func addToComeButtonPressed(_ sender: UIButton) {

        self.delegate?.childrenAdded()

    }
    
}

extension ChildrenView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.list.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(ChildrenCell.self)
        
        let thisItem = self.list[indexPath.row]
        
        cell.configureWith(type: thisItem, delegate: self)
        
        return cell
        
    }
    
}

extension ChildrenView: ChildrenCellDelgate {
    
    func editButtonPressed() {
    
        // Show edit popup
        
    }
    
}
