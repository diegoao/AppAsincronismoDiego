//
//  NetworkTransfor.swift
//  AppAsincronismoDiego
//
//  Created by Macbook Pro on 20/3/24.
//

import Foundation
import KcLibraryswift

//MARK: - Creamos el protocolo para transformaciones
protocol NetworkTransforProtocol {
    func getTransfor(filter: UUID) async -> [TransformationModel]
}

//MARK: - Hacemos la llamada de red para leer las transformaciones
final class NetworkTransfor: NetworkTransforProtocol {
    func getTransfor(filter: UUID) async -> [TransformationModel] {
        var transforReturn = [TransformationModel]()
        
        let urlCad = "\(ConstantsApp.URL_API)\(Endpoints.transform.rawValue)"
        var request = URLRequest(url: URL(string: urlCad)!)
        request.httpMethod = HTTPMethods.post
        request.httpBody = try? JSONEncoder().encode(TransforModelRequest(id: filter))
        
        
        //Leemos el token guardado
        let tokenJWT = KeyChainKC().loadKC(key: ConstantsApp.TOKEN_ID_KEYCHAIN)
        if let token = tokenJWT{
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type")
        
        //Call to Server Side
        do{
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let resp = response as? HTTPURLResponse {
                if resp.statusCode == HTTPResponseCodes.SUCESS {
                    transforReturn = try! JSONDecoder().decode([TransformationModel].self, from: data)
                }
            }
            
        } catch {
            print("error")
        }
        return transforReturn
    }
}

                
//MARK: - Creamos la clase fail para testear la app

final class NetworkTransforFake: NetworkTransforProtocol {
    func getTransfor(filter: UUID) async -> [TransformationModel] {
        
        let transformation = TransformationModel(id: UUID(),
                                                 name: "4. Super Saiyajin 3",
                                                 description: "Esta transformación es exclusiva de los videojuegos, ya que hemos podido verlo en Dragon Ball Heroes, Dragon Battlers, Raging Blast y su posterior secuela.",
                                                 photo:"https://areajugones.sport.es/wp-content/uploads/2019/07/super-saiyajin-3-vegeta-a-maxima-potencia_1680217-1024x576.jpg.webp")
//                                               

           return [transformation]
           
        }
}
   
        
    
    
    
    
    
    
    
    

