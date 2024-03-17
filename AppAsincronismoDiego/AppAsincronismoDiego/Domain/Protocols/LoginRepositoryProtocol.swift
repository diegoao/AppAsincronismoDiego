//
//  LoginRepositoryProtocol.swift
//  AppAsincronismoDiego
//
//  Created by Macbook Pro on 17/3/24.
//

import Foundation

protocol LoginRepositoryProtocol {
    
    //Devuelve el token
    func loginApp(user: String, password: String) async -> String
}


