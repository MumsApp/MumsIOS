import UIKit

protocol MenuDelegate: class {
    
    func lobbyButtonPressed()
    func profileButtonPressed()
    func chatButtonPressed()
    func shopButtonPressed()
    func offersButtonPressed()
    func servicesButtonPressed()
    func schoolsButtonPressed()
    
}

struct Menu {
    var image: UIImage!
    var title: String!
    var tag: Int!
}

class MenuViewController: UIViewController {
  
    @IBOutlet weak var collectionView: UICollectionView!

    fileprivate weak var delegate: MenuDelegate?
    
    fileprivate var menuItems: Array<Menu> = []

    func configureWith(delegate: MenuDelegate?) {
        
        self.delegate = delegate
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureView()
        
        self.configureLayout()
        
        self.configureMenu()
        
    }
    
    private func configureView() {
        
        self.collectionView.backgroundColor = .backgroundWhite
        
        self.collectionView.delegate = self
        
        self.collectionView.dataSource = self
        
        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom:
            80, right: 0)
        
        self.collectionView.register(MenuCell.self, type: .cell)
        
    }
    
    private func configureLayout() {
        
        let screenWidth = UIScreen.main.bounds.width
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: 50, left: 50, bottom: 30, right: 50)
        
        layout.itemSize = CGSize(width: screenWidth/2 - 80, height: 168)
        
        layout.minimumInteritemSpacing = 0
        
        layout.minimumLineSpacing = 0
        
        self.collectionView.collectionViewLayout = layout
        
    }
    
    private func configureMenu() {
        
        self.menuItems.append(Menu(image: #imageLiteral(resourceName: "meIcon"), title: "ME", tag: 0))
        self.menuItems.append(Menu(image: #imageLiteral(resourceName: "lobbyIcon"), title: "LOBBY", tag: 1))
        self.menuItems.append(Menu(image: #imageLiteral(resourceName: "chatIcon"), title: "LET'S TALK", tag: 2))
        self.menuItems.append(Menu(image: #imageLiteral(resourceName: "shopIcon"), title: "SHOP", tag: 3))
        self.menuItems.append(Menu(image: #imageLiteral(resourceName: "offersIcon"), title: "MUMSAPP OFFERS", tag: 4))
        self.menuItems.append(Menu(image: #imageLiteral(resourceName: "mumsHealthIcon"), title: "HEALTH", tag: 5))
        self.menuItems.append(Menu(image: #imageLiteral(resourceName: "holidayIcon"), title: "HOLIDAY", tag: 6))
        self.menuItems.append(Menu(image: #imageLiteral(resourceName: "holidayIcon"), title: "ADD TO MENU", tag: 7))

    }
    
    @IBAction func profileButtonPressed(_ sender: UIButton) {
   
        self.delegate?.profileButtonPressed()
    
    }
    
    @IBAction func lobbyButtonPressed(_ sender: UIButton) {
    
        self.delegate?.lobbyButtonPressed()
    
    }
    
    @IBAction func chatButtonPressed(_ sender: UIButton) {
    
        self.delegate?.chatButtonPressed()
    
    }
    
    @IBAction func servicesButtonPressed(_ sender: UIButton) {
   
        self.delegate?.servicesButtonPressed()
    
    }
    
    @IBAction func shopButtonPressed(_ sender: UIButton) {
        
        self.delegate?.shopButtonPressed()
        
    }
    
    @IBAction func offersButtonPressed(_ sender: UIButton) {
    
        self.delegate?.offersButtonPressed()
    
    }
    
    @IBAction func schoolsButtonPressed(_ sender: UIButton) {
        
        self.delegate?.schoolsButtonPressed()

    }
    
}

extension MenuViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.menuItems.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let item = self.menuItems[indexPath.row]
        
        switch item.tag {
            
        case 0:
            
            self.delegate?.profileButtonPressed()
            
        case 1:
            
            self.delegate?.lobbyButtonPressed()
            
        case 2:
            
            self.delegate?.chatButtonPressed()
            
        case 3:
            
            self.delegate?.shopButtonPressed()
            
        case 4:
            
            self.delegate?.offersButtonPressed()
            
        case 5:
            
            return
            
        case 6:
            
            return
            
        case 7:
            
            return
            
        case .none, .some(_):
            
            return
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableClass(MenuCell.self, forIndexPath: indexPath, type: .cell)
        
        cell.configureWith(item: self.menuItems[indexPath.row])
        
        return cell
        
    }
    
}
