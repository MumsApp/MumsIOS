import UIKit

class ChatViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureView()
        
        self.configureNavigationBar()
        
        self.registerCells()
        
    }
    
    private func configureView() {
        
        self.view.backgroundColor = .backgroundWhite

        self.tableView.backgroundColor = .backgroundWhite

        self.tableView.delegate = self
        
        self.tableView.dataSource = self
        
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)

        self.searchBar.delegate = self

    }

    private func configureNavigationBar() {
        
        let titleLabel = self.navigationController?.configureNavigationBarWithTitle(title: "Chats")
        
        self.navigationItem.titleView = titleLabel
        
        self.navigationItem.hidesBackButton = true
        
        let rightButton = UIBarButtonItem(image: #imageLiteral(resourceName: "settingsIcon"), style: .plain, target: self, action: #selector(self.settingsButtonPressed(sender:)))
        
        self.navigationItem.rightBarButtonItem = rightButton
        
        let leftButton = UIBarButtonItem(image: #imageLiteral(resourceName: "filterIcon"), style: .plain, target: self, action: #selector(self.filterButtonPressed(sender:)))
        
        self.navigationItem.leftBarButtonItem = leftButton
        
    }
    
    private func registerCells() {
        
        self.tableView.registerNib(ChatCell.self)
        
    }
    
    func settingsButtonPressed(sender: UIBarButtonItem) {
        
        self.showChatSettingsPopupViewController()
        
    }
    
    func filterButtonPressed(sender: UIBarButtonItem) {
        
        
        
    }
    
    private func showChatSettingsPopupViewController() {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.chatSettingsPopupViewController()
        
        controller.modalPresentationStyle = .overCurrentContext
        
        controller.modalTransitionStyle = .crossDissolve
        
        self.presentViewController(controller)
        
    }
    
    fileprivate func showConversationViewController() {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.conversationViewController()
    
        self.navigationController?.pushViewController(controller, animated: true)
    
    }
    
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return 10
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 140
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(ChatCell.self, indexPath: indexPath)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.showConversationViewController()
        
    }
   
}

extension ChatViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
    }
    
}
