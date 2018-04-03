//import Foundation
//import UIKit
//
//protocol SchoolViewDelegate: class {
//    
//    func addSchoolButtonPressed()
//    func deleteSchoolButtonPressed()
//    
//}
//
//class SchoolView: UIView {
//    
//    @IBOutlet weak var contentView: UIView!
//    
//    @IBOutlet weak var tableView: UITableView!
//    
//    @IBOutlet weak var schoolsLabel: UILabel!
//    
//    @IBOutlet weak var addSchoolButton: UIButton!
//    
//    @IBOutlet weak var separatorLine: UIView!
//    
//    fileprivate weak var delegate: SchoolViewDelegate?
//    
//    var list: Array<String> = []
//    
//    func configureWith(delegate: SchoolViewDelegate) {
//        
//        self.delegate = delegate
//        
//    }
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        self.commonInit()
//        
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        
//        self.commonInit()
//        
//    }
//    
//    private func commonInit() {
//        
//        Bundle.main.loadNibNamed("SchoolView", owner: self, options: nil)
//        
//        self.addSubview(self.contentView)
//        
//        self.contentView.frame = self.bounds
//        
//        self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
//        
//        self.configureView()
//        
//        self.tableView.registerNib(SchoolCell.self)
//        
//    }
//    
//    private func configureView() {
//        
//        self.contentView.addShadow()
//        
//        self.backgroundColor = .clear
//        
//        self.tableView.delegate = self
//        
//        self.tableView.dataSource = self
//        
//        self.schoolsLabel.font = .semiBold(size: 15)
//        
//        self.schoolsLabel.textColor = .black
//
//        self.addSchoolButton.titleLabel?.font = .regular(size: 14)
//        
//        self.addSchoolButton.tintColor = .mainGreen
//
//        self.separatorLine.isHidden = true
//        
//    }
//   
//    @IBAction func addSchoolButtonPressed(_ sender: UIButton) {
//        
//        self.delegate?.addSchoolButtonPressed()
//        
//    }
//    
//}
//
//extension SchoolView: UITableViewDelegate, UITableViewDataSource {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//        self.configureSeparatorLine()
//
//        return self.list.count
//        
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let cell = tableView.dequeueReusableCell(SchoolCell.self, indexPath: indexPath)
//        
//        cell.configureWith(delegate: self)
//        
//        return cell
//        
//    }
//    
//    private func configureSeparatorLine() {
//        
//        if self.list.count == 0 {
//           
//            self.separatorLine.isHidden = true
//            
//        } else {
//            
//            self.separatorLine.isHidden = false
//            
//        }
//        
//    }
//    
//}
//
//extension SchoolView: SchoolCellDelegate {
//    
//    func delete() {
//        
//        self.delegate?.deleteSchoolButtonPressed()
//        
//    }
//    
//}

