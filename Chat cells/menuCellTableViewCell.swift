//
//  menuCellTableViewCell.swift
//  AirFix
//
//  Created by Ahmad Mustafa on 5/28/19.
//  Copyright © 2019 Pixel. All rights reserved.
//

import UIKit

class menuCellTableViewCell: UITableViewCell {

        @IBOutlet weak var brandImage: UIImageView!
        @IBOutlet weak var brandTitle: UILabel!
        
        func brandView(brand : menu){
            brandImage.image = UIImage(named: brand.image)
            brandTitle.text = brand.title
    }
        
}
