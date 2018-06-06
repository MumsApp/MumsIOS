import UIKit

class SchoolsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureView()
        
        self.configureNavigationBar()
        
        self.registerCells()
        
    }

    private func configureView() {
        
        self.view.setBackground()
        
        self.tableView.backgroundColor = .clear
        
        self.tableView.delegate = self
        
        self.tableView.dataSource = self
        
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)
        
    }
    
    private func configureNavigationBar() {
        
        let titleLabel = self.navigationController?.configureNavigationBarWithTitle(title: "Schools")
        
        self.navigationItem.titleView = titleLabel
        
        self.navigationItem.hidesBackButton = true
        
    }
    
    private func registerCells() {
        
        self.tableView.registerNib(SchoolCell.self)
        
        self.tableView.registerNib(AddCell.self)
    
    }
    
}

extension SchoolsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            
            return 3
            
        } else {
            
            return 1
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            
            return 100
            
        } else {
            
            return 60
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(SchoolCell.self, indexPath: indexPath)
            
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(AddCell.self, indexPath: indexPath)
            
            cell.configureWith(buttonTitle: "Add school", delegate: self)
            
            return cell
            
        }
        
    }
    
}

extension SchoolsViewController: AddCellDelegate {
    
    func addButtonPressed() {
        
        self.showAddSchoolViewController()
        
    }
    
    private func showAddSchoolViewController() {

        let factory = SecondaryViewControllerFactory.viewControllerFactory()

        let controller = factory.addSchoolViewController()

        self.navigationController?.pushViewController(controller, animated: true)

    }
    
}
