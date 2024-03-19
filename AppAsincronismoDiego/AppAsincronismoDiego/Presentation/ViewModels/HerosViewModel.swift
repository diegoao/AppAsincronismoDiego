//
//  HerosViewModel.swift
//  AppAsincronismoDiego
//
//  Created by Macbook Pro on 19/3/24.
//

import Foundation
import Combine

//MARK: - Creamos el HerosViewModel
final class HerosViewModel: ObservableObject {
    @Published var herosData = [HerosModel]()
    
    private var userCaseHeros: HeroUseCaseProtocol
    
    init(userCaseHeros: HeroUseCaseProtocol = HeroUseCase()){
        self.userCaseHeros = userCaseHeros
        
        Task(priority: .high ){
            await getHeros()
        }
    }
    
    //MARK: - Cargamos los héroes
    func getHeros() async {
        let data = await userCaseHeros.getHeros(filter: "")
        DispatchQueue.main.async {
            self.herosData = data
        }
    }
}
