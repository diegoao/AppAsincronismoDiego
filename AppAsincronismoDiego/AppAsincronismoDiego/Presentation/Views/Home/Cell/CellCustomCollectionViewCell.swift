//
//  CellCustomCollectionViewCell.swift
//  AppAsincronismoDiego
//
//  Created by Macbook Pro on 21/3/24.
//

import UIKit

class CellCustomCollectionViewCell: UICollectionViewCell {

  
   
    
    @IBOutlet weak var nameHero: UILabel!
    @IBOutlet weak var photo: UIImageView!
    
    override func awakeFromNib() {
        // Configurar el borde de la celda
        layer.borderWidth = 1
        layer.borderColor = UIColor.orange.cgColor
        layer.cornerRadius = 8
        clipsToBounds = true
        super.awakeFromNib()
        var reuseIdentifier: String {
                return String(describing:self)
            }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameHero.text = nil
    }
    
    //MARK: - Methods
    func configure(heroes: HerosModel) {
        nameHero.text = heroes.name
        photo.loadImageRemote(url: URL(string: heroes.photo)!)
}


}
