//
//  UIImageViewExtension.swift
//  AppAsincronismoDiego
//
//  Created by Macbook Pro on 19/3/24.
//

import UIKit

import UIKit

//MARK: - Extensiñon para convertir la url de la imagen en imagen
extension UIImageView {
    func loadImageRemote(url: URL){
        DispatchQueue.global().async {[weak self] in
            if let data = try? Data(contentsOf: url) {
                if let imagen = UIImage(data: data){
                    //todo OK.
                    DispatchQueue.main.async {
                        self?.image = imagen
                    }
                }
            }
        }
    }
}
