//
//  TransforTableViewCell.swift
//  AppAsincronismoDiego
//
//  Created by Macbook Pro on 20/3/24.
//

import UIKit

class TransforTableViewCell: UITableViewCell {
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var nameTranformation: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}