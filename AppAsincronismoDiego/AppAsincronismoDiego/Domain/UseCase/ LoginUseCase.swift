//
//  loginUseCase.swift
//  AppAsincronismoDiego
//
//  Created by Macbook Pro on 17/3/24.
//

import Foundation

protocol LoginUseCaseProtocol {
    var repo: LoginRepositoryProtocol {get set}
    func loginApp(user: String, password: String) async -> Bool
    func logout() async -> Void
    func validateToken() async -> Bool
}


//MARK: - Implementamos el caso de uso
//final class LoginUseCase: LoginUseCaseProtocol {
//    
//    var repo: LoginRepositoryProtocol
//    
//    func loginApp(user: String, password: String) async -> Bool {
//        return true
//    }
//    
//    func logout() async {
//        //logout
//    }
//    
//    func validateToken() async -> Bool {
//        return true
//    }
//    
//    
//    
//    
//    
//}
