import UIKit

protocol ShopCategoriesViewControllerDelegate: class {
    
    func categorySelected(category: ShopSubCategory)
    
}

class ShopCategoriesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var shopCategories = [ShopCategory]()

    fileprivate weak var delegate: ShopCategoriesViewControllerDelegate?
    
    private var shopCategoryService: ShopCategoryService!
    
    func configureWith(delegate: ShopCategoriesViewControllerDelegate?, shopCategoryService: ShopCategoryService) {
        
        self.delegate = delegate
        
        self.shopCategoryService = shopCategoryService
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureView()
    
        self.configureNavigationBar()
        
        self.getShopCategories()
        
    }
    
    private func configureView() {
        
        self.tableView.delegate = self
        
        self.tableView.dataSource = self

        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)
        
    }
    
    private func configureNavigationBar() {
        
        let titleLabel = self.navigationController?.configureNavigationBarWithTitle(title: "Categories")
        
        self.navigationItem.titleView = titleLabel
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        self.navigationItem.hidesBackButton = true
        
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backButtonIcon"), style: .plain, target: self, action: #selector(self.backButtonPressed(sender:)))
        
        self.navigationItem.leftBarButtonItem = backButton
        
    }
    
    func backButtonPressed(sender: UIBarButtonItem) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    private func getShopCategories() {

        guard let token = self.appContext.token() else { return }

        self.shopCategoryService.getShopCategories(token: token) { dataOptional, errorOptional in
            
            if let error = errorOptional {
                
                self.showOkAlertWith(title: "Error", message: error.localizedDescription)
                
            } else {
                
                if let dictionary = dataOptional as? Dictionary<String, Any> {
                    
                    if let data = dictionary[k_data] as? Array<Dictionary<String, Any>> {
                        
                        self.shopCategories = []
                        
                        for d in data {
                            
                            self.shopCategories.append(ShopCategory(dictionary: d))
                            
                        }
                        
                        self.tableView.reloadData()
                        
                    }
                    
                }
            
            }
            
        }
        
    }
    
}

extension ShopCategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return self.shopCategories.count
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return self.shopCategories[section].subCategories!.count

    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return self.shopCategories[section].name

    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tableView.dequeueReusableCell(CategoriesHeaderCell.self)
        
        let thisObject = self.shopCategories[section].name

        header.headerLabel.text = thisObject

        return header
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 60
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(CategoriesCell.self, indexPath: indexPath)
        
        let thisObject = self.shopCategories[indexPath.section].subCategories![indexPath.row]
        
        cell.categoryLabel.text = thisObject.name
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.navigationController?.popViewController(animated: true)
        
        let thisObject = self.shopCategories[indexPath.section].subCategories![indexPath.row]
        
        self.delegate?.categorySelected(category: thisObject)
        
    }
    
}
