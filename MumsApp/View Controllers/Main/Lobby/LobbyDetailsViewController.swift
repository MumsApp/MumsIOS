import UIKit

class LobbyDetailsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var isBackButtonVisible: Bool = false
    
    private var lobbyTopicService: LobbyTopicService!
    
    private var roomId: String!
    
    fileprivate var lobbyTopics: Array<LobbyTopic> = []
    
    fileprivate var imageLoader: ImageCacheLoader!

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
        
        let controller = factory.createTopicViewController(roomId: self.roomId)
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    fileprivate func showLobbyConversationViewController() {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.lobbyConversationViewController()
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    private func getLobbyTopicsWithPagination(page: Int) {
        
        guard let token = self.appContext.token() else { return }

        self.lobbyTopicService.getLobbyTopicsWithPagination(roomId: self.roomId, token: token, page: page) { dataOptional, errorOptional in
            
            if let error = errorOptional {
                
                self.showOkAlertWith(title: "Error", message: error.localizedDescription)
                
            } else {
                
                if let dictionary = dataOptional as? Dictionary<String, Any> {
                    
                    if let data = dictionary[k_data] as? Array<Dictionary<String, Any>> {
                        
                        for d in data {
                            
                            self.lobbyTopics.append(LobbyTopic(dictionary: d))
                            
                        }
                                                
                        self.tableView.reloadData()
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
}

extension LobbyDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.lobbyTopics.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(LobbyDetailsCell.self)
        
        let thisObject = self.lobbyTopics[indexPath.row]
        
        cell.configureWith(delegate: self, topic: thisObject)
        
        if let img = thisObject.creator?.img {
            
            self.imageLoader.obtainImageWithPath(imagePath: BASE_PUBLIC_IMAGE_URL + img) { (image) in
                
                if let _ = tableView.cellForRow(at: indexPath) {
                    
                    cell.userImageView.image = image
                    
                }
                
            }
            
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.showLobbyConversationViewController()
        
    }
    
}

extension LobbyDetailsViewController: LobbyDetailsCellDelegate {
    
    func replyButtonPressed() {
        
        self.showLobbyConversationViewController()
        
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
