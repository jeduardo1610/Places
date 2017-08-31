//
//  TutorialStep.swift
//  Places
//
//  Created by Jorge Eduardo on 31/08/17.
//  Copyright © 2017 Jorge Eduardo. All rights reserved.
//

import Foundation
import UIKit

class TutorialStep {
    
    var index : Int = 0
    var header = ""
    var content = ""
    var image : UIImage!
    
    init(index : Int, header : String, content: String, image : UIImage){
        self.index = index
        self.header = header
        self.content = content
        self.image = image
        
    }
}
