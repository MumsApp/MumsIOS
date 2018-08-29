import UIKit
import CoreLocation

enum ShopViewType {
    
    case shop
    case services
    
}

class ShopViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!

    private var shopService: ShopService!
    
    fileprivate var pages: Int = 1
    
    fileprivate var currentPage: Int = 1
    
    fileprivate var isLoadingList: Bool = false

    fileprivate var products: Array<Product> = []

    fileprivate var type: ShopViewType = .shop

    func configureWith(type: ShopViewType, shopService: ShopService) {
        
        self.type = type
        
        self.shopService = shopService
                
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureView()
        
        self.configureNavigationBar()
        
        self.registerCells()
        
        if self.type == .shop {
            
            self.getShopProducts(page: 1, loadMore: false)

        } else {
            
            // Services endpoints
            
        }
        
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
     
        let leftButton = UIBarButtonItem(image: #imageLiteral(resourceName: "addIcon"), style: .plain, target: self, action: #selector(self.addButtonPressed(sender:)))
        
        self.navigationItem.leftBarButtonItem = leftButton

    }
    
    func menuButtonPressed(sender: UIBarButtonItem) {
     
        self.showShopMenuViewController()
        
    }
    
    func addButtonPressed(sender: UIBarButtonItem) {
        
        self.addProductViewController()
        
    }
    
    private func registerCells() {
        
        self.tableView.registerNib(ShopCell.self)
    
        self.tableView.registerNib(ShopAdsCell.self)

        self.tableView.registerNib(ShopFilterCell.self)
        
    }
    
    private func showShopMenuViewController() {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.shopMenuViewController(delegate: self, type: self.type)
        
        controller.modalPresentationStyle = .overCurrentContext
        
        controller.modalTransitionStyle = .crossDissolve
        
        self.presentViewController(controller)
                
    }
    
    fileprivate func showProductDetailsViewController(product: Product) {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.productDetailsViewController(product: product)
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    private func addProductViewController() {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.addProductViewController(type: self.type)
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    fileprivate func getShopProducts(page: Int, loadMore: Bool) {
        
        guard let token = self.appContext.token() else { return }

        self.progressHUD.showLoading()
        
        self.shopService.getShopProducts(token: token, page: page) { dataOptional, errorOptional in
            
            self.progressHUD.dismiss()
            
            if let error = errorOptional {
                
                self.showOkAlertWith(title: "Error", message: error.localizedDescription)
                
            } else {
                
                self.parseShopResults(dataOptional: dataOptional, loadMore: loadMore)

            }
            
        }
        
    }
    
    private func parseShopResults(dataOptional: Any?, loadMore: Bool) {
        
        if let dictionary = dataOptional as? Dictionary<String, Any> {
            
            if let data = dictionary[k_data] as? Dictionary<String, Any> {
                
                if let pages = data[k_pages] as? Int {
                    
                    self.pages = pages
                    
                }
                
                if let productsArray = data[k_products] as? Array<Dictionary<String, Any>> {
                    
                    if !loadMore {
                        
                        self.products = []

                    }
                    
                    for product in productsArray {
                        
                        self.products.append(Product(dictionary: product))
                        
                    }
                    
                    print(productsArray.count)

                    self.isLoadingList = false

                    self.tableView.reloadData()
                    
                }
                
            }
            
        }
        
    }
    
    func addFavouriteProduct(id: String) {
        
        guard let token = self.appContext.token() else { return }

        self.shopService.addFavouriteProduct(id: id, token: token) { errorOptional in
            
            if let error = errorOptional {
                
                self.showOkAlertWith(title: "Error", message: error.localizedDescription)
                
            } else {
                
                return
                
            }
            
        }
        
    }
    
    func removeFavouriteProduct(id: String) {
        
        guard let token = self.appContext.token() else { return }
        
        self.shopService.removeFavouriteProduct(id: id, token: token) { errorOptional in
            
            if let error = errorOptional {
                
                self.showOkAlertWith(title: "Error", message: error.localizedDescription)
                
            } else {
                
                return
                
            }
            
        }
        
    }
    
    func searchShopProducts(searchTerm: String, page: Int) {
        
        guard let token = self.appContext.token() else { return }

        self.shopService.searchShopProducts(searchTerm: searchTerm, page: page, token: token) { dataOptional, errorOptional in
            
            if let error = errorOptional {
                
                self.showOkAlertWith(title: "Error", message: error.localizedDescription)
                
            } else {
                
                self.parseShopResults(dataOptional: dataOptional, loadMore: false)
                
            }
            
        }
        
    }
    
    func searchShopProductsWithFilters(page: Int, parameters: Dictionary<String, Any>) {
        
        guard let token = self.appContext.token() else { return }

        self.shopService.searchShopProducts(page: page, bodyParameters: parameters, token: token) { dataOptional, errorOptional in
            
            if let error = errorOptional {
                
                self.showOkAlertWith(title: "Error", message: error.localizedDescription)
                
            } else {
                
                self.parseShopResults(dataOptional: dataOptional, loadMore: false)
                
            }
            
        }
        
    }
    
    fileprivate func showFilterViewController() {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.shopFilterViewController(delegate: self, type: self.type)
        
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
            
            return self.products.count

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
           
            let cell = tableView.dequeueReusableCell(ShopCell.self, indexPath: indexPath)
            
            let product = self.products[indexPath.row]
            
            if let userLocation = self.appContext.userLocation() {
                
                cell.itemDistanceLabel.text = distanceFrom(userLocation: userLocation, productLat: product.lat!, productLon: product.lon!)

            } else {
                
                cell.itemDistanceLabel.text = ""
                
            }
            
            cell.configureWith(delegate: self, product: product, cellDelegate: self)
            
            return cell
            
//            if indexPath.row == 2 {
//
//                let cell = tableView.dequeueReusableCell(ShopAdsCell.self, indexPath: indexPath)
//
//                cell.itemNameLabel.text = "Item one"
//
//                cell.itemCategoryLabel.text = "Baby clothing"
//
//                cell.itemPriceLabel.text = "$60"
//
//                cell.itemDistanceLabel.text = "3 Miles"
//
//                cell.userNameButton.setTitle("John S.", for: .normal)
//
//                cell.configureWith(delegate: self)
//
//                return cell
//
//            } else {
//
//
//            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            
            return
            
        } else {
            
            let product = self.products[indexPath.row]
            
            self.showProductDetailsViewController(product: product)

        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height) && !self.isLoadingList){
        
            if self.currentPage >= self.pages {
                
                return
                
            }
            
            self.currentPage += 1
            
            self.isLoadingList = true
            
            self.getShopProducts(page: self.currentPage, loadMore: true)
    
        }
    
    }

}

extension ShopViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText != "" {
            
            self.searchShopProducts(searchTerm: searchText, page: 1)
            
        }
        
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
        
        let controller = factory.myProductViewController(type: self.type)
        
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
    
}

extension ShopViewController: UserNameDelegate {
    
    func userNameButtonPressed(userId: String) {
        
        self.showUserViewController(userId: userId)
        
    }
    
    func showUserViewController(userId: String) {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.userViewController(userId: userId)
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
}

extension ShopViewController: ShopCellDelegate {
    
    func watchButtonPressed(tag: Int, id: String) {
        
        if tag == 0 {
            
            self.addFavouriteProduct(id: id)
            
        } else {
            
            self.removeFavouriteProduct(id: id)
            
        }
        
    }
    
}

extension ShopViewController: ShopFilterViewControllerDelegate {
    
    func searchWithFilters(parameters: Dictionary<String, Any>) {
        
        self.searchShopProductsWithFilters(page: 1, parameters: parameters)
        
    }
    
}
