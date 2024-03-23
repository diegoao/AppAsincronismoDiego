//
//  HeroViewController.swift
//  AppAsincronismoDiego
//
//  Created by Macbook Pro on 21/3/24.
//

import UIKit
import Combine

class HeroViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
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

        //Titulo en el navigation controller
        let localizedString = NSLocalizedString("Hero List", comment: "Lista de Héroes")
        self.title = localizedString
        binding()
        //Añadir button para logout
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeSession))
        configureUI()
    }

    @objc func closeSession(){
            appState?.closeSession()
        }
    
    func binding(){
        self.viewModel.$herosData
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { _ in
                self.collectionView.reloadData()
            })
            .store(in: &suscriptor)
    }
    
    
    func configureUI() {

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName:"CellCustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")

        collectionView.backgroundColor = .clear
        

    }

}


extension HeroViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let heroe = viewModel.herosData[indexPath.row]
        let tranforViewController = TransforViewController(viewModel: TransforViewModel(data: heroe.id))
        navigationController?.pushViewController(tranforViewController, animated: true)
        return
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.herosData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Obtener una celda reutilizable
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CellCustomCollectionViewCell
        let hero = viewModel.herosData[indexPath.row]
        
        // Configurar la celda con datos específicos según el indexPath
        cell.nameHero.text = hero.name
        cell.photo.loadImageRemote(url: URL(string: hero.photo)!)
        // Devolver la celda configurada
        return cell
        
    }
}
extension HeroViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 180)
    }
    
    
    
}
