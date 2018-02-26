import UIKit

class MyProductsViewController: UIViewController {

//    @IBOutlet weak var tableView: UITableView!
    
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

        self.collectionView.register(MyProductCell.self, type: .cell)
        
//        self.collectionView.registerNib(MyProductCell.self)

//        self.collectionView.registerNib(AddCell.self)

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
   
}


extension MyProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 2
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            
            return 10
            
        } else {
            
            return 1
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableClass(MyProductCell.self, forIndexPath: indexPath, type: .cell)
        
        return cell
        
        if indexPath.section == 0 {
            
        
            
        } else {
            
//            let cell = tableView.dequeueReusableCell(AddCell.self, indexPath: indexPath)
            
//            cell.configureWith(buttonTitle: "Upload new product", delegate: self)
            
//            return cell
            
        }

    }
    
}

//extension MyProductsViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//
//        return 2
//        
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        if section == 0 {
//            
//            return 10
//
//        } else {
//
//            return 1
//
//        }
//
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//        if indexPath.section == 0 {
//
//            return 170
//
//        } else {
//
//            return 60
//            
//        }
//
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        if indexPath.section == 0 {
//
//            let cell = tableView.dequeueReusableCell(MyProductCell.self, indexPath: indexPath)
//
//            return cell
//        
//        } else {
//
//            let cell = tableView.dequeueReusableCell(AddCell.self, indexPath: indexPath)
//
//            cell.configureWith(buttonTitle: "Upload new product", delegate: self)
//
//            return cell
//            
//        }
//
//    }
//
//}

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
