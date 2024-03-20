//
//  TransforRepositoryProtocol.swift
//  AppAsincronismoDiego
//
//  Created by Macbook Pro on 20/3/24.
//

import Foundation


protocol TransforRepositoryProtocol {
    
    //Devuelve el id del héroe
    func getTransfor(filter: UUID) async -> [TransformationModel]
}
