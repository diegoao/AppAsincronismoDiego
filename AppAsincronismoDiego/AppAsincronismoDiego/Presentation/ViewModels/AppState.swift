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
    case notValidate
}


//viewModel
final class AppState {
    
    //Estado del login
    @Published var statusLogin: LoginStatus = .none
    
    private var loginUseCase: LoginUseCaseProtocol
    init(loginUseCase: LoginUseCaseProtocol = LoginUseCase()) {
        self.loginUseCase = loginUseCase
    }
    
    //Función de login
    func loginApp(user: String, password: String){
        Task{
            if (await loginUseCase.loginApp(user: user, password: password)){
                //login correcto
                self.statusLogin = .success
            }else{
                //login error
                self.statusLogin = .error
            }
        }
    }
    
    //Evaluo AutoLogin
    func validateControlLogin(){
        Task{
            if (await loginUseCase.validateToken()){
                //Está logeado ya
                self.statusLogin = .success
            }else{
                //Token no validado
                self.statusLogin = .notValidate
            }
        }
    }
    
    func closeSession() {
        Task {
            await loginUseCase.logout()
            //Nos movemos al login
            self.statusLogin = .none
        }
    }


}
