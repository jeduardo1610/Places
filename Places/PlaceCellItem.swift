//
//  PlaceCellItem.swift
//  Places
//
//  Created by Jorge Eduardo on 11/08/17.
//  Copyright © 2017 Jorge Eduardo. All rights reserved.
//

import UIKit

class PlaceCellItem: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
