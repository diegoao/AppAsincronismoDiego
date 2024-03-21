//
//  SceneDelegate.swift
//  AppAsincronismoDiego
//
//  Created by Macbook Pro on 17/3/24.
//

import UIKit
import Combine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    //MARK: - ViewModel global
    var appState: AppState = AppState(loginUseCase: LoginUseCase())
    var cancelable: AnyCancellable?
		

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windoScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windoScene)
        
        //Evaluarmos si hacemos autologin
        appState.validateControlLogin()
        
        //Create validation Controller
        var navi: UINavigationController?
        
        //ViewRouter
        self.cancelable = appState.$statusLogin
            .sink(receiveValue: { estado in
                switch estado {
                case .notValidate, .none:
                    //ver el login
                    DispatchQueue.main.async {
                        print("vamos para el login")
                        navi = UINavigationController(rootViewController: LoginViewController(appState: self.appState))
                        self.window!.rootViewController = navi
                        self.window!.makeKeyAndVisible()
                    }
                case .success:
                    //ver home
                    DispatchQueue.main.async {
                        print("vamos para el home")
                        navi = UINavigationController(rootViewController: HeroViewController(appState: self.appState, viewModel: HerosViewModel()))
                        self.window!.rootViewController = navi
                        self.window!.makeKeyAndVisible()
                    }
                case.error:
                    //error
                    DispatchQueue.main.async {
                        print("vamos para el error")
                        navi = UINavigationController(rootViewController: ErrorViewController(appState: self.appState, error: "Error in user or password"))
                        self.window!.rootViewController = navi
                        self.window!.makeKeyAndVisible()
                    }
                }
            })
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

