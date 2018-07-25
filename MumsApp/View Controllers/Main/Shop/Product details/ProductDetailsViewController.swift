import UIKit

class ProductDetailsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
   
    @IBOutlet weak var itemDescriptionView: ItemDescriptionView!
    
    @IBOutlet weak var itemLocationView: ItemLocationView!
    
    fileprivate var product: Product!
    
    fileprivate var imageLoader: ImageCacheLoader!
    
    func configureWith(product: Product, imageLoader: ImageCacheLoader) {
        
        self.product = product
        
        self.imageLoader = imageLoader
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureView()
        
        self.configureNavigationBar()
     
        self.configureData()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        self.itemDescriptionView.itemDescriptionTextView.setContentOffset(.zero, animated: false)

    }

    private func configureView() {
        
        self.view.setBackground()

        self.collectionView.backgroundColor = .clear
        
        self.collectionView.register(PictureCell.self, type: .cell)
        
        self.collectionView.delegate = self
        
        self.collectionView.dataSource = self
     
        self.pageControl.numberOfPages = self.product.photos!.count
    
        self.itemDescriptionView.configureWith(delegate: self)
    
    }
    
    private func configureData() {
        
        self.itemDescriptionView.itemTitleLabel.text = product.name
        
        self.itemDescriptionView.itemCategoryLabel.text = product.categoryName
        
        self.itemDescriptionView.itemPriceLabel.text = "£" + product.price!
        
        self.itemDescriptionView.itemDistanceLabel.text = product.lat
        
        self.itemDescriptionView.itemDescriptionTextView.text = product.description
        
        self.itemDescriptionView.userNameButton.setTitle(product.creatorName, for: .normal)
        
        self.itemLocationView.editButton.isHidden = true
        
        if let lat = product.lat, let lon = product.lon {
         
            self.itemLocationView.configureLocationViewWith(lat: Double(lat)!, lon: Double(lon)!)

            self.itemLocationView.userLocationLabel.text = "TO DO"

        }
        
        if let src = self.product.creatorPhoto {
            
            self.imageLoader.obtainImageWithPath(imagePath: BASE_PUBLIC_IMAGE_URL + src) { image in
                
               self.itemDescriptionView.userImageView.image = image
                
            }
            
        }
        
    }
    
    private func configureNavigationBar() {
        
        let titleLabel = self.navigationController?.configureNavigationBarWithTitle(title: "Product")
        
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

extension ProductDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.product.photos!.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableClass(PictureCell.self, forIndexPath: indexPath, type: .cell)
        
        if let src = self.product.photos?.first?.src {
            
            self.imageLoader.obtainImageWithPath(imagePath: BASE_PUBLIC_IMAGE_URL + src) { image in
                
                if let _ = collectionView.cellForItem(at: indexPath) {
                    
                    cell.imageView.image = image
                    
                }
                
            }
            
        }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    
        self.pageControl.currentPage = indexPath.row
    
    }

}

extension ProductDetailsViewController: UserNameDelegate {
    
    func userNameButtonPressed(userId: String) {
        
        self.showUserViewController(userId: userId)
        
    }
    
    func showUserViewController(userId: String) {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.userViewController(userId: userId)
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
}
