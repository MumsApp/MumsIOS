import UIKit

let KIDS_CELL = "KidsCell"
let ADD_CONTACT_CELL = "AddContactCell"
let REMOVE_CONTACT_CELL = "RemoveContactCell"

enum UserViewType {
    
    case add
    case remove
    
}

class UserViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!

    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userDescriptionTextView: UITextView!
    
    @IBOutlet weak var numberOfKidsLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
   
    @IBOutlet weak var locationView: ItemLocationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureView()
    
        self.configureTableView()
        
        self.configureNavigationBar()
        
    }

    private func configureView() {
        
        self.view.backgroundColor = .backgroundWhite

        self.userImageView.layer.cornerRadius = 35
        
        self.userNameLabel.font = .regular(size: 20)
        
        self.userNameLabel.textColor = .black
        
        self.userDescriptionTextView.font = .regular(size: 12)
        
        self.userDescriptionTextView.textColor = .mainDarkGrey
     
        self.numberOfKidsLabel.font = .regular(size: 13)
        
        self.numberOfKidsLabel.textColor = .mainDarkGrey
        
        self.containerView.addShadow()
        
        self.tableView.addShadow()
        
    }
    
    private func configureTableView() {
        
        self.tableView.delegate = self
        
        self.tableView.dataSource = self
        
        self.tableView.backgroundColor = .clear
        
        self.tableView.tableFooterView = UIView()

        self.tableView.registerNib(AddCell.self)

    }
    
    private func configureNavigationBar() {
        
        let titleLabel = self.navigationController?.configureNavigationBarWithTitle(title: "User Profile")
        
        self.navigationItem.titleView = titleLabel
        
        self.navigationItem.hidesBackButton = true
        
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backButtonIcon"), style: .plain, target: self, action: #selector(self.backButtonPressed(sender:)))
        
        self.navigationItem.leftBarButtonItem = backButton
        
    }
    
    func backButtonPressed(sender: UIBarButtonItem) {
        
        self.navigationController?.popViewController(animated: true)
        
        
    }
    
}

extension UserViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 40
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: KIDS_CELL, for: indexPath)
            
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 80
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let type: UserViewType = .remove
        
        if type == .add {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: ADD_CONTACT_CELL) as! AddContactCell
            
            cell.configureWith(delegate: self)
            
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: REMOVE_CONTACT_CELL) as! RemoveContactCell
            
            cell.configureWith(delegate: self)
            
            return cell
            
        }
        
    }

}

extension UserViewController: AddCellDelegate, RemoveContactCellDelegate {
    
    func addButtonPressed() {
        
        print("ADD")
    
    }
    
    func removeButtonPressed() {
        
        print("REMOVE")
        
    }
    
}
