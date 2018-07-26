import UIKit
import SwipeCellKit

protocol ReloadDelegate: class {
    
    func reloadData()
    
}

class LobbyViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
   
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var emptyLabel: UILabel!
    
    fileprivate var lobbyRooms: Array<LobbyRoom> = []

    fileprivate var filteredLobbyRooms: Array<LobbyRoom> = []
    
    private var lobbyService: LobbyService!
    
    fileprivate var imageLoader: ImageCacheLoader!
    
    func configureWith(lobbyService: LobbyService, imageLoader: ImageCacheLoader) {
        
        self.lobbyService = lobbyService
        
        self.imageLoader = imageLoader
        
    }
    
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
        
        let titleLabel = self.navigationController?.configureNavigationBarWithTitle(title: "The Lobby")
        
        self.navigationItem.titleView = titleLabel
        
        self.navigationItem.hidesBackButton = true
        
        
    }
    
    private func registerCells() {

        self.tableView.registerNib(LobbyCell.self)
        
        self.tableView.registerNib(AddCell.self)
    
    }

    fileprivate func getLobbyRooms() {
        
        guard let token = self.appContext.token() else { return }
        
        self.lobbyService.getLobbyRoomsWithPagination(token: token, page: 1) { dataOptional, errorOptional in
        
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
    
    func addFavouriteLobbyRoom(id: String) {
        
        guard let token = self.appContext.token() else { return }

        self.lobbyService.addFavouriteLobbyRoom(lobbyId: id, token: token) { errorOptional in
            
            if let error = errorOptional {
                
                print(error.localizedDescription)
                
            } else {
                
                
            }
            
        }
        
    }
    
    func removeFavouriteLobbyRoom(id: String) {
        
        guard let token = self.appContext.token() else { return }
        
        self.lobbyService.removeFavouriteLobbyRoom(lobbyId: id, token: token) { errorOptional in
            
            if let error = errorOptional {
                
                print(error.localizedDescription)
                
            } else {
                
                
            }
            
        }
        
    }
    
    func deleteLobbyRoom(id: String) {
        
        guard let token = self.appContext.token() else { return }

        self.lobbyService.deleteLobbyRoom(lobbyId: id, token: token) { errorOptional in
            
            if let error = errorOptional {
                
                print(error.localizedDescription)
                
            } else {
                
                
                
            }
            
        }
        
    }
    
    func isFiltering() -> Bool {
    
        return self.searchBar.text == "" ? false : true
    
    }
    
}

extension LobbyViewController: UITableViewDelegate, UITableViewDataSource, SwipeTableViewCellDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            
            if self.isFiltering() {
                
                return self.filteredLobbyRooms.count

            } else {
                
                return self.lobbyRooms.count

            }
            
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
         
            let cell = tableView.dequeueReusableCell(LobbyCell.self, indexPath: indexPath)
            
            let thisObject: LobbyRoom!
                
            if self.isFiltering() {
                
                thisObject = self.filteredLobbyRooms[indexPath.row]
                
            } else {
                
                thisObject = self.lobbyRooms[indexPath.row]
                
            }
            
            cell.configureWith(lobby: thisObject, lobbyDelegate: self)
            
            cell.delegate = self
            
            self.imageLoader.obtainImageWithPath(imagePath: BASE_PUBLIC_IMAGE_URL + thisObject.img!) { (image) in
                
                if let _ = tableView.cellForRow(at: indexPath) {
                
                    cell.lobbyImageView.image = image
            
                }
            
            }

            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(AddCell.self, indexPath: indexPath)
            
            cell.configureWith(buttonTitle: "Add category", delegate: self)
            
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: nil) { action, indexPath in

            if let id = self.lobbyRooms[indexPath.row].id {
                
                self.deleteLobbyRoom(id: String(id))

            }

        }
        
        deleteAction.backgroundColor = .clear
        
        deleteAction.image = #imageLiteral(resourceName: "deleteIcon")
        
        if self.isFiltering() {

            return []
            
        } else {
            
            return [deleteAction]

        }
    
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        
        var options = SwipeTableOptions()
    
        options.backgroundColor = .clear
        
        return options
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let thisObject: LobbyRoom!
            
        if self.isFiltering() {
            
            thisObject = self.filteredLobbyRooms[indexPath.row]
            
        } else  {
            
            thisObject = self.lobbyRooms[indexPath.row]
            
        }
        
        self.showLobbyDetailsViewController(roomId: String(thisObject.id!), title: thisObject.title!)
        
    }
    
    private func showLobbyDetailsViewController(roomId: String, title: String) {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.lobbyDetailsViewController(roomId: roomId, title: title, backButton: true)
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
}

extension LobbyViewController: UISearchBarDelegate {
    
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

extension LobbyViewController: AddCellDelegate {
    
    func addButtonPressed() {
        
        self.showCreateCategoryViewController()
        
    }
    
    private func showCreateCategoryViewController() {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.createCategoryViewController(reloadDelegate: self)
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
}

extension LobbyViewController: LobbyCellDelegate {
    
    func setFavourite(_ on: Bool, lobbyId: String) {
        
        if on {
            
            self.addFavouriteLobbyRoom(id: lobbyId)
            
        } else {
            
            self.removeFavouriteLobbyRoom(id: lobbyId)
            
        }
        
    }
    
}

extension LobbyViewController: ReloadDelegate {
    
    func reloadData() {
        
        self.getLobbyRooms()
        
    }
    
}
