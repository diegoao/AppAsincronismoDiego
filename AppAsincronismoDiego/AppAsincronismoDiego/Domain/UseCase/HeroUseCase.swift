//
//  HeroUseCase.swift
//  AppAsincronismoDiego
//
//  Created by Macbook Pro on 19/3/24.
//

import Foundation


protocol HeroUseCaseProtocol {
    var repo: HerosRepositoryProtocol {get set}
    func getHeros(filter: String) async -> [HerosModel]
}




//Real
final class HeroUseCase: HeroUseCaseProtocol{
    var repo: HerosRepositoryProtocol
    init(repo: HerosRepositoryProtocol = HerosRepository(network: NetworkHeros())){
        self.repo = repo
    }
    
    func getHeros(filter: String) async -> [HerosModel] {
        await repo.getHeros(filter: filter)
    }
}

//Fake
final class HeroUseCaseFake: HeroUseCaseProtocol{
    var repo: HerosRepositoryProtocol
    init(repo: HerosRepositoryProtocol = HerosRepository(network: NetworkHerosFake())){
        self.repo = repo
    }
    
    func getHeros(filter: String) async -> [HerosModel] {
        await repo.getHeros(filter: filter)
    }
}
