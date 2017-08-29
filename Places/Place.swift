//
//  Place.swift
//  Places
//
//  Created by Jorge Eduardo on 25/08/17.
//  Copyright © 2017 Jorge Eduardo. All rights reserved.
//

import Foundation
import UIKit

class Place {
    
    var name : String = ""
    var type : String = ""
    var location : String = ""
    var image : UIImage!
    var phone : String = ""
    var website : String = ""
    var rating : String!

    
    init(name : String, type: String, location: String, phone : String, website : String, image: UIImage){
        self.name = name
        self.type = type
        self.location = location
        self.image = image
        self.phone = phone
        self.website = website
    }
    
    var description : String{
        return "\(name)\n\(type)\n\(location)\n\(phone)\n\(website)\n\(rating)"
    }
    
}
