//
//  HomeViewController.swift
//  AppAsincronismoDiego
//
//  Created by Macbook Pro on 18/3/24.
//

import UIKit

class HomeViewController: UIViewController {
    private var appState: AppState?
    
    init(appState: AppState){
        self.appState = appState
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    // Cerramos la session
    @IBAction func closeSesion(_ sender: Any) {
        self.appState?.closeSession()
    }
    

}
