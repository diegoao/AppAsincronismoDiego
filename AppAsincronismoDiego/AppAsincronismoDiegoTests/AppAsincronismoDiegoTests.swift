//
//  AppAsincronismoDiegoTests.swift
//  AppAsincronismoDiegoTests
//
//  Created by Macbook Pro on 17/3/24.
//

import XCTest
@testable import AppAsincronismoDiego
import Combine
import CombineCocoa
import UIKit
import KcLibraryswift

//MARK: - Creamos testing de la app
final class AppAsincronismoDiegoTests: XCTestCase {
    
    
    
    //MARK: - Testing de login
    
    func testKeyChainLibrary() throws {
        let kc = KeyChainKC()
        XCTAssertNotNil(kc)
        //Guardo un dato
        let save = kc.saveKC(key: "nombre", value:  "Diego" )
        XCTAssertEqual(save, true)
        //Leo un dato
        let value = kc.loadKC(key: "nombre")
        if let value1 = value {
            XCTAssertEqual(value1, "Diego")
        }
        //Elimino un dato
        XCTAssertNoThrow(kc.deleteKC(key: "nombre"))
    }
    
    func testNetworkLogin() async throws {
        let obj1 = NetworkLogin()
        XCTAssertNotNil(obj1)
        let obj2 = NetworkLoginFake()
        XCTAssertNotNil(obj2)
        
        let tokenFake = await obj2.loginApp(user: "die", password: "123")
        XCTAssertNotEqual(tokenFake,"")
        
        let token = await obj1.loginApp(user: "die", password: "234")
        XCTAssertEqual(token, "")
    }
    
    func testLoginFake() async throws {
        let KC = KeyChainKC()
        XCTAssertNotNil(KC)
        
        let obj = LoginUseCaseFake()
        XCTAssertNotNil(obj)
        
        //validamos el token
        let resp = await obj.validateToken()
        XCTAssertEqual(resp, true)
        
        //login
        let login = await obj.loginApp(user: "", password: "")
        XCTAssertEqual(login, true)
        
        var jwt = KC.loadKC(key: ConstantsApp.TOKEN_ID_KEYCHAIN)
        XCTAssertNotEqual(jwt, "")
        
        //close session y verificamos que la cadena está vacia
        await obj.logout()
        jwt = KC.loadKC(key: ConstantsApp.TOKEN_ID_KEYCHAIN)
        XCTAssertEqual(jwt, "")
    }
    
    func testRealLogin() async throws {
        //Instanciamos el keychain
        let KC = KeyChainKC()
        XCTAssertNotNil(KC)
        
        KC.saveKC(key: ConstantsApp.TOKEN_ID_KEYCHAIN, value: "")
        
        //Caso de uso con repo Fke
        let userCase = LoginUseCase(repo: DefaultLoginRepositoryFake())
        XCTAssertNotNil(userCase)
        
        //validamos el token
        let resp = await userCase.validateToken()
        XCTAssertEqual(resp, false)
        
        //login
        let login = await userCase.loginApp(user: "", password: "")
        XCTAssertEqual(login, true)
        
        var jwt = KC.loadKC(key: ConstantsApp.TOKEN_ID_KEYCHAIN)
        XCTAssertNotEqual(jwt, "")
        
        //cerramos sesion y verificamos que la cadena está vacia
        await userCase.logout()
        jwt = KC.loadKC(key: ConstantsApp.TOKEN_ID_KEYCHAIN)
        XCTAssertEqual(jwt, "")
    
    }
    
    func testUIErrorView() async throws {
        let appStateVM = AppState(loginUseCase: LoginUseCaseFake())
        appStateVM.statusLogin = .error
        let vc = await ErrorViewController(appState: appStateVM, error: "Error")
        XCTAssertNotNil(vc)
    }
    
    func testUILoginView() throws {
        XCTAssertNoThrow(LoginView())
        let view = LoginView()
        XCTAssertNotNil(view)
        
        let logo = view.getLogoImageView()
        XCTAssertNotNil(logo)
        
        let txtUser = view.getEmailView()
        XCTAssertNotNil(txtUser)
        XCTAssertEqual(txtUser.placeholder, "Email")
        
        let txtPassword = view.getPasswordView()
        XCTAssertNotNil(txtPassword)
        XCTAssertEqual(txtPassword.placeholder, "Password")
        
        let view2 = LoginViewController(appState: AppState(loginUseCase: LoginUseCaseFake()))
        XCTAssertNoThrow(view2.bindingUI())

    }
    
    
    
    
    //MARK: - Testing de Heros
    
    //Compruebo que haya héroes en el HeroUseCaseFake
    func testHeroViewModel() async throws {
        let vm = HerosViewModel(userCaseHeros: HeroUseCaseFake())
        XCTAssertNotNil(vm)
        
    }
   
    func testHeroUseCase() async throws {
        //Compruebo que no me devuelva nil
        let usecase = HeroUseCase(repo: HerosRepositoryFake())
        XCTAssertNotNil(usecase)
        
        //Compruebo que tenga dos datos el repositorio fake
        let data = await usecase.getHeros(filter: "")
        XCTAssertEqual(data.count, 2)
    }
    
