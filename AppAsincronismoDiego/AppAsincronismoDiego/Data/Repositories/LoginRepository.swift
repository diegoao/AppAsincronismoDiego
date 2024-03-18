//
//  LoginRepository.swift
//  AppAsincronismoDiego
//
//  Created by Macbook Pro on 18/3/24.
//

import Foundation

// Caso Real
final class DefaultLoginRepository: LoginRepositoryProtocol{
    private var Network: NetworkLoginProtocol
    
    init(Network: NetworkLoginProtocol) {
        self.Network = Network
    }
    
    func loginApp(user: String, password: String) async -> String {
        return await Network.loginApp(user: user, password: password)
    }
}


// Caso Fake
final class DefaultLoginRepositoryFake: LoginRepositoryProtocol{
    private var Network: NetworkLoginProtocol
    
    init(Network: NetworkLoginProtocol = NetworkLoginFake()) {
        self.Network = Network
    }
    
    func loginApp(user: String, password: String) async -> String {
        return await Network.loginApp(user: user, password: password)
    }
}
