import UIKit

class LobbyConversationViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var lobbyPostService: LobbyPostService!
    
    fileprivate var lobbyPosts: Array<LobbyPost> = []
    
    private var roomId: String!

    private var topicId: String!

    fileprivate var imageLoader: ImageCacheLoader!

    private var shouldReply = false
    
    fileprivate var pages: Int = 1
    
    fileprivate var currentPage: Int = 1
    
    func configureWith(shouldReply: Bool, roomId: String, topicId: String, title: String, lobbyPostService: LobbyPostService, imageLoader: ImageCacheLoader) {
        
        self.title = title
        
        self.roomId = roomId

        self.topicId = topicId

        self.lobbyPostService = lobbyPostService
        
        self.imageLoader = imageLoader
        
        self.shouldReply = shouldReply
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureView()
        
        self.configureNavigationBar()
        
        self.getLobbyPostsWithPagination(page: 1)
        
    }
    
    private func configureView() {
        
        self.view.setBackground()
        
        self.tableView.backgroundColor = .clear
        
        self.tableView.delegate = self
        
        self.tableView.dataSource = self
        
        self.tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom:
            80, right: 0)
        
        self.tableView.registerNib(LobbyConversationCell.self)
        
        self.tableView.registerNib(LobbyConversationFooter.self)
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.tableView.estimatedRowHeight = 60
        
    }
    
    private func configureNavigationBar() {
        
        let titleLabel = self.navigationController?.configureNavigationBarWithTitle(title: self.title!)
        
        self.navigationItem.titleView = titleLabel
        
        self.navigationItem.hidesBackButton = true
        
        let rightButton = UIBarButtonItem(image: #imageLiteral(resourceName: "writeIcon"), style: .plain, target: self, action: #selector(self.writeButtonPressed(sender:)))
        
        rightButton.tintColor = .black
        
        self.navigationItem.rightBarButtonItem = rightButton
        
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backButtonIcon"), style: .plain, target: self, action: #selector(self.backButtonPressed(sender:)))
        
        self.navigationItem.leftBarButtonItem = backButton
        
    }
    
    func backButtonPressed(sender: UIBarButtonItem) {

        self.navigationController?.popViewController(animated: true)

    }

    func writeButtonPressed(sender: UIBarButtonItem) {

        self.showAddPostAlert()

    }
    
    fileprivate func getLobbyPostsWithPagination(page: Int) {
        
        guard let token = self.appContext.token() else { return }
    
        self.lobbyPostService.getLobbyPostsWithPagination(roomId: self.roomId, topicId: self.topicId, token: token, page: page) { dataOptional, errorOptional in
            
            if let error = errorOptional {
                
                self.showOkAlertWith(title: "Error", message: error.localizedDescription)
                
            } else {
                
                if let dictionary = dataOptional as? Dictionary<String, Any> {
                    
                    if let data = dictionary[k_data] as? Dictionary<String, Any> {
                        
                        if let pages = data[k_pages] as? Int {
                            
                            self.pages = pages
                            
                        }
                        
                        if let posts = data[k_posts] as? Array<Dictionary<String, Any>> {
                            
                            self.lobbyPosts = []
                            
                            for p in posts {
                                
                                self.lobbyPosts.append(LobbyPost(dictionary: p))
                                
                            }
                            
                            self.lobbyPosts.sort (by: { $0.creationDate! > $1.creationDate! })

                            self.tableView.reloadData()
                        
                            if self.shouldReply {
                                
                                self.showAddPostAlert()
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    private func addLobbyPost(description: String) {
        
        guard let token = self.appContext.token() else { return }
        
        self.lobbyPostService.addLobbyPost(roomId: self.roomId, topicId: self.topicId, description: description, token: token) { dataOptional, errorOptional in
            
            if let error = errorOptional {
                
                self.showOkAlertWith(title: "Error", message: error.localizedDescription)
                
            } else {
                
               // Reload
                
            }
            
        }
        
    }
    
    private func showAddPostAlert() {
        
        self.showInputDialog(title: "Create post", subtitle: "", actionTitle: "Post", cancelTitle: "Cancel", inputPlaceholder: "Type something", inputKeyboardType: .default, cancelHandler: { _ in
            
            self.dismissViewController()
            
        }) { text in
            
            guard let description = text else { return }
            
            self.addLobbyPost(description: description)
            
        }
        
    }
    
}

extension LobbyConversationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {

            return self.lobbyPosts.count

        } else {

            return 1

        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            
            return UITableViewAutomaticDimension
            
        } else {
            
            return 60
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(LobbyConversationCell.self)
            
            let thisObject = self.lobbyPosts[indexPath.row]
            
            cell.configureWith(delegate: self, lobbyPost: thisObject)
            
            cell.containerView.backgroundColor = indexPath.row % 2 == 0 ? .white : .chatGreyColor
            
            if let img = thisObject.author?.img {
                
                self.imageLoader.obtainImageWithPath(imagePath: BASE_PUBLIC_IMAGE_URL + img) { (image) in
                    
                    if let _ = tableView.cellForRow(at: indexPath) {
                        
                        cell.userImageView.image = image
                        
                    }
                    
                }
                
            }
            
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(LobbyConversationFooter.self)
            
            cell.configureWith(delegate: self)
            
            cell.pageLabel.text = "Page \(self.currentPage)/\(self.pages)"
            
            return cell

        }
        
    }

}

extension LobbyConversationViewController: LobbyConversationCellDelegate {
    
    func userButtonPressed(userId: String) {
        
        self.showUserViewController(userId: userId)
        
    }
    
    func showUserViewController(userId: String) {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.userViewController(userId: userId)
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
}

extension LobbyConversationViewController: LobbyConversationFooterDelegate {
    
    func firstButtonPressed() {
        
        if self.currentPage != 1 {
            
            self.currentPage = 1
            
            self.getLobbyPostsWithPagination(page: 1)

        }
        
    }
    
    func previousButtonPressed() {
        
        if self.currentPage > 1 {
            
            self.currentPage -= 1
            
            self.getLobbyPostsWithPagination(page: self.currentPage)
            
        }
        

    }
    
    func nextButtonPressed() {
        
        if self.currentPage < self.pages {
            
            self.currentPage += 1

            self.getLobbyPostsWithPagination(page: self.currentPage)
            
        }
        
    }
    
    func lastButtonPressed() {
        
        if self.currentPage != self.pages {
            
            self.currentPage = self.pages
            
            self.getLobbyPostsWithPagination(page: self.pages)
            
        }

    }
    
}
