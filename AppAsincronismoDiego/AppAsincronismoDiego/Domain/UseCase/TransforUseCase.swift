//
//  TransforUseCase.swift
//  AppAsincronismoDiego
//
//  Created by Macbook Pro on 20/3/24.
//

import Foundation

protocol TransforUseCaseProtocol{
    var repo: TransforRepositoryProtocol {get set}
    func getTransfor(filter: UUID) async -> [TransformationModel]
}


// Caso Real

final class TransforUseCase: TransforUseCaseProtocol {
    var repo: TransforRepositoryProtocol
    
    init(repo: TransforRepositoryProtocol = TransforRepository(network: NetworkTransfor())) {
        self.repo = repo
    }
    
    func getTransfor(filter: UUID) async -> [TransformationModel] {
        await repo.getTransfor(filter: filter)
    }
}


// Caso Fake

final class TransforUseCaseFake: TransforUseCaseProtocol {
    var repo: TransforRepositoryProtocol
    
    init(repo: TransforRepositoryProtocol = TransforRepository(network: NetworkTransforFake())) {
        self.repo = repo
    }
    
    func getTransfor(filter: UUID) async -> [TransformationModel] {
        await repo.getTransfor(filter: filter)
    }
}
