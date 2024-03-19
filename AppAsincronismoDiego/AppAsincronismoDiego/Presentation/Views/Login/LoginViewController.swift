//
//  LoginViewController.swift
//  AppAsincronismoDiego
//
//  Created by Macbook Pro on 17/3/24.
//

import UIKit
import Combine
import CombineCocoa

class LoginViewController: UIViewController {
    
    //MARK: - Creo los objetos para la UI
    var fondo: UIImageView?
    var logo: UIImageView?
    var loginButton: UIButton?
    var emailTextField: UITextField?
    var passwordTextField: UITextField?
    
    //User and password
    private var usr: String = ""
    private var pass: String = ""
    
    //Combine
    private var suscriptors = Set<AnyCancellable>()
    
    
    
    private  var appState: AppState?
    
    init(appState: AppState){
        self.appState = appState
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindingUI()
      
    }
    
    //Suscriptor
    public func bindingUI(){
        //user(email)
        if let emailTextField = self.emailTextField{
            emailTextField.textPublisher
                .receive(on: DispatchQueue.main)
                .sink { [weak self] data in
                    if let user = data{
                        print(user)
                        self?.usr = user
                    }
                }
                .store(in: &suscriptors)
        }
        
        //Password(password)
        if let passwordTextField = self.passwordTextField{
            passwordTextField.textPublisher
                .receive(on: DispatchQueue.main)
                .sink { [weak self] data in
                    if let password = data{
                        print(password)
                        self?.pass = password
                    }
                }
                .store(in: &suscriptors)
        }
        
        //Button Login
        if let loginButton = self.loginButton {
            loginButton.tapPublisher
                .sink { [weak self] _ in
                    //Call of Login
                    if let user = self?.usr,
                       let password = self?.pass{
        
                    self?.appState?.loginApp(user: user, password: password)
                
                    }
                }
                .store(in: &suscriptors)
        }
        
    }
    
    
    //MARK: - Creo la vista de login
    override func loadView() {
        let loginView = LoginView()
        
        //Objetos de la UI
        fondo = loginView.getFondoImageView()
        logo = loginView.getLogoImageView()
        loginButton = loginView.getButtonLoginView()
        emailTextField = loginView.getEmailView()
        passwordTextField = loginView.getPasswordView()
        
        //Asigno la vista
        view = loginView
        
    }

}

