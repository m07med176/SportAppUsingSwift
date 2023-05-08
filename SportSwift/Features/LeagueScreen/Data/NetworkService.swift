//
//  NetworkService.swift
//  SportSwift
//
//  Created by Mohamed on 08/05/2023.
//

import Foundation

protocol NetworkProtocol{
    static func fetchResult(complitionHandler: @escaping (League?)->Void,sportType:SportsType)
}



class NetworkService : NetworkProtocol {
    static func fetchResult(complitionHandler: @escaping (League?)->Void,sportType:SportsType){
        let url = URL(string: UrlGenerator().getUrl(sportType: sportType))

        guard let newUrl = url else{
            return
        }
        
        let req = URLRequest(url: newUrl)

        let session = URLSession (configuration: .default)

        let task = session.dataTask(with: req) { data, response, error in
            do{
                let res = try JSONDecoder().decode(League.self, from: data!)
                complitionHandler(res)
            } catch let error {
                print (error.localizedDescription)
                complitionHandler(nil)
            }
        }
        
        task.resume()
    }
    
   
    
}
