//
//  HeroTableViewCell.swift
//  AppAsincronismoDiego
//
//  Created by Macbook Pro on 19/3/24.
//

import UIKit

class HeroTableViewCell: UITableViewCell {
    
    @IBOutlet weak var NameHero: UILabel!
    @IBOutlet weak var photo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
