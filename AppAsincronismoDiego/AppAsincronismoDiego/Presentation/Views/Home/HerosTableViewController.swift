//
//  HerosTableViewController.swift
//  AppAsincronismoDiego
//
//  Created by Macbook Pro on 19/3/24.
//

import UIKit
import Combine

class HerosTableViewController: UITableViewController {
    //TODO: viewModel APPSTATE, HEROES
    private var appState: AppState?
    private var viewModel: HerosViewModel
    
    //Combine
    private var suscriptor =  Set<AnyCancellable>()
    
    init(appState: AppState, viewModel: HerosViewModel) {
        self.appState = appState
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //llamamos a celda personalizada
        tableView.register(UINib(nibName:"HeroTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        //Titulo en el navigation controller
        self.title = "Lista Heroes"
        
        //Añadir button para logout
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeSession))
        
        //Llamamos a binding
        binding()
    }
                                                                    
    @objc func closeSession(){
            appState?.closeSession()
        }
    
    func binding(){
        self.viewModel.$herosData
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { _ in
                self.tableView.reloadData()
            })
            .store(in: &suscriptor)
    }
    
                                                                    
                                                                    
    // MARK: - Table view data source
    
    public let fondoImage = {
        let image = UIImageView(image: UIImage(named: "fondo2"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    func getFondoImageView() -> UIImageView {
        fondoImage
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.herosData.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HeroTableViewCell
        
        //Leemos el modelo
        let hero = viewModel.herosData[indexPath.row]
        
        //Componemos la celda
        cell.NameHero.text = hero.name
        cell.photo.loadImageRemote(url: URL(string: hero.photo)!)

        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155
    }
 
}


#Preview {
    HerosTableViewController(appState: AppState(loginUseCase: LoginUseCaseFake()), viewModel: HerosViewModel(userCaseHeros: HeroUseCaseFake()))
}
