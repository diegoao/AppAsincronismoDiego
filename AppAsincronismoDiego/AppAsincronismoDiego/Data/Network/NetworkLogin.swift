//
//  NetworkLogin.swift
//  AppAsincronismoDiego
//
//  Created by Macbook Pro on 17/3/24.
//

import Foundation

protocol NetworkLoginProtocol {
    func loginApp(user: String, password: String) async -> String
}


final class NetworkLogin: NetworkLoginProtocol {
    func loginApp(user: String, password: String) async -> String {
        var tokenJWT: String = ""
        var sefCredential: String = ""
        
        let urlString = "\(ConstantsApp.URL_API)\(Endpoints.login.rawValue)"
        let encondeCredentials = "\(user):\(password)".data(using: .utf8)?.base64EncodedString()
        
        if let credential = encondeCredentials {
            sefCredential = "Basic \(credential)"
        }
        
        //MARK: - Creamos la request
        var request : URLRequest = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = HTTPMethods.post
        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type")
        request.addValue(sefCredential, forHTTPHeaderField: "Authorization")
        
        // Llamamos al server
        
        do{
            let(data, response) = try await URLSession.shared.data(for: request)
            
            if let resp = response as? HTTPURLResponse{
                if resp.statusCode == HTTPResponseCodes.SUCESS{
                    tokenJWT = String(decoding: data, as: UTF8.self)
                }
            }
            
        }catch{
            tokenJWT = ""
            
        }
        return tokenJWT
    
    }
   
}


final class NetworkLoginFake: NetworkLoginProtocol {
    func loginApp(user: String, password: String) async -> String {
        UUID().uuidString
    }
}
