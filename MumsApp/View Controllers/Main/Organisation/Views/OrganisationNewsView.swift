import UIKit

class OrganisationNewsView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var news: Array<UIImage> = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.commonInit()
        
    }
    
    private func commonInit() {
        
        Bundle.main.loadNibNamed("OrganisationNewsView", owner: self, options: nil)
        
        self.addSubview(self.contentView)
        
        self.contentView.frame = self.bounds
        
        self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        self.configureView()
        
    }
    
    func configureView() {
        
        self.backgroundColor = .clear
        
        self.titleLabel.font = .semiBold(size: 17)
        
        self.tableView.registerNib(NewsCell.self)
        
        self.tableView.delegate = self
        
        self.tableView.dataSource = self
        
        self.tableView.rowHeight = 145
        
        self.tableView.estimatedRowHeight = UITableViewAutomaticDimension
    
    }
    
}

extension OrganisationNewsView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(NewsCell.self, indexPath: indexPath)
        
        return cell
        
    }
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
        
    }
    
}
