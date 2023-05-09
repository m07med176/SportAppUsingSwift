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
    
    func fetchData(sportType:SportsType,leagueId:Int){
        var url:URL?
        switch sportType{
        case .basketball:
            url = UrlSportBuilder(sportType: sportType,methodType: .Fixtures)
                .appendDateFromTo()
                .toURL()
            break
        case .football:
            url = UrlSportBuilder(sportType: sportType,methodType: .Fixtures)
                .appendDateFromTo()
                .appendLeagueID(id: leagueId)
                .toURL()
            break
        case .cricket:
            url = UrlSportBuilder(sportType: sportType,methodType: .Fixtures)
                .appendDateFromTo()
                .toURL()
            break
        case .tennis:
            url = UrlSportBuilder(sportType: sportType,methodType: .Fixtures)
                .appendDateFromTo()
                .toURL()
            break
        
        }
        
        
        

        
//        let network = NetworkService<DetailsResponse>()
//
//        network.fetchResult(complitionHandler: { (res) in
//            let items = res.result
//            self.view?.fetchResult(result: items ?? [])
//
//        },url: url!)

    }
}
