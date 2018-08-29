import UIKit
import Segmentio

class FriendsViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    private var friendsService: FriendsService!
    
    fileprivate var friends: Array<Friend> = []
    
    func configureWith(friendsService: FriendsService) {
        
        self.friendsService = friendsService
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureView()
        
        self.configureNavigationBar()
        
        self.registerCells()
        
        self.getUserFriends(page: 1)
        
    }
    
    private func configureView() {
        
        self.view.setBackground()
        
        self.tableView.backgroundColor = .clear
        
        self.tableView.delegate = self
        
        self.tableView.dataSource = self
        
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)
        
        self.searchBar.delegate = self
        
    }
    
    private func configureNavigationBar() {
        
        let titleLabel = self.navigationController?.configureNavigationBarWithTitle(title: "Friends")
        
        self.navigationItem.titleView = titleLabel
        
        self.navigationItem.hidesBackButton = true
        
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backButtonIcon"), style: .plain, target: self, action: #selector(self.backButtonPressed(sender:)))
        
        self.navigationItem.leftBarButtonItem = backButton
        
        self.navigationController?.navigationBar.shadowImage = UIImage()

    }
    
    func backButtonPressed(sender: UIBarButtonItem) {
        
        self.popToViewController(ProfileViewController.self)
        
        self.popToViewController(ChatViewController.self)

    }
    
//    func createChat(sender: UIBarButtonItem) {
//
//       self.showConversationViewController()
//
//    }
    
    private func registerCells() {
        
        self.tableView.registerNib(FriendsDetailsCell.self)
        
    }
    
//    private func showChatSettingsPopupViewController() {
//
//        let factory = SecondaryViewControllerFactory.viewControllerFactory()
//
//        let controller = factory.chatSettingsPopupViewController()
//
//        controller.modalPresentationStyle = .overCurrentContext
//
//        controller.modalTransitionStyle = .crossDissolve
//
//        self.presentViewController(controller)
//
//    }
    
    fileprivate func showConversationViewController() {

        let factory = SecondaryViewControllerFactory.viewControllerFactory()

        let controller = factory.conversationViewController()

        self.navigationController?.pushViewController(controller, animated: true)

    }
    
    private func getUserFriends(page: Int) {
        
        guard let token = self.appContext.token() else { return }
        
        self.progressHUD.showLoading()
        
        self.friendsService.getFriends(page: page, token: token) { dataOptional, errorOptional in
            
            self.progressHUD.dismiss()
            
            if let error = errorOptional {
                
                self.showOkAlertWith(title: "Error", message: error.localizedDescription)
                
            } else {
                
                guard let data = dataOptional as? StorableDictionary,
                    let dictionary = data[k_data] as? StorableDictionary else {
                        
                        return
                        
                }
                
                if let friendsArray = dictionary[k_friends] as? Array<Dictionary<String, Any>> {
                    
                    friendsArray.forEach({ dict in
                        
                        let friends = Friend(dictionary: dict)
                        
                        self.friends.append(friends)
                        
                    })
                    
                    self.tableView.reloadData()
                    
                }
                
            }
            
        }
        
    }
    
}

extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.friends.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(FriendsDetailsCell.self, indexPath: indexPath)
        
        let friend = self.friends[indexPath.row]
        
        cell.configureWith(friend: friend)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.showConversationViewController()
        
    }
    
}

extension FriendsViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
    }
    
}
