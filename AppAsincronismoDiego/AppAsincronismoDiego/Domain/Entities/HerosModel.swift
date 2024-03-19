//
//  HerosModel.swift
//  AppAsincronismoDiego
//
//  Created by Macbook Pro on 19/3/24.
//

import Foundation

struct HerosModel: Codable {
    let id: UUID
    let favorite: Bool
    let description: String
    let photo: String
    let name: String
}


struct HerosModelRequest: Codable {
    let name: String
}
