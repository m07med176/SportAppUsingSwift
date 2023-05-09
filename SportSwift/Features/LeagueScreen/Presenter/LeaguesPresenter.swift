//
//  LeaguesPresenter.swift
//  SportSwift
//
//  Created by Mohamed on 08/05/2023.
//

import Foundation

class LeaguesPresenter{
    var view:LeagueDelegateView?
    required init(view: LeagueDelegateView? = nil) {
        self.view = view
    }
    
    func getLeaguesData(sportType:SportsType) {
        let url = UrlSportBuilder(sportType: sportType,methodType: .Leagues).toURL()
        let network = NetworkService<League>()
    
        network.fetchResult(complitionHandler: { (res) in
            

            switch res {
            case .success(let success):
                let data = success.result
                if data.count == 0{
                    self.view?.fetchError(error: CallDataException.noDateError(message:" Sorry no data here"))

                }else{
                    self.view?.fetchResult(result: success.result)

                }
                
                return
                
            case .failure(let failure):
                self.view?.fetchError(error: failure as! CallDataException)
                return
            }


            
        },url: url!)

    }
    
}
