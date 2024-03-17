//
//  AppState.swift
//  AppAsincronismoDiego
//
//  Created by Macbook Pro on 17/3/24.
//

import Foundation
import Combine

//MARK: - Control del estado de la app
enum LoginStatus {
    case none
    case success
    case error
}


//viewModel
final class AppState {
    
    //Estado del login
    @Published var statusLogin: LoginStatus = .none
    
    //Función de login
    func loginApp(user: String, password: String){
        
    }


}
