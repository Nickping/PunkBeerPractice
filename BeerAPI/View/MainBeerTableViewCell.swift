//
//  MainBeerTableViewCell.swift
//  BeerAPI
//
//  Created by Euijoon Jung on 16/11/2019.
//  Copyright © 2019 Euijoon Jung. All rights reserved.
//

import UIKit

class MainBeerTableViewCell: UITableViewCell {
    @IBOutlet weak var beerImage: UIImageView!
    @IBOutlet weak var beerName: UILabel!
    
    @IBOutlet weak var beerDescription: UILabel!
    static let cellId = "mainBeerTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        beerImage.contentMode = .scaleAspectFit
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
