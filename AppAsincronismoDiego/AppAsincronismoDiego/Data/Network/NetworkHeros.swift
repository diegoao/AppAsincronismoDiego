//
//  NetworkHeros.swift
//  AppAsincronismoDiego
//
//  Created by Macbook Pro on 19/3/24.
//

import Foundation
import KcLibraryswift

protocol NetworkHerosProtocol {
    func getHeros(filter:String) async -> [HerosModel]
}


final class NetworkHeros: NetworkHerosProtocol {
    func getHeros(filter: String) async -> [HerosModel] {
        var modelReturn = [HerosModel]()
        
        let urlCad = "\(ConstantsApp.URL_API)\(Endpoints.heros.rawValue)"
        var request = URLRequest(url: URL(string:urlCad)!)
        request.httpMethod = HTTPMethods.post
        request.httpBody = try? JSONEncoder().encode(HerosModelRequest(name: filter))
        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type")
        
        
        //Ahora leemos el token JWT
        let tokenJWT = KeyChainKC().loadKC(key: ConstantsApp.TOKEN_ID_KEYCHAIN)
        if let token = tokenJWT{
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        //Llamamos al servidor
        
        do{
            let(data, response)  = try await URLSession.shared.data(for: request)
            if let resp = response as? HTTPURLResponse{
                if resp.statusCode == HTTPResponseCodes.SUCESS{
                    modelReturn = try! JSONDecoder().decode([HerosModel].self, from: data)
                }
            }
        }catch{
            
        }
        return modelReturn
    }
}
    

final class NetworkHerosFake: NetworkHerosProtocol {
    func getHeros(filter: String) async -> [HerosModel] {
        
        let model1 = HerosModel(id: UUID(), favorite: true, description: "Sobran las presentaciones cuando se habla de Goku. El Saiyan fue enviado al planeta Tierra, pero hay dos versiones sobre el origen del personaje. Según una publicación especial, cuando Goku nació midieron su poder y apenas llegaba a dos unidades, siendo el Saiyan más débil. Aun así se pensaba que le bastaría para conquistar el planeta. Sin embargo, la versión más popular es que Freezer era una amenaza para su planeta natal y antes de que fuera destruido, se envió a Goku en una incubadora para salvarle.", photo: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/goku1.jpg?width=300", name: "Goku")
      
       let model2 = HerosModel(id: UUID(), favorite: true, description: "Vegeta es todo lo contrario. Es arrogante, cruel y despreciable. Quiere conseguir las bolas de Dragón y se enfrenta a todos los protagonistas, matando a Yamcha, Ten Shin Han, Piccolo y Chaos. Es despreciable porque no duda en matar a Nappa, quien entonces era su compañero, como castigo por su fracaso. Tras el intenso entrenamiento de Goku, el guerrero se enfrenta a Vegeta y estuvo a punto de morir. Lejos de sobreponerse, Vegeta huye del planeta Tierra sin saber que pronto tendrá que unirse a los que considera sus enemigos.", photo: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/vegetita.jpg?width=300", name: "Vegeta")
        
       return [model1, model2]
       
    }
}
    

