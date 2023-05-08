//
//  LeaguesPresenter.swift
//  SportSwift
//
//  Created by Mohamed on 08/05/2023.
//

import Foundation

class LeaguesPresenter{
    var view:FetchDataView?
    required init(view: FetchDataView? = nil) {
        self.view = view
    }
    
    func getLeaguesData(sportType:SportsType){
        NetworkService.fetchResult(complitionHandler: {(res) in
            let items = res?.result ?? [];
            self.view?.fetchResult(result: items)
        }, sportType: sportType)
    }
    
}
