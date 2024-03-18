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

}
