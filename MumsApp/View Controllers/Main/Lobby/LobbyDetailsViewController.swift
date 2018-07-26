import UIKit

class LobbyDetailsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var isBackButtonVisible: Bool = false
    
    private var lobbyTopicService: LobbyTopicService!
    
    private var roomId: String!
    
    fileprivate var lobbyTopics: Array<LobbyTopic> = []
    
    fileprivate var imageLoader: ImageCacheLoader!

    fileprivate var pages: Int = 1
    
    fileprivate var currentPage: Int = 1
    
    func configureWith(roomId: String, title: String, backButton: Bool, lobbyTopicService: LobbyTopicService, imageLoader: ImageCacheLoader) {
        
        self.title = title
        
        self.isBackButtonVisible = backButton
        
        self.roomId = roomId
        
        self.lobbyTopicService = lobbyTopicService
        
        self.imageLoader = imageLoader

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureView()
        
        self.configureNavigationBar()
        
        self.getLobbyTopicsWithPagination(page: 1)
        
    }
    
    private func configureView() {
        
        self.view.setBackground()

        self.tableView.backgroundColor = .clear
        
        self.tableView.delegate = self
        
        self.tableView.dataSource = self
        
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom:
            80, right: 0)
        
        self.tableView.registerNib(LobbyDetailsCell.self)
    
        self.tableView.registerNib(LobbyConversationFooter.self)
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.tableView.estimatedRowHeight = 225

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
        
        self.showCreateTopicViewController()
        
    }
    
    private func showCreateTopicViewController() {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.createTopicViewController(roomId: self.roomId, reloadDelegate: self)
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    fileprivate func showLobbyConversationViewController(shouldReply: Bool, topicId: String, title: String) {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.lobbyConversationViewController(shouldReply: shouldReply, roomId: self.roomId, topicId: topicId, title: title)
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    fileprivate func getLobbyTopicsWithPagination(page: Int) {
        
        guard let token = self.appContext.token() else { return }

        self.lobbyTopicService.getLobbyTopicsWithPagination(roomId: self.roomId, token: token, page: page) { dataOptional, errorOptional in
            
            if let error = errorOptional {
                
                self.showOkAlertWith(title: "Error", message: error.localizedDescription)
                
            } else {
                
                if let dictionary = dataOptional as? Dictionary<String, Any> {
                    
                    if let data = dictionary[k_data] as? Dictionary<String, Any> {

                        if let pages = data[k_pages] as? Int {

                            self.pages = pages

                        }
                        
                        if let posts = data[k_posts] as? Array<Dictionary<String, Any>> {
                            
                            self.lobbyTopics = []
                            
                            for post in posts {
                                
                                self.lobbyTopics.append(LobbyTopic(dictionary: post))
                                
                            }
                            
                            self.lobbyTopics.sort (by: { $0.creationDate! > $1.creationDate! })
                            
                            self.tableView.reloadData()
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
}

extension LobbyDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            
            return self.lobbyTopics.count
            
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

            let cell = tableView.dequeueReusableCell(LobbyDetailsCell.self)
            
            let thisObject = self.lobbyTopics[indexPath.row]
            
            cell.configureWith(delegate: self, topic: thisObject)
            
            if let img = thisObject.creator?.img {
                
                self.imageLoader.obtainImageWithPath(imagePath: BASE_PUBLIC_IMAGE_URL + img) { (image) in
                
                    cell.userImageView.image = image
                    
                }
                
            } else {
                
                cell.userImageView.image = #imageLiteral(resourceName: "placeholderImage")
                
            }
            
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(LobbyConversationFooter.self)
            
            cell.configureWith(delegate: self)
            
            cell.pageLabel.text = "Page \(self.currentPage)/\(self.pages)"
            
            return cell
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let thisObject = self.lobbyTopics[indexPath.row]
        
        self.showLobbyConversationViewController(shouldReply: false, topicId: String(thisObject.id!), title: thisObject.title!)
        
    }
    
}

extension LobbyDetailsViewController: LobbyDetailsCellDelegate {
    
    func replyButtonPressed(topic: LobbyTopic) {
        
        self.showLobbyConversationViewController(shouldReply: true, topicId: String(topic.id!), title: topic.title!)

    }
    
    func userButtonPressed(userId: String) {
        
        self.showUserViewController(userId: userId)
        
    }
    
    func showUserViewController(userId: String) {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.userViewController(userId: userId)
    
        self.navigationController?.pushViewController(controller, animated: true)
    
    }
    
}

extension LobbyDetailsViewController: LobbyConversationFooterDelegate {
    
    func firstButtonPressed() {
        
        if self.currentPage != 1 {
            
            self.currentPage = 1
            
            self.getLobbyTopicsWithPagination(page: 1)
            
        }
        
    }
    
    func previousButtonPressed() {
        
        if self.currentPage > 1 {
            
            self.currentPage -= 1
            
            self.getLobbyTopicsWithPagination(page: self.currentPage)
            
        }
        
        
    }
    
    func nextButtonPressed() {
        
        if self.currentPage < self.pages {
            
            self.currentPage += 1
            
            self.getLobbyTopicsWithPagination(page: self.currentPage)
            
        }
        
    }
    
    func lastButtonPressed() {
        
        if self.currentPage != self.pages {
            
            self.currentPage = self.pages
            
            self.getLobbyTopicsWithPagination(page: self.pages)
            
        }
        
    }
    
}

extension LobbyDetailsViewController: ReloadDelegate {
    
    func reloadData() {
    
        self.getLobbyTopicsWithPagination(page: self.currentPage)
        
    }
    
}
