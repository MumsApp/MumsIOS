import UIKit

protocol ShopCategoriesViewControllerDelegate: class {
    
    func categorySelected(title: String)
    
}

class ShopCategoriesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let categories = ShopCategories().list
    
    fileprivate var list = [Objects]()

    private struct Objects {
        
        var sectionName : String!
        var sectionObjects : [String]!
    
    }

    fileprivate weak var delegate: ShopCategoriesViewControllerDelegate?
    
    func configureWith(delegate: ShopCategoriesViewControllerDelegate?) {
        
        self.delegate = delegate
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureView()
    
        self.configureNavigationBar()
        
    }
    
    private func configureView() {
        
        self.tableView.delegate = self
        
        self.tableView.dataSource = self

        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)

        for (key, value) in categories {
            
            self.list.append(Objects(sectionName: key, sectionObjects: value))
            
        }
        
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
    
}

extension ShopCategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return self.list.count
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return self.list[section].sectionObjects.count

    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return self.list[section].sectionName

    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tableView.dequeueReusableCell(CategoriesHeaderCell.self)
        
        let thisObject = self.list[section].sectionName

        header.headerLabel.text = thisObject

        return header
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 60
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(CategoriesCell.self, indexPath: indexPath)
        
        let thisObject = self.list[indexPath.section].sectionObjects[indexPath.row]
        
        cell.categoryLabel.text = thisObject
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.navigationController?.popViewController(animated: true)
        
        let thisObject = self.list[indexPath.section].sectionObjects[indexPath.row]
        
        self.delegate?.categorySelected(title: thisObject)
        
    }
    
}
