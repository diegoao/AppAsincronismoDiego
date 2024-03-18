//
//  ErrorViewController.swift
//  AppAsincronismoDiego
//
//  Created by Macbook Pro on 18/3/24.
//

import UIKit
import Combine
import CombineCocoa

class ErrorViewController: UIViewController {
    
    
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var buttonBack: UIButton!
    
    private var suscriptor = Set<AnyCancellable>()
    private var error: String?
    private var appState: AppState?
    
    init(appState: AppState, error: String){
        self.appState = appState
        self.error = error
        
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //View error in label
        self.lblError.text = self.error
        
        //suscriptor to button
        self.buttonBack.tapPublisher
            .sink {[weak self] _ in
                self?.appState?.statusLogin = .none
            }
            .store(in: &suscriptor)
    }


    
    
    

}
