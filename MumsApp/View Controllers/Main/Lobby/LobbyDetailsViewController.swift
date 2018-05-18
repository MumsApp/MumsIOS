import UIKit

class LobbyDetailsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var isBackButtonVisible: Bool = false
    
    func configureWith(title: String, backButton: Bool) {
        
        self.title = title
        
        self.isBackButtonVisible = backButton
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureView()
        
        self.configureNavigationBar()
        
    }
    
    private func configureView() {
        
        self.view.setBackground()

        self.tableView.backgroundColor = .clear
        
        self.tableView.delegate = self
        
        self.tableView.dataSource = self
        
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom:
            80, right: 0)
        
        self.tableView.registerNib(LobbyDetailsCell.self)
        
    }
    
    private func configureNavigationBar() {
        
        let titleLabel = self.navigationController?.configureNavigationBarWithTitle(title: self.title!)
        
        self.navigationItem.titleView = titleLabel
        
        self.navigationItem.hidesBackButton = true
        
        let rightButton = UIBarButtonItem(image: #imageLiteral(resourceName: "writeIcon"), style: .plain, target: self, action: #selector(self.writeButtonPressed(sender:)))
        
        rightButton.tintColor = .black
        
        self.navigationItem.rightBarButtonItem = rightButton
        
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backButtonIcon"), style: .plain, target: self, action: #selector(self.backButtonPressed(sender:)))
        
        self.navigationItem.leftBarButtonItem = self.isBackButtonVisible == true ? backButton : nil
        
    }

    func backButtonPressed(sender: UIBarButtonItem) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func writeButtonPressed(sender: UIBarButtonItem) {
        
        self.showCreatePostViewController()
        
    }
    
    private func showCreatePostViewController() {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.createPostViewController()
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
}

extension LobbyDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(LobbyDetailsCell.self)
        
        cell.configureWith(delegate: self)
        
        return cell
        
    }
    
}

extension LobbyDetailsViewController: LobbyDetailsCellDelegate {
    
    func replyButtonPressed() {
        
        // TODO: - 
        
    }
    
    func userButtonPressed() {
        
        self.showUserViewController()
        
    }
    
    func showUserViewController() {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.userViewController()
    
        self.navigationController?.pushViewController(controller, animated: true)
    
    }
    
}
