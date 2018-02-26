import UIKit

class ShopViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var popupWindow: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureView()
        
        self.configureNavigationBar()
        
        self.registerCells()
        
    }
    
    private func configureView() {
        
        self.view.backgroundColor = .backgroundWhite
        
        self.tableView.backgroundColor = .backgroundWhite
        
        self.tableView.delegate = self
        
        self.tableView.dataSource = self
        
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)
        
        self.searchBar.delegate = self
        
    }
    
    private func configureNavigationBar() {
        
        let titleLabel = self.navigationController?.configureNavigationBarWithTitle(title: "Shop")
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(ShopCell.self, indexPath: indexPath)
        
        cell.itemNameLabel.text = "Item one"
        
        cell.itemCategoryLabel.text = "Baby clothing"
        
        cell.itemPriceLabel.text = "$60"
        
        cell.itemDistanceLabel.text = "3 Miles"
        
        cell.userNameLabel.text = "John S."
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.showProductDetailsViewController()
        
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
