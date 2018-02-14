import UIKit

class ChatSettingsPopupViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var closeButton: UIButton!
   
    @IBOutlet weak var containerBottomView: UIView!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureView()
     
        self.registerCells()
        
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.containerView.layer.cornerRadius = 4
        
        self.containerView.backgroundColor = .white
        
        self.containerBottomView.backgroundColor = .containerGreyColor
        
        self.containerBottomView.roundCorners(corners: [.bottomLeft, .bottomRight], withRadius: 4)
    
    }
    
    private func configureView() {
        
        self.tableView.delegate = self
        
        self.tableView.dataSource = self
        
        self.titleLabel.font = .regular(size: 20)
        
        self.descriptionLabel.font = .regular(size: 13)
        
        self.descriptionLabel.textColor = .mainDarkGrey
        
    }
    
    private func registerCells() {
        
        self.tableView.registerNib(ChatSettingsCell.self)
    
    }
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
    
        self.dismissViewController()
        
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
    
        self.dismissViewController()
    
    }
    
}

extension ChatSettingsPopupViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(ChatSettingsCell.self, indexPath: indexPath)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableCell(ChatSettingsCell.self)
        
        cell.configureForHeader()
        
        return cell
    }
    
}
