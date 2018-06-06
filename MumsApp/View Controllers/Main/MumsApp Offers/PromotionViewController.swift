import UIKit

// !- GET VOUCHER CODE SHOULD BE OPTIONAL !- //

class PromotionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!

    @IBOutlet weak var companyImageButton: UIButton!
    
    @IBOutlet weak var promotionDescriptionView: PromotionDescriptionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureView()
        
        self.configureNavigationBar()

    }

    private func configureView() {
        
        self.view.setBackground()

        self.collectionView.backgroundColor = .clear
        
        self.collectionView.register(PictureCell.self, type: .cell)
        
        self.collectionView.delegate = self
        
        self.collectionView.dataSource = self
        
        self.pageControl.numberOfPages = 5
        
        self.companyImageButton.layer.cornerRadius = 35
        
        self.companyImageButton.layer.masksToBounds = true
        
        self.promotionDescriptionView.configureView(delegate: self)
        
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
    
    private func showOrganisationViewController() {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.organisationViewController()
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    @IBAction func companyImageButtonPressed(_ sender: UIButton) {
    
        self.showOrganisationViewController()
        
    }
    
}

extension PromotionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableClass(PictureCell.self, forIndexPath: indexPath, type: .cell)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        self.pageControl.currentPage = indexPath.row
        
    }
    
}

extension PromotionViewController: PromotionDescriptionViewDelegate {
    
    func redeemButtonPressed() {
        
        self.showPromotionPopupViewController()
        
    }
    
    private func showPromotionPopupViewController() {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.promotionPopupViewController()
        
        controller.modalPresentationStyle = .overCurrentContext
        
        controller.modalTransitionStyle = .crossDissolve
        
        self.presentViewController(controller)
        
    }
}
