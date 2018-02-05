import UIKit
import SwipeCellKit

class LobbyViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
   
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureView()
        
        self.registerCells()

        self.configureNavigationBar()
        
    }

    private func configureView() {
        
        self.view.backgroundColor = .backgroundWhite

        self.tableView.backgroundColor = .backgroundWhite

        self.tableView.delegate = self
        
        self.tableView.dataSource = self
        
        self.searchBar.delegate = self
        
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)
        
    }
    
    private func configureNavigationBar() {
        
        let titleLabel = self.navigationController?.configureNavigationBarWithTitle(title: "The Lobby")
        
        self.navigationItem.titleView = titleLabel
        
        self.navigationItem.hidesBackButton = true
        
        let rightButton = UIBarButtonItem(image: #imageLiteral(resourceName: "filterIcon"), style: .plain, target: self, action: #selector(self.filterButtonPressed(sender:)))
        
        self.navigationItem.rightBarButtonItem = rightButton
        
    }
    
    private func registerCells() {
        
        let nib = UINib(nibName: "LobbyCell", bundle: nil)
        
        self.tableView.register(nib, forCellReuseIdentifier: "LobbyCell")

        let nibFooter = UINib(nibName: "LobbyFooterCell", bundle: nil)
        
        self.tableView.register(nibFooter, forCellReuseIdentifier: "LobbyFooterCell")

    }
    
    func filterButtonPressed(sender: UIBarButtonItem) {
        
        // Show filters
        
    }
    
}

extension LobbyViewController: UITableViewDelegate, UITableViewDataSource, SwipeTableViewCellDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            
            return 5
            
        } else {
            
            return 1
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            
            return 180
            
        } else {
            
            return 60
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
         
            let cell = tableView.dequeueReusableCell(withIdentifier: "LobbyCell", for: indexPath) as! LobbyCell
            
            cell.configureWith(title: "Expectant Moms", description: "Lorem ipsum dolor sit amet, cons ectetur adipiscing elit. Nulla inter dum libero tortor, quis.")
            
            cell.delegate = self
            
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "LobbyFooterCell", for: indexPath) as! LobbyFooterCell
            
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: nil) { action, indexPath in

            print("Delete")
            
        }
        
        deleteAction.backgroundColor = .clear
        
        deleteAction.image = #imageLiteral(resourceName: "deleteIcon")
        
        return [deleteAction]
    
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        
        var options = SwipeTableOptions()
    
        options.backgroundColor = .clear
        
//        options.expansionStyle = .destructive
        
//        options.transitionStyle = .border
        
        return options
    
    }
    
}

extension LobbyViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
    }
    
}
