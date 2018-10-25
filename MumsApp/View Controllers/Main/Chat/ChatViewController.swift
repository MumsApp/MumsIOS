import UIKit
import Segmentio

class ChatViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var segmentedControl: Segmentio!
    
    private var segmentedContent = [SegmentioItem]()

//    private var friendsService: FriendsService!
    
    fileprivate var lastMessages: Array<LastMessage> = []
    
    private var chatService: ChatService!
    
    func configureWith(chatService: ChatService) {
        
        self.chatService = chatService
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureView()
        
        self.configureNavigationBar()
        
        self.registerCells()
        
        self.getLastMessages()
        
    }

    private func configureView() {
        
        self.view.setBackground()

        self.tableView.backgroundColor = .clear

        self.tableView.delegate = self
        
        self.tableView.dataSource = self
        
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)

        self.searchBar.delegate = self

        let friendsItem = SegmentioItem(title: "Friends", image: nil)
        
        let othersItem = SegmentioItem(
            title: "Others", image: nil)

        self.segmentedContent.append(friendsItem)
        self.segmentedContent.append(othersItem)
        
        let indicatorOptions = SegmentioIndicatorOptions(
            type: .bottom,
            ratio: 1,
            height: 4,
            color: .mainGreen
        )
        
        let horizontalOptions = SegmentioHorizontalSeparatorOptions(
            type: SegmentioHorizontalSeparatorType.topAndBottom, // Top, Bottom, TopAndBottom
            height: 1,
            color: .clear
        )
        
        let verticalOptions = SegmentioVerticalSeparatorOptions(
            ratio: 0.6, // from 0.1 to 1
            color: .clear
        )
        
        let states = SegmentioStates(
            defaultState: SegmentioState(
                backgroundColor: .clear,
                titleFont: .medium(size: 15),
                titleTextColor: .black
            ),
            selectedState: SegmentioState(
                backgroundColor: .clear,
                titleFont: .medium(size: 15),
                titleTextColor: .black
            ),
            highlightedState: SegmentioState(
                backgroundColor: .clear,
                titleFont: .medium(size: 15),
                titleTextColor: .black
            )
        )
        
        let options = SegmentioOptions(
            backgroundColor: .white,
            segmentPosition: SegmentioPosition.fixed(maxVisibleItems: 2),
            scrollEnabled: false,
            indicatorOptions: indicatorOptions,
            horizontalSeparatorOptions: horizontalOptions,
            verticalSeparatorOptions: verticalOptions,
            imageContentMode: .center,
            labelTextAlignment: .center,
            segmentStates: states
        )
        
        self.segmentedControl.setup(
            content: segmentedContent,
            style: SegmentioStyle.imageOverLabel,
            options: options
        )
        
        self.segmentedControl.selectedSegmentioIndex = 0

        self.segmentedControl.valueDidChange = { segmentio, segmentIndex in
        
            print("Selected item: ", segmentIndex)
        
        }

    }

    private func configureNavigationBar() {
        
        let titleLabel = self.navigationController?.configureNavigationBarWithTitle(title: "Chats")
        
        self.navigationItem.titleView = titleLabel
        
        self.navigationItem.hidesBackButton = true
        
        let rightButton = UIBarButtonItem(image: #imageLiteral(resourceName: "addIcon"), style: .plain, target: self, action: #selector(self.createChat(sender:)))
        
        self.navigationItem.rightBarButtonItem = rightButton
        
//        let leftButton = UIBarButtonItem(image: #imageLiteral(resourceName: "filterIcon"), style: .plain, target: self, action: #selector(self.filterButtonPressed(sender:)))
//        
//        self.navigationItem.leftBarButtonItem = leftButton
        
        self.navigationController?.navigationBar.shadowImage = UIImage()

    }
    
    private func registerCells() {
        
        self.tableView.registerNib(ChatCell.self)
        
    }
    
    func createChat(sender: UIBarButtonItem) {
        
        self.showFriendsViewController()
        
    }
    
    private func showFriendsViewController() {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.friendsViewController()
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }

    func filterButtonPressed(sender: UIBarButtonItem) {
        
        
        
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
    
    fileprivate func showConversationViewController(useridB: String) {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.conversationViewController(userIdB: useridB)
    
        self.navigationController?.pushViewController(controller, animated: true)
    
    }
    
    private func getLastMessages() {
     
        guard let token = self.appContext.token() else { return }

        self.progressHUD.showLoading()

        self.chatService.getLastMessages(token: token) { dataOptional, errorOptional in

            self.progressHUD.dismiss()

            if let error = errorOptional {
                
                self.showOkAlertWith(title: "Error", message: error.localizedDescription)
                
            } else {
                
                guard let data = dataOptional as? StorableDictionary,
                    let array = data[k_data] as? Array<Dictionary<String, Any>> else {
                        
                        return
                        
                }
                
                for dict in array {
                    
                    let message = LastMessage(dictionary: dict)
                    
                    self.lastMessages.append(message)

                }
         
                self.tableView.reloadData()
                
            }

        }
        
    }
        
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return self.lastMessages.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 140
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(ChatCell.self, indexPath: indexPath)
        
        let message = self.lastMessages[indexPath.row]
        
        cell.configureWith(message: message)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let message = self.lastMessages[indexPath.row]

        let stringArray = message.roomName!.components(separatedBy: CharacterSet.decimalDigits.inverted)
        
        for item in stringArray {
        
            if let number = Int(item) {
            
                let n = String(number)
                
                if n != self.appContext.userId() {
                    
                    self.showConversationViewController(useridB: n)
                    
                }

            }
        
        }
 
    }
   
}

extension ChatViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
    }
    
}
