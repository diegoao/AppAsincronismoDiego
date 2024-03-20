//
//  TransforRepository.swift
//  AppAsincronismoDiego
//
//  Created by Macbook Pro on 20/3/24.
//

import Foundation

// Caso Real
final class TransforRepository: TransforRepositoryProtocol {
    private var Network: NetworkTransforProtocol
    
    init(network: NetworkTransforProtocol = NetworkTransfor()){
        Network = network
    }
    
    func getTransfor(filter: UUID) async -> [TransformationModel] {
        return await Network.getTransfor(filter: filter)
    }
}


// Caso Fake
final class TransforRepositoryFake: TransforRepositoryProtocol {
    private var Network: NetworkTransforProtocol
    
    init(network: NetworkTransforProtocol = NetworkTransforFake()){
        Network = network
    }
    
    func getTransfor(filter: UUID) async -> [TransformationModel] {
        return await Network.getTransfor(filter: filter)
    }
}
