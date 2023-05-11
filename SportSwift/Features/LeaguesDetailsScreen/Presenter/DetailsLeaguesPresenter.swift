//
//  DetailsLeaguesPresenter.swift
//  SportSwift
//
//  Created by Mohamed on 08/05/2023.
//

import Foundation

typealias ResponseOperationFixture = ([ResultFixture])-> Void
typealias ResponseOperationLivescore = ([LivescoreResult])-> Void

class DetailsLeaguesPresenter{
    
    var view:DetailsLeaguesDelegateView?
    required init(view: DetailsLeaguesDelegateView? = nil) {
        self.view = view
    }
    
    
    var lambdaResponseFixture: ResponseOperationFixture?
    required init(response: @escaping ResponseOperationFixture){
        self.lambdaResponseFixture = response
    }
    
    
    var lambdaResponseLivescore: ResponseOperationLivescore?
    required init(response: @escaping ResponseOperationLivescore){
        self.lambdaResponseLivescore = response
    }
    
    
    
    
    func fetchDataFixture(sportType:SportsType,leagueId:Int){
        let url  = UrlSportBuilder(sportType: sportType,methodType: .Fixtures)
            .appendDateFromTo()
            .appendLeagueID(id: leagueId)
            .toURL()
        
        let network = NetworkService<Fixture>()

        network.fetchResult(complitionHandler: { (res) in
            switch res {
            case .success(let success):
                let data = success.result
                self.view?.fetchResultFixture(result: success.result)
                if let response = self.lambdaResponseFixture {
                    self.lambdaResponseFixture!(success.result)
                }
                return
                
            case .failure(let failure):
                self.view?.fetchErrorFixture(error: failure as! CallDataException)
                return
            }
            
        },url: url!)
        

    }
    
    
    func fetchDataLivesocre(sportType:SportsType){
        let url  = UrlSportBuilder(sportType: sportType,methodType: .Livescore)
            .toURL()
        
        let network = NetworkService<Livescore>()
        network.fetchResult(complitionHandler: { (res) in
            switch res {
            case .success(let success):
                let data = success.result
                self.view?.fetchResultLivescore(result: data)
                if self.lambdaResponseLivescore != nil {
                    self.lambdaResponseLivescore!(data)
                }
                return
                
            case .failure(let failure):
                self.view?.fetchErrorLivescore(error: failure as! CallDataException)
                return
            }
            
        },url: url!)

    }
    
    
    
}
