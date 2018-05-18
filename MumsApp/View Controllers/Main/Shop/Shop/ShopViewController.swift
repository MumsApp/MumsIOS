import UIKit

enum ShopViewType {
    
    case shop
    case services
    
}

class ShopViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!

    private var type: ShopViewType = .shop

    var popupWindow: UIWindow?
    
    func configureWith(type: ShopViewType) {
        
        self.type = type
        
    }
    
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
        
        self.searchBar.delegate = self
        
    }
    
    private func configureNavigationBar() {
        
        let title = self.type == .shop ? "Shop" : "Where Can I Find"
        
        let titleLabel = self.navigationController?.configureNavigationBarWithTitle(title: title)
        
        self.navigationItem.titleView = titleLabel
        
        self.navigationItem.hidesBackButton = true
        
        let rightButton = UIBarButtonItem(image: #imageLiteral(resourceName: "smallMenuIcon"), style: .plain, target: self, action: #selector(self.menuButtonPressed(sender:)))
        
        self.navigationItem.rightBarButtonItem = rightButton
        
    }
    
    func menuButtonPressed(sender: UIBarButtonItem) {
     
        self.showShopMenuViewController()
        
    }
    
    private func registerCells() {
        
        self.tableView.registerNib(ShopCell.self)
    
        self.tableView.registerNib(ShopAdsCell.self)

        self.tableView.registerNib(ShopFilterCell.self)
        
    }
    
    private func showShopMenuViewController() {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.shopMenuViewController(delegate: self)
        
        controller.modalPresentationStyle = .overCurrentContext
        
        controller.modalTransitionStyle = .crossDissolve
        
        self.presentViewController(controller)
                
    }
    
    fileprivate func showProductDetailsViewController() {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.productDetailsViewController()
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
}

extension ShopViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {

            return 1
            
        } else {
            
            return 10

        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            
            return 140
            
        } else {
            
            return 170
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(ShopFilterCell.self, indexPath: indexPath)

            cell.configureWith(delegate: self)
            
            return cell
            
        } else {
           
            if indexPath.row == 2 {
                
                let cell = tableView.dequeueReusableCell(ShopAdsCell.self, indexPath: indexPath)
                
                cell.itemNameLabel.text = "Item one"
                
                cell.itemCategoryLabel.text = "Baby clothing"
                
                cell.itemPriceLabel.text = "$60"
                
                cell.itemDistanceLabel.text = "3 Miles"
                
                cell.userNameButton.setTitle("John S.", for: .normal)
                
                cell.configureWith(delegate: self)
                
                return cell
                
            } else {
             
                let cell = tableView.dequeueReusableCell(ShopCell.self, indexPath: indexPath)
                
                cell.itemNameLabel.text = "Item one"
                
                cell.itemCategoryLabel.text = "Baby clothing"
                
                cell.itemPriceLabel.text = "$60"
                
                cell.itemDistanceLabel.text = "3 Miles"
                
                cell.userNameButton.setTitle("John S.", for: .normal)
                
                cell.configureWith(delegate: self)
                
                return cell
                
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            
            return
            
        } else {
            
            self.showProductDetailsViewController()

        }
        
    }
    
}

extension ShopViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
    }
    
}

extension ShopViewController: ShopMenuDelegate {
    
    func showSearchViewController() {
        
        self.dismissViewController()
        
    }
    
    func showMyWishlistViewController() {

        self.showMyWishProductsViewController()

    }
    
    func showMyProductsViewController() {
        
        self.dismissViewController()
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.myProductViewController()
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }

    func showMyWishProductsViewController() {
        
        self.dismissViewController()
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.myWishlistViewController()
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
}

extension ShopViewController: ShopFilterCellDelegate {
    
    func filterButtonPressed() {
        
        self.showFilterViewController()
        
    }
    
    func showFilterViewController() {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.shopFilterViewController()
        
        self.navigationController?.pushViewController(controller, animated: true)

    }
    
}

extension ShopViewController: UserNameDelegate {
    
    func userNameButtonPressed() {
        
        self.showUserViewController()
        
    }
    
    func showUserViewController() {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.userViewController()
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
}
