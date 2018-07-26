import UIKit

class MyWishlistViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var shopService: ShopService!
    
    fileprivate var products: Array<Product> = []
    
    fileprivate var imageLoader: ImageCacheLoader!

    func configureWith(shopService: ShopService, imageLoader: ImageCacheLoader) {
        
        self.shopService = shopService
        
        self.imageLoader = imageLoader
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureView()
        
        self.configureNavigationBar()
        
        self.configureLayout()
        
        self.getUserFavouriteShopProducts()

    }
    
    private func configureView() {
        
        self.view.setBackground()

        self.collectionView.backgroundColor = .clear
        
        self.collectionView.delegate = self
        
        self.collectionView.dataSource = self
                
        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom:
            80, right: 0)
        
        self.collectionView.register(MyWishlistCell.self, type: .cell)
        
    }
    
    private func configureLayout() {
        
        let screenWidth = UIScreen.main.bounds.width
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        layout.itemSize = CGSize(width: screenWidth/2 - 5, height: 316)
        
        layout.minimumInteritemSpacing = 0
        
        layout.minimumLineSpacing = 5
        
        self.collectionView.collectionViewLayout = layout
        
    }
    
    private func configureNavigationBar() {
        
        let titleLabel = self.navigationController?.configureNavigationBarWithTitle(title: "My Wishlist")
        
        self.navigationItem.titleView = titleLabel
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        self.navigationItem.hidesBackButton = true
        
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backButtonIcon"), style: .plain, target: self, action: #selector(self.backButtonPressed(sender:)))
        
        self.navigationItem.leftBarButtonItem = backButton
        
    }
    
    func backButtonPressed(sender: UIBarButtonItem) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    fileprivate func showProductDetailsViewController(product: Product) {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.productDetailsViewController(product: product)
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    fileprivate func showRemoveProductPopupViewController(product: Product, productImage: UIImage) {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.removeProductPopupViewController(product: product, productImage: productImage, delegate: self)
        
        controller.modalPresentationStyle = .overCurrentContext
        
        controller.modalTransitionStyle = .crossDissolve
        
        self.presentViewController(controller)
        
    }

    fileprivate func getUserFavouriteShopProducts() {
        
        guard let token = self.appContext.token() else { return }
        
        self.shopService.getUserFavouriteShopProducts(token: token) { dataOptional, errorOptional in
            
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

extension MyWishlistViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.products.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let product = self.products[indexPath.row]
        
        self.showProductDetailsViewController(product: product)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableClass(MyWishlistCell.self, forIndexPath: indexPath, type: .cell)
        
        let product = self.products[indexPath.row]

        cell.configureWith(delegate: self, delegateWishlist: self, product: product)
    
        if let src = product.creatorPhoto {
            
            self.imageLoader.obtainImageWithPath(imagePath: BASE_PUBLIC_IMAGE_URL + src) { (image) in
                
                cell.userImageView.image = image
                
            }
            
        }
        
        if let src = product.photos?.first?.src {
            
            self.imageLoader.obtainImageWithPath(imagePath: BASE_PUBLIC_IMAGE_URL + src) { (image) in

                cell.itemImageView.image = image

            }
            
        }
        
        return cell
        
    }
    
}

extension MyWishlistViewController: UserNameDelegate {
    
    func userNameButtonPressed(userId: String) {
        
        self.showUserViewController(userId: userId)
        
    }
 
    func showUserViewController(userId: String) {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.userViewController(userId: userId)
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
}

extension MyWishlistViewController: MyWishlistCellDelegate {
    
    func wishlistButtonPressed(product: Product, productImage: UIImage) {
        
        self.showRemoveProductPopupViewController(product: product, productImage: productImage)

    }
    
}

extension MyWishlistViewController: RemoveProductPopupViewControllerDelegate {
    
    func productRemoved() {
        
        self.getUserFavouriteShopProducts()
        
    }
    
}
