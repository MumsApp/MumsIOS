import Foundation
import UIKit

struct Lobby {
    
    let image: UIImage
    let title: String
    let description: String
    
}

let lobbyArray = [

    Lobby(image: #imageLiteral(resourceName: "expectantMumsIcon"), title: "Expectant Mums", description: "Whether you are thinking about having your own family or are on the way to the maternity ward, here you will find oodles of advice and support and hopefully lots of new friends sharing the same experience. Please feel free to ask questions along with offering advice."),

    Lobby(image: #imageLiteral(resourceName: "newBornsIcon"), title: "New Borns", description: "So all the waiting is over. The bundle of joy (or maybe joys) has arrived. So what now?? This might be your first or your fifth, but you will find information and helpful advice here from other parents and carers. This section is specifically for parents with new borns."),

    Lobby(image: #imageLiteral(resourceName: "toddlersIcon"), title: "Toddlers", description: "All of a sudden, they have literally found their feet! They are into everything and that stair-gate is worth its weight in gold. This section offers some great advice regarding that brave new world."),

    Lobby(image: #imageLiteral(resourceName: "nurseryIcon"), title: "Nursery", description: "For some it’s a stressful wrench from their little one while for others it’s a welcome break from the demands of parenting. Nursery is the first real step for many little ones towards socialising with a peer group."),

    Lobby(image: #imageLiteral(resourceName: "schoolDaysIcon"), title: "School Days", description: "From that first often tearful morning to that sixth form leaving prom, this stage of parenting can often be the most demanding as well as rewarding."),

    Lobby(image: #imageLiteral(resourceName: "teensIcon"), title: "Teens", description: "So it’s started! Young adults stretching their wings and discovering the world around them. Studying, sports, new interests and then there’s that first boy/girlfriend. You as a parent have a whole new learning curve here. Remember to breathe!"),

    Lobby(image: #imageLiteral(resourceName: "universityIcon"), title: "University", description: "Often the first time they have been away from home, university years are a whole new world not just for your children, but for you as a parent."),

    Lobby(image: #imageLiteral(resourceName: "sameButDifferentIcon"), title: "Same but different", description: " Here we celebrate and acknowledge those who create a place in the world through strength and courage, whilst bringing love and positivity into a family. You know who you are!"),
    
    Lobby(image: #imageLiteral(resourceName: "lgbtIcon"), title: "LGBT parenting", description: "As we all know, oranges are not the only fruit. So MumsApp welcomes conversations from parents of all sexualities and genders."),

     Lobby(image: #imageLiteral(resourceName: "mumsHealthIcon"), title: "MumsApp Health", description: "Lorem ipsum dolor sit amet, cons ectetur adipiscing elit. Nulla inter dum libero tortor, quis."),
     
      Lobby(image: #imageLiteral(resourceName: "holidayIcon"), title: "Holiday", description: "Lorem ipsum dolor sit amet, cons ectetur adipiscing elit. Nulla inter dum libero tortor, quis."),
    
    Lobby(image: #imageLiteral(resourceName: "IVFIcon"), title: "IVF", description: "For many reasons some prospective parents may require In-vitro fertilisation. This is an experience better shared with those who have travelled that often challenging path."),
    
    Lobby(image: #imageLiteral(resourceName: "adoptionIcon"), title: "Adoption", description: "For many reasons adoption is an option would-be parents chose. Here you can discuss issues surrounding this often-challenging yet rewarding route to parenthood.")
    
]
