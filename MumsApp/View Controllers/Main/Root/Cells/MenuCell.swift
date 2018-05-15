import UIKit

class MenuCell: UICollectionViewCell, Reusable {
    
    @IBOutlet weak var menuIcon: UIImageView!
    
    @IBOutlet weak var menuTitle: UILabel!
    
    override func awakeFromNib() {
        
        self.configureView()
        
    }
    
    private func configureView() {
        
        self.menuIcon.layer.cornerRadius = 10
        
        self.menuIcon.layer.masksToBounds = true
        
        self.menuTitle.font = .menuBold(size: 17)
        
        self.menuTitle.textColor = .mainDarkGrey
        
    }
    
    func configureWith(item: Menu) {
        
        self.menuIcon.image = item.image
        
        self.menuTitle.text = item.title
    
    }
    
}
