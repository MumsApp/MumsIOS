import UIKit

class LobbyConversationViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    func configureWith(title: String, backButton: Bool) {
        
        self.title = title
                
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
        
        self.tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom:
            80, right: 0)
        
        self.tableView.registerNib(LobbyConversationCell.self)
        
        self.tableView.registerNib(LobbyConversationFooter.self)
        
       
        
    }
    
    private func configureNavigationBar() {
        
        let titleLabel = self.navigationController?.configureNavigationBarWithTitle(title: "Title")
        
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


    }
    
}

extension LobbyConversationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {

            return 10

        } else {

            return 1

        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            
            return 130
            
        } else {
            
            return 60
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(LobbyConversationCell.self)
            
            cell.configureWith(delegate: self)
            
            cell.containerView.backgroundColor = indexPath.row % 2 == 0 ? .white : .chatGreyColor
            
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(LobbyConversationFooter.self)
            
            return cell

        }
        
    }

}

extension LobbyConversationViewController: LobbyConversationCellDelegate {
    
    func userButtonPressed() {
        
        self.showUserViewController()
        
    }
    
    func showUserViewController() {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.userViewController()
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
}
