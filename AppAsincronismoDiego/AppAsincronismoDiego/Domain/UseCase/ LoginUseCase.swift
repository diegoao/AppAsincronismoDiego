//
//  loginUseCase.swift
//  AppAsincronismoDiego
//
//  Created by Macbook Pro on 17/3/24.
//

import Foundation
import KcLibraryswift


protocol LoginUseCaseProtocol {
    var repo: LoginRepositoryProtocol {get set}
    func loginApp(user: String, password: String) async -> Bool
    func logout() async -> Void
    func validateToken() async -> Bool
}


//MARK: - Implementamos el caso de uso
final class LoginUseCase: LoginUseCaseProtocol {
    
    var repo: LoginRepositoryProtocol
    init(repo: LoginRepositoryProtocol = DefaultLoginRepository(Network: NetworkLogin())) {
        self.repo = repo
    }
    
    func loginApp(user: String, password: String) async -> Bool {
        let token = await repo.loginApp(user: user, password: password)
        //MARK: - Guardamos el token
        if token != "" {
            KeyChainKC().saveKC(key: ConstantsApp.TOKEN_ID_KEYCHAIN, value: token)
            return true
        }else {
            KeyChainKC().deleteKC(key:  ConstantsApp.TOKEN_ID_KEYCHAIN)
            return false
        }
       
    }
    
    // MARK: - Eliminamos el token
    func logout() async {
        KeyChainKC().deleteKC(key:  ConstantsApp.TOKEN_ID_KEYCHAIN)
    }
    
    func validateToken() async -> Bool {
        if KeyChainKC().loadKC(key: ConstantsApp.TOKEN_ID_KEYCHAIN) != "" {
            
            return true
        }else{
            
            return false
        }
    }
}



//MARK: - Implementamos el caso de uso FAKE
final class LoginUseCaseFake: LoginUseCaseProtocol {
    
    var repo: LoginRepositoryProtocol
    init(repo: LoginRepositoryProtocol = DefaultLoginRepositoryFake()) {
        self.repo = repo
    }
    
    func loginApp(user: String, password: String) async -> Bool {
        let token = await repo.loginApp(user: user, password: password)
        //MARK: - Guardamos el token
        if token != "" {
            KeyChainKC().saveKC(key: ConstantsApp.TOKEN_ID_KEYCHAIN, value: token)
            return true
        }else {
            KeyChainKC().deleteKC(key:  ConstantsApp.TOKEN_ID_KEYCHAIN)
            return false
        }
       
    }
    
    // MARK: - Eliminamos el token
    func logout() async {
        KeyChainKC().deleteKC(key:  ConstantsApp.TOKEN_ID_KEYCHAIN)
    }
    
    func validateToken() async -> Bool {
        return true
    }
}
