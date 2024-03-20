//
//  TransformationModel.swift
//  AppAsincronismoDiego
//
//  Created by Macbook Pro on 20/3/24.
//

import Foundation

struct TransformationModel: Codable, Hashable  {
    let id: UUID
    let name: String
    let description: String
    let photo: String
//    let hero: UUID
    
}

struct TransforModelRequest: Codable {
    let id: UUID
}
