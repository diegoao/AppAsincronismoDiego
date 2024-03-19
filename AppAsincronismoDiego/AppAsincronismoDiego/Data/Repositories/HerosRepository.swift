//
//  HerosRepository.swift
//  AppAsincronismoDiego
//
//  Created by Macbook Pro on 19/3/24.
//

import Foundation

// Caso Real
final class HerosRepository: HerosRepositoryProtocol {
    private var Network: NetworkHerosProtocol
    
    init(network: NetworkHerosProtocol = NetworkHeros()){
        Network = network
    }
    
    func getHeros(filter: String) async -> [HerosModel] {
        return await Network.getHeros(filter: filter)
    }
}


// Caso Fake
final class HerosRepositoryFake: HerosRepositoryProtocol {
    private var Network: NetworkHerosProtocol
    
    init(network: NetworkHerosProtocol = NetworkHerosFake()){
        Network = network
    }
    
    func getHeros(filter: String) async -> [HerosModel] {
        return await Network.getHeros(filter: filter)
    }
}
