import UIKit

class MyWishlistViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureView()
        
        self.configureNavigationBar()
        
        self.configureLayout()
        
    }
    
    private func configureView() {
        
        self.view.backgroundColor = .backgroundWhite
        
        self.collectionView.backgroundColor = .backgroundWhite
        
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
    
    fileprivate func showProductDetailsViewController() {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.productDetailsViewController()
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    fileprivate func showRemoveProductPopupViewController() {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.removeProductPopupViewController()
        
        controller.modalPresentationStyle = .overCurrentContext
        
        controller.modalTransitionStyle = .crossDissolve
        
        self.presentViewController(controller)
        
    }

}

extension MyWishlistViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.showProductDetailsViewController()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableClass(MyWishlistCell.self, forIndexPath: indexPath, type: .cell)
        
        cell.configureWith(delegate: self, delegateWishlist: self)
    
        return cell
        
    }
    
}

extension MyWishlistViewController: UserNameDelegate {
    
    func userNameButtonPressed() {
        
        self.showUserViewController()
        
    }
 
    func showUserViewController() {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.userViewController()
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
}

extension MyWishlistViewController: MyWishlistCellDelegate {
    
    func wishlistButtonPressed(tag: Int) {
        
        if tag == 0 {
            
            self.showRemoveProductPopupViewController()
            
        } else {
            
            self.showRemoveProductPopupViewController()

        }
        
    }
    
}
