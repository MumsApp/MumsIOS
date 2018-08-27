import UIKit

class MyProductsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var shopService: ShopService!
    
    fileprivate var products: Array<Product> = []
    
    func configureWith(shopService: ShopService) {
        
        self.shopService = shopService
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureView()
        
        self.configureNavigationBar()

        self.configureLayout()
        
        self.getUserShopProducts()
        
    }
    
    private func configureView() {
        
        self.view.setBackground()

        self.collectionView.backgroundColor = .clear

        self.collectionView.delegate = self

        self.collectionView.dataSource = self

        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom:
            0, right: 0)

        self.collectionView.register(MyProductCell.self, type: .cell)
          
    }
    
    private func configureLayout() {
        
        let screenWidth = UIScreen.main.bounds.width
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        layout.itemSize = CGSize(width: screenWidth/2 - 5, height: 276)
        
        layout.minimumInteritemSpacing = 0
        
        layout.minimumLineSpacing = 5
        
        self.collectionView.collectionViewLayout = layout
        
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
        
        self.popToViewController(ShopViewController.self)
        
    }
   
    @IBAction func addProductButtonPressed(_ sender: UIButton) {
    
        self.showAddProductViewController()

    }
    
    fileprivate func showAddProductViewController(productOptional: Product? = nil) {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.addProductViewController(productOptional: productOptional)
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    fileprivate func showProductDetailsViewController(product: Product) {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.productDetailsViewController(product: product)
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    private func getUserShopProducts() {
        
        guard let token = self.appContext.token() else { return }
        
        self.progressHUD.showLoading()
        
        self.shopService.getUserShopProducts(token: token) { dataOptional, errorOptional in
    
            self.progressHUD.dismiss()
            
            if let error = errorOptional {
                
                self.showOkAlertWith(title: "Error", message: error.localizedDescription)
                
            } else {
                
                if let dictionary = dataOptional as? Dictionary<String, Any> {
                    
                    if let data = dictionary[k_data] as? Array<Dictionary<String, Any>> {
                        
                        self.products = []
                        
                        for d in data {
                            
                            self.products.append(Product(dictionary: d))
                            
                        }
                        
                        self.collectionView.reloadData()
                        
                    }
                    
                }
                
            }
            
        }
        
    }

}

extension MyProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
         return self.products.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableClass(MyProductCell.self, forIndexPath: indexPath, type: .cell)
        
        let product = self.products[indexPath.row]
        
        cell.configureWith(product: product, delegate: self)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let product = self.products[indexPath.row]
        
        self.showProductDetailsViewController(product: product)

    }
    
}

extension MyProductsViewController: MyProductCellDelegate {
    
    func editButtonPressed(product: Product) {
        
        self.showAddProductViewController(productOptional: product)
        
    }
    
}
