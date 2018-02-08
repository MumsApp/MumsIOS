import UIKit

class TermsViewController: UIViewController {
    
    typealias ObjectType = Terms
    
    typealias DataSource = ArrayDataSourceProvider<ObjectType, DataSourceProviderTableViewAdapter<ObjectType>>

    @IBOutlet weak var tableView: UITableView!

    fileprivate var dataSource: DataSource!

    fileprivate var cellHeights: [IndexPath : CGFloat] = [:]
    
    func configureWith(dataSource: DataSource) {
        
        self.dataSource = dataSource
  
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureView()
     
        self.configureNavigationBar()
        
        self.configureWithFile()
        
    }
    
    /// Used to configure view
    private func configureView() {
        
        self.tableView.isHidden = true
        
        self.tableView.delegate = self
        
        self.tableView.dataSource = self
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.tableView.estimatedRowHeight = 68
        
        self.tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        
        UIApplication.shared.statusBarStyle = .default
        
    }
    
    private func configureNavigationBar() {
        
        let titleLabel = self.navigationController?.configureNavigationBarWithTitle(title: "Terms & Conditions")
        
        self.navigationItem.titleView = titleLabel
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        self.navigationItem.hidesBackButton = true
        
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backButtonIcon"), style: .plain, target: self, action: #selector(self.backButtonPressed(sender:)))
        
        self.navigationItem.leftBarButtonItem = backButton
        
    }
    
    func backButtonPressed(sender: UIBarButtonItem) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    /// Used to fetch data from json file
    private func configureWithFile() {
        
        if let dictionary = dictionaryFromJSONFile(name: "Terms.json", bundle: Bundle.main) as? Dictionary<String, Any> {
            
            self.populateDataStore(dict: dictionary)
            
        }
        
    }
    
    /// Used to populate data store with data
    private func populateDataStore(dict: Dictionary<String, Any>) {
        
        if let results = dict[k_terms] as? [Dictionary<String, Any>] {
            
            self.dataSource.batchUpdates {
                
                self.dataSource.deleteAllInSection(0)
                
                var index = 0
                
                results.forEach {
                    
                    let result = Terms(dictionary: $0)
                    
                    let indexPath = IndexPath(row: index, section: 0)
                    
                    self.dataSource.insertItem(result, atIndexPath: indexPath)
                    
                    index += 1
                    
                }
                
                self.tableView.isHidden = false
                
            }
            
        }
        
    }
    
}

extension TermsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let height = self.cellHeights[indexPath] else { return 68 }
        
        return height
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataSource.itemsArray().count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(TermsCell.self)
        
        if self.dataSource.itemsArray().indices.contains(indexPath.row) {
            
            let result = self.dataSource.itemAtIndexPath(indexPath) as Terms
            
            cell.configureWith(result: result)
            
        }
        
        return cell
        
    }
    
}

