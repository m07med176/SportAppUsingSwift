//
//  NetworkService.swift
//  SportSwift
//
//  Created by Mohamed on 08/05/2023.
//

import Foundation
import Reachability


protocol NetworkProtocol{
    associatedtype T
    func fetchResult(complitionHandler: @escaping (Result<T, Error>) -> Void,url:URL!)
}



class CheckNetworkConnectivity{
    static let connection  = CheckNetworkConnectivity()
    private let reachability = try! Reachability()

    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability

        switch reachability.connection {
        case .wifi:
            print("Wifi Connection")
        case .cellular:
            print("Cellular Connection ")
        case .unavailable:
            print("No Connection")
        case .none:
            print("No Connection")
        }
    }
    
    private init(){
        startConncetionObserver()
    }
    
    
    func getReachablility() -> Reachability{
        return reachability
    }
    
    func startConncetionObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    func stopConnectionObserver(){
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
    
}

class NetworkService<K:Codable> : NetworkProtocol {
    typealias T = K

    var connection:CheckNetworkConnectivity?
    
    func fetchResult(complitionHandler: @escaping (Result<K, Error>) -> Void,url:URL!){


        if connection?.getReachablility().connection == .unavailable{
            complitionHandler(.failure(CallNetworkException.noConnectionError(message: "There is no Internet Conncection")))
            return
        }
        guard let newUrl = url else{
            complitionHandler(.failure(CallNetworkException.mainNetworkError(message: "Invalid URL")))
            return
        }
        
        let req = URLRequest(url: newUrl)

        let session = URLSession (configuration: .default)

        let task = session.dataTask(with: req) { data, response, error in
            do{
                let res = try JSONDecoder().decode(K.self, from: data!)
                complitionHandler(.success(res))
            } catch let error {
                 
                complitionHandler(.failure(CallNetworkException.mainNetworkError(message: error.localizedDescription)))
            }
        }
        
        task.resume()
    }
}
