import UIKit

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
        
    }
    
    func filterButtonPressed(sender: UIBarButtonItem) {
        
        // Show filters
        
    }
    
}

extension LobbyViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LobbyCell", for: indexPath) as! LobbyCell
        
        cell.configureWith(title: "Expectant Moms", description: "Lorem ipsum dolor sit amet, cons ectetur adipiscing elit. Nulla inter dum libero tortor, quis.")
        
        return cell
        
    }
    
}

extension LobbyViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
    }
    
}
