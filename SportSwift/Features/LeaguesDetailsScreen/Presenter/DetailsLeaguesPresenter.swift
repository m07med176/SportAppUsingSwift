//
//  DetailsLeaguesPresenter.swift
//  SportSwift
//
//  Created by Mohamed on 08/05/2023.
//

import Foundation


class DetailsLeaguesPresenter{
    
    var view:DetailsLeaguesDelegateView?
    required init(view: DetailsLeaguesDelegateView? = nil) {
        self.view = view
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
                return
                
            case .failure(let failure):
                self.view?.fetchErrorLivescore(error: failure as! CallDataException)
                return
            }
            
        },url: url!)

    }
    
    
    
}
