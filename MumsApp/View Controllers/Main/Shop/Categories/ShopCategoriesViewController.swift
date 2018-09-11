import UIKit

protocol ShopCategoriesViewControllerDelegate: class {
    
    func categorySelected(category: ShopSubCategory)
    
}

class ShopCategoriesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var shopCategories = [ShopCategory]()

    fileprivate weak var delegate: ShopCategoriesViewControllerDelegate?
    
    private var shopCategoryService: ShopCategoryService!
    
    fileprivate var type: ShopViewType = .shop
    
    func configureWith(delegate: ShopCategoriesViewControllerDelegate?, shopCategoryService: ShopCategoryService) {
        
        self.delegate = delegate
        
        self.shopCategoryService = shopCategoryService
        
        self.type = self.shopCategoryService.type
        
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

        self.progressHUD.showLoading()
        
        self.shopCategoryService.getShopCategories(token: token) { dataOptional, errorOptional in
            
            self.progressHUD.dismiss()
            
            if let error = errorOptional {
                
                self.showOkAlertWith(title: "Error", message: error.localizedDescription)
                
            } else {
                
                if let dictionary = dataOptional as? Dictionary<String, Any> {
                    
                    if let data = dictionary[k_data] as? Array<Dictionary<String, Any>> {
                                                
                        self.shopCategories = []
                        
                        if self.type == .shop {
                            
                            for d in data {
                                
                                self.shopCategories.append(ShopCategory(dictionary: d))
                                
                            }
                            
                            self.tableView.reloadData()
                            
                        } else {
                           
                            for section in categories {

                                self.shopCategories.append(ShopCategory(dictionary: section))
                                
                            }
                            
                            for d in data {
                                
                                let object = ShopSubCategory(dictionary: d)

                                for c in self.shopCategories {
                                    
                                    if object.name?.first == c.name?.first {
                                        
                                        self.shopCategories[c.id!].subCategories.append(object)
                                        
                                    }
                                    
                                }
                                
                            }
                            
                            self.tableView.reloadData()

                        }
                        
                    }
                    
                }
            
            }
            
        }
        
    }
    
}

let categories = [[k_id: 0, k_name: "A"],
                  [k_id: 1, k_name: "B"],
                  [k_id: 2, k_name: "C"],
                  [k_id: 3, k_name: "D"],
                [k_id: 4, k_name: "E"],
                [k_id: 5, k_name: "F"],
                [k_id: 6, k_name: "G"],
                [k_id: 7, k_name: "H"],
                [k_id: 8, k_name: "I"],
                [k_id: 9, k_name: "J"],
                [k_id: 10, k_name: "K"],
                [k_id: 11, k_name: "L"],
                [k_id: 12, k_name: "M"],
                [k_id: 13, k_name: "N"],
                [k_id: 14, k_name: "O"],
                [k_id: 15, k_name: "P"],
                [k_id: 16, k_name: "R"],
                [k_id: 17, k_name: "S"],
                [k_id: 18, k_name: "T"],
                [k_id: 19, k_name: "U"],
                [k_id: 20, k_name: "W"],
                [k_id: 21, k_name: "X"],
                [k_id: 22, k_name: "Y"],
                [k_id: 23, k_name: "Z"]]

extension ShopCategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return self.shopCategories.count
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return self.shopCategories[section].subCategories.count
        
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
        
        let thisObject = self.shopCategories[indexPath.section].subCategories[indexPath.row]
        
        cell.categoryLabel.text = thisObject.name
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.navigationController?.popViewController(animated: true)
        
        let thisObject = self.shopCategories[indexPath.section].subCategories[indexPath.row]
        
        self.delegate?.categorySelected(category: thisObject)
        
    }
    
}
