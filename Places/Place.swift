//
//  Place.swift
//  Places
//
//  Created by Jorge Eduardo on 25/08/17.
//  Copyright © 2017 Jorge Eduardo. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Place : NSManagedObject{
    
    @NSManaged var name : String!
    @NSManaged var type : String!
    @NSManaged var location : String!
    @NSManaged var image : NSData?
    @NSManaged var phone : String?
    @NSManaged var website : String?
    @NSManaged var rating : String?

    
    /*init(name : String, type: String, location: String, phone : String, website : String, image: UIImage){
        self.name = name
        self.type = type
        self.location = location
        //self.image = image
        self.phone = phone
        self.website = website
    }*/
    
    override var description : String{
        
        return ("\(name)\n\(type)\n\(location)\n\(String(describing: phone))\n\(String(describing: website))\n\(String(describing: rating))")
    }
    
}
