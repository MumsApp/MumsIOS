import UIKit

class MyProductsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var uploadNewProductButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureView()
        
        self.configureNavigationBar()

    }
    
    private func configureView() {
        
        self.view.backgroundColor = .backgroundWhite
        
        self.tableView.backgroundColor = .backgroundWhite
        
        self.tableView.delegate = self
        
        self.tableView.dataSource = self

        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom:
            80, right: 0)
        self.tableView.registerNib(MyProductCell.self)
        
        self.tableView.registerNib(AddCell.self)

    }

    private func configureNavigationBar() {
        
        let titleLabel = self.navigationController?.configureNavigationBarWithTitle(title: "My Products")
        
        self.navigationItem.titleView = titleLabel
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        self.navigationItem.hidesBackButton = true
        
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backButtonIcon"), style: .plain, target: self, action: #selector(self.backButtonPressed(sender:)))
        
        self.navigationItem.leftBarButtonItem = backButton
        
    }
    
    func backButtonPressed(sender: UIBarButtonItem) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
   
}

extension MyProductsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            
            return 10
            
        } else {
            
            return 1
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            
            return 170
            
        } else {
            
            return 60
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(MyProductCell.self, indexPath: indexPath)
            
            return cell
        
        } else {
            
            let cell = tableView.dequeueReusableCell(AddCell.self, indexPath: indexPath)
            
            cell.configureWith(buttonTitle: "Upload new product", delegate: self)

            return cell
            
        }
    
    }
    
}

extension MyProductsViewController: AddCellDelegate {
    
    func addButtonPressed() {
        
        self.showAddProductViewController()
        
    }
    
    private func showAddProductViewController() {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.addProductViewController()
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
}
