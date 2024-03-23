//
//  TransforViewController.swift
//  AppAsincronismoDiego
//
//  Created by Macbook Pro on 21/3/24.
//

import UIKit
import Combine

class TransforViewController: UIViewController, UITableViewDelegate {
    
   
    @IBOutlet weak var errorNotransfortext: UILabel!
    @IBOutlet weak var lbnotransfor: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // Outlets
    private var viewModel: TransforViewModel
    
    //Combine
    private var suscriptors = Set<AnyCancellable>()
    
    init(viewModel: TransforViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbnotransfor.isHidden = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "TransforTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        // Localizamos el idioma para el titulo de la navegación
        let localizedString = NSLocalizedString("Transformations", comment: "Lista de transformaciones")
        self.title = localizedString
        //Localizamos el idioma del teléfono para el mensaje de error
        let msgTransfor = NSLocalizedString("msgTransfor", comment: " Mensaje no hay transformaciones")
        errorNotransfortext.text = msgTransfor
        
        binding()
        
    }
    
    func binding(){
        self.viewModel.$transforData
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { _ in
                //recargamos la tabla
                self.tableView.reloadData()
                if self.viewModel.transforData.count == 0 {
                    self.lbnotransfor.isHidden = false
                }else{
                    self.lbnotransfor.isHidden = true
                }
                    
              
            })
            .store(in: &suscriptors)
    }
}

extension TransforViewController: UITableViewDataSource {
    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.viewModel.transforData.count
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TransforTableViewCell

        let transfor = viewModel.transforData[indexPath.row]
        
        //compongo la celda
        cell.nameTranformation.text = transfor.name
        cell.photo.loadImageRemote(url: URL(string: transfor.photo)!)

        return cell
    }
 
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155
    }

}