    func testHerosCombine() async throws {
        var suscriptor = Set<AnyCancellable>()
        
        let exp = self.expectation(description: "Heros get")
        let vm = HerosViewModel(userCaseHeros: HeroUseCaseFake())
        XCTAssertNotNil(vm)
        
        vm.$herosData
            .sink { completion in
                switch completion{
                case .finished:
                    print("Finalizado")
                }
            } receiveValue: { data in
                if data.count == 2 {
                    exp.fulfill()
                }
            }
            .store(in: &suscriptor)
        await self.waitForExpectations(timeout: 15)
    }
    
    func testHeros_Data() async throws {
        let network = NetworkHerosFake()
        XCTAssertNotNil(network)
       
        let repo = HerosRepository(network: network)
        XCTAssertNotNil(repo)
        
        let repo2 = HerosRepositoryFake()
        XCTAssertNotNil(repo2)
        
        
        let data = await repo.getHeros(filter: "")
        XCTAssertNotNil(data)
        XCTAssertEqual(data.count, 2)
        
        let data2 = await repo2.getHeros(filter: "")
        XCTAssertNotNil(data2)
        XCTAssertEqual(data2.count, 2)
        
        
    }
    
    
    func testHeros_Domain() async throws {
        let model = HerosModel(id: UUID(), favorite: true, description: "", photo: "", name: "goku")
        XCTAssertNotNil(model)
        
        XCTAssertEqual(model.name, "goku")
        XCTAssertEqual(model.favorite, true)
        
    }
    
    func testHeros_Presentation() async throws {
        let viewModel = HerosViewModel(userCaseHeros: HeroUseCaseFake())
        XCTAssertNotNil(viewModel)
        
        let view = await HeroViewController(appState: AppState(loginUseCase: LoginUseCaseFake()), viewModel: viewModel)
        XCTAssertNotNil(view)
    }
    
    
    
    //MARK: - Testing de transformaciones
    
    //Compruebo que el vm no esté vacio
    func testTransforViewModel() async throws {
        let vm = TransforViewModel(userCaseTranfor: TransforUseCaseFake(), data: UUID(uuidString: "17824501-1106-4815-BC7A-BFDCCEE43CC9")!)
        XCTAssertNotNil(vm)
        
    }
   
    func testTransforUseCase() async throws {
        //Compruebo que no me devuelva nil
        let usecase = TransforUseCase(repo: TransforRepositoryFake())
        XCTAssertNotNil(usecase)
        
        //Compruebo que tenga un dato el repositorio fake
        let data = await usecase.getTransfor(filter: UUID())
        XCTAssertEqual(data.count, 1)
    }
    
    func testTransforCombine() async throws {
        var suscriptor = Set<AnyCancellable>()
        
        let exp = self.expectation(description: "Transfor get")
        let vm = TransforViewModel(userCaseTranfor: TransforUseCaseFake(), data: UUID())
        XCTAssertNotNil(vm)
        
        vm.$transforData
            .sink { completion in
                switch completion{
                case .finished:
                    print("Finalizado")
                }
            } receiveValue: { data in
                if data.count == 1 {
                    exp.fulfill()
                }
            }
            .store(in: &suscriptor)
        await self.waitForExpectations(timeout: 15)
    }
   
    func testtransformation_Data() async throws {
        let network = NetworkTransforFake()
        XCTAssertNotNil(network)
       
        let repo = TransforRepository(network: network)
        XCTAssertNotNil(repo)
        
        let repo2 = TransforRepositoryFake()
        XCTAssertNotNil(repo2)
        
        
        let data = await repo.getTransfor(filter: UUID())
        XCTAssertNotNil(data)
        XCTAssertEqual(data.count, 1)
        
        let data2 = await repo2.getTransfor(filter: UUID())
        XCTAssertNotNil(data2)
        XCTAssertEqual(data2.count, 1)
  
    }
    
    
    func testTransformation_Domain() async throws {

        let model = TransformationModel(id: UUID(uuidString: "17824501-1106-4815-BC7A-BFDCCEE43CC9")!, name: "Vegeta", description: "Strong", photo: "http://vegeta.com")
        XCTAssertNotNil(model)
        XCTAssertEqual(model.id, UUID(uuidString: "17824501-1106-4815-BC7A-BFDCCEE43CC9")! )
        XCTAssertEqual(model.name, "Vegeta")
        XCTAssertEqual(model.description, "Strong")
        XCTAssertEqual(model.photo, "http://vegeta.com")
        
        
    }
    
    func testTransformation_Presentation() async throws {
        let viewModel = TransforViewModel(userCaseTranfor: TransforUseCaseFake(), data: UUID())
        XCTAssertNotNil(viewModel)
        let view = await TransforViewController(viewModel: viewModel)
        XCTAssertNotNil(view)
    }

    
    
    

}
