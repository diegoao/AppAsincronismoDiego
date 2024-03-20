//
//  TransforViewModel.swift
//  AppAsincronismoDiego
//
//  Created by Macbook Pro on 20/3/24.
//

import Foundation
import Combine

final class TransforViewModel: ObservableObject{
    @Published var transforData = [TransformationModel]()
    
    var data = UUID()
    
    private var userCaseTranfor : TransforUseCaseProtocol
    
    init(userCaseTranfor: TransforUseCaseProtocol = TransforUseCase(), data: UUID) {
        self.userCaseTranfor = userCaseTranfor
        self.data = data
        Task(priority: .medium){
            await getTransformation()
        }
    }
    func getTransformation() async {
        let data = await userCaseTranfor.getTransfor(filter: data)
        
        DispatchQueue.main.async {
            self.transforData = data
        }
    }
}

    
