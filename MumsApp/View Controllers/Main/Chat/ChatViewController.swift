import UIKit
import Segmentio

class ChatViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var segmentedControl: Segmentio!
    
    private var segmentedContent = [SegmentioItem]()

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
        
//        let rightButton = UIBarButtonItem(image: #imageLiteral(resourceName: "settingsIcon"), style: .plain, target: self, action: #selector(self.settingsButtonPressed(sender:)))
        
//        self.navigationItem.rightBarButtonItem = rightButton
        
//        let leftButton = UIBarButtonItem(image: #imageLiteral(resourceName: "filterIcon"), style: .plain, target: self, action: #selector(self.filterButtonPressed(sender:)))
//        
//        self.navigationItem.leftBarButtonItem = leftButton
        
        self.navigationController?.navigationBar.shadowImage = UIImage()

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

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return self.friends.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 140
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(ChatCell.self, indexPath: indexPath)
        
        let friend = self.friends[indexPath.row]
        
        cell.configureWith(friend: friend)
        
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
