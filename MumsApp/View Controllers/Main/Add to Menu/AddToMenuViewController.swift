import UIKit

class AddToMenuViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    fileprivate var filteredLobbyRooms: Array<LobbyRoom> = []

    fileprivate var lobbyRooms: Array<LobbyRoom> = []

    private var lobbyService: LobbyService!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureView()
        
        self.registerCells()
        
        self.configureNavigationBar()
        
        self.getLobbyRooms()

    }
    
    private func configureView() {
        
        self.view.setBackground()
        
        self.tableView.backgroundColor = .clear
        
        self.tableView.delegate = self
        
        self.tableView.dataSource = self
        
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom:
            80, right: 0)
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.tableView.estimatedRowHeight = 180
        
        
        self.searchBar.delegate = self
        
    }
    
    private func configureNavigationBar() {
        
        let titleLabel = self.navigationController?.configureNavigationBarWithTitle(title: "Add To Menu")
        
        self.navigationItem.titleView = titleLabel
        
        self.navigationItem.hidesBackButton = true
        
    }
    
    private func registerCells() {
        
        self.tableView.registerNib(AddToMenuCell.self)
        
    }
    
    fileprivate func getLobbyRooms() {
        
        guard let token = self.appContext.token() else { return }
        
        self.progressHUD.showLoading()
        
        self.lobbyService.getLobbyRooms(token: token) { dataOptional, errorOptional in
            
            self.progressHUD.dismiss()
            
            if let error = errorOptional {
                
                self.showOkAlertWith(title: "Error", message: error.localizedDescription)
                
            } else {
                
                if let dictionary = dataOptional as? Dictionary<String, Any> {
                    
                    if let data = dictionary[k_data] as? Array<Dictionary<String, Any>> {
                        
                        self.lobbyRooms = []
                        
                        self.filteredLobbyRooms = []
                        
                        for d in data {
                            
                            self.lobbyRooms.append(LobbyRoom(dictionary: d))
                            
                        }
                        
                        self.lobbyRooms.sort (by: { $0.isFavourite! && !$1.isFavourite! })
                        
                        self.tableView.reloadData()
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    func searchLobbyRooms(searchTerm: String) {
        
        guard let token = self.appContext.token() else { return }
        
        self.lobbyService.searchLobbyRoomsWithPagination(token: token, searchTerm: searchTerm, page: 1) { dataOptional, errorOptional in
            
            if let error = errorOptional {
                
                self.showOkAlertWith(title: "Error", message: error.localizedDescription)
                
            } else {
                
                if let dictionary = dataOptional as? Dictionary<String, Any> {
                    
                    if let data = dictionary[k_data] as? Array<Dictionary<String, Any>> {
                        
                        self.lobbyRooms = []
                        
                        self.filteredLobbyRooms = []
                        
                        for d in data {
                            
                            self.filteredLobbyRooms.append(LobbyRoom(dictionary: d))
                            
                        }
                        
                        self.filteredLobbyRooms.sort (by: { $0.isFavourite! && !$1.isFavourite! })
                        
                        self.tableView.reloadData()
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    func isFiltering() -> Bool {
        
        return self.searchBar.text == "" ? false : true
        
    }
    
}

extension AddToMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.isFiltering() {
            
            return self.filteredLobbyRooms.count
            
        } else {
            
            return self.lobbyRooms.count
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(AddToMenuCell.self, indexPath: indexPath)
        
        let thisObject: LobbyRoom!
        
        if self.isFiltering() && self.filteredLobbyRooms.count != 0 {
            
            thisObject = self.filteredLobbyRooms[indexPath.row]
            
        } else {
            
            thisObject = self.lobbyRooms[indexPath.row]
            
        }
        
        cell.configureWith(lobby: thisObject, delegate: self)
        
        return cell
        
    }
    
}

extension AddToMenuViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText != "" {
            
            self.searchLobbyRooms(searchTerm: searchText)
            
        } else {
            
            self.getLobbyRooms()
            
        }
        
    }
    
}

extension AddToMenuViewController: AddToMenuCellDelegate {
    
    func addToMenu() {
    
        print("Add to menu")
        
    }
    
}
