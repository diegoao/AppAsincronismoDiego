//
//  LoginView.swift
//  AppAsincronismoDiego
//
//  Created by Macbook Pro on 17/3/24.
//

import Foundation
import UIKit

//MARK: - Generamos la UI por código

class LoginView: UIView {
    
    //Fondo para ello creo una imagen como cuando lo hacemos en el xib y pongo la propiedad AspectFill para que salga centrada
    public let fondoImage = {
        let image = UIImageView(image: UIImage(named: "fondo2"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    
    
    //Logo
    public let logoImage = {
        let image = UIImageView(image: UIImage(named: "title"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    //Usuario
    public let emailTextField =  {
        let textField = UITextField()
        textField.backgroundColor = .yellow.withAlphaComponent(0.9)
        textField.textColor = .red
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.placeholder = NSLocalizedString("Email", comment: "Es el email")
        textField.layer.cornerRadius = 10
        //Sin esta parte no podemos ver el corner radius
        textField.layer.masksToBounds = true
        return textField
    }()
    
    //Password
    public let passwordTextField =  {
        let textField = UITextField()
        textField.backgroundColor = .yellow.withAlphaComponent(0.9)
        textField.textColor = .red
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.placeholder = NSLocalizedString("Password", comment: "Es la contraseña")
        textField.layer.cornerRadius = 10
        //Sin esta parte no podemos ver el corner radius
        textField.layer.masksToBounds = true
        //Para evitar que se vea el password mientras lo escribimos
        textField.isSecureTextEntry = true
        
        return textField
    }()
    
    // Botón
    let buttonLogin = {
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString("Login", comment: "Es el boton"), for: .normal)
        button.backgroundColor = .orange.withAlphaComponent(0.6)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.gray, for: .disabled)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
    
    //MARK: - //añadimos los items de la UI a la view
    func setupViews(){
        
        addSubview(fondoImage)
        addSubview(logoImage)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(buttonLogin)
        
        //Reglas autolayout
        NSLayoutConstraint.activate([
            
            // Fondo
            fondoImage.topAnchor.constraint(equalTo: topAnchor),
            fondoImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            fondoImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            fondoImage.bottomAnchor.constraint(equalTo: bottomAnchor),

            // Logo
            logoImage.topAnchor.constraint(equalTo: topAnchor, constant: 120),
            logoImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            logoImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            logoImage.heightAnchor.constraint(equalToConstant: 70),

            // Email
            emailTextField.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 100),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),

            // Password
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 40),
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),


            // Botón
            buttonLogin.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 60),
            buttonLogin.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            buttonLogin.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            buttonLogin.heightAnchor.constraint(equalToConstant: 50),
        
        ])
        
    }
    
    //MARK: - Creo funciones para devolver los objetos al ViewController
    func getFondoImageView() -> UIImageView {
        fondoImage
    }
    
    func getLogoImageView() -> UIImageView {
        logoImage
    }
    
    func getEmailView() -> UITextField {
        emailTextField
    }
    
    func getPasswordView() -> UITextField {
        passwordTextField
    }

    func getButtonLoginView() -> UIButton {
        buttonLogin
    }
      
    
}
