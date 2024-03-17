//
//  LoginViewController.swift
//  AppAsincronismoDiego
//
//  Created by Macbook Pro on 17/3/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: - Creo los objetos para la UI
    var fondo: UIImageView?
    var logo: UIImageView?
    var loginButton: UIButton?
    var emailTextField: UITextField?
    var passwordTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

