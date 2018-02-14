import Foundation

class ItemLocationView: LocationView {

    override func configureView() {
        super.configureView()
        
        self.showSwitch.isHidden = true
        
        self.editButton.isHidden = true
        
    }
    
}
