//
//  HerosModelProtocol.swift
//  AppAsincronismoDiego
//
//  Created by Macbook Pro on 19/3/24.
//

import Foundation


protocol HerosRepositoryProtocol {
    
    //Devuelve el token
    func getHeros(filter: String) async -> [HerosModel]
}
