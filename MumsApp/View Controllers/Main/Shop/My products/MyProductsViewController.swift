import UIKit

class MyProductsViewController: UIViewController {
    
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
        
        self.navigationController?.popViewController(animated: true)
        
    }
   
    @IBAction func addProductButtonPressed(_ sender: UIButton) {
    
        self.showAddProductViewController()

    }
    
    fileprivate func showAddProductViewController() {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.addProductViewController()
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }

}

extension MyProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
         return 10
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableClass(MyProductCell.self, forIndexPath: indexPath, type: .cell)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.showAddProductViewController()
        
    }
    
}
