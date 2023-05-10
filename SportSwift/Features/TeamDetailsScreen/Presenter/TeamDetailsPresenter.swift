//
//  TeamDetailsPresenter.swift
//  SportSwift
//
//  Created by Mohamed on 09/05/2023.
//

import Foundation


class TeamDetailsPresenter{
    
    var db:CoreDataDb?
    
    var view:TeamDetailsDelegateView?
    required init(view: TeamDetailsDelegateView? = nil) {
        db = CoreDataDb.initCoreData
        
        self.view = view
    }
    
    
    func fetchTeamData(sportType:SportsType,teamId:Int){
        
        let url = UrlSportBuilder(sportType: sportType,methodType: .Teams).appendTeamID(id: teamId).toURL()
        let network = NetworkService<TeamsDetails>()
    
        network.fetchResult(complitionHandler: { (res) in
            switch res {
            case .success(let success):
                self.view?.fetchResult(result: success.result)
                return
                
            case .failure(let failure):
                self.view?.fetchError(error: failure as! CallDataException)
                return
            }
        },url: url!)
    }
    
    
    func isExistItem(item:FavoriteTeam) ->Bool{
        var status:Bool = false
        
        do{
            status = try db?.isExistItem(item: item) ?? false
        }catch CallDataException.mainError(let message){
            view?.fetchError(error: CallDataException.mainError(message: message))
        }catch CallDataException.noFeedError(let message){
            view?.fetchError(error: CallDataException.noFeedError(message: message))
        }catch CallDataException.noDateError(let message){
            view?.fetchError(error: CallDataException.noDateError(message: message))
        }catch{
            view?.fetchError(error: CallDataException.mainError(message: "Error occurred"))
        }
        
        return status
    }
    
    func insertFavoriteItem(item:FavoriteTeam){
        do{
            try db?.insertData(item: item)
        }catch CallDataException.mainError(let message){
            view?.fetchError(error: CallDataException.mainError(message: message))
        }catch CallDataException.noFeedError(let message){
            view?.fetchError(error: CallDataException.noFeedError(message: message))

        }catch CallDataException.noDateError(let message){
            view?.fetchError(error: CallDataException.noDateError(message: message))
        }catch{
            view?.fetchError(error: CallDataException.mainError(message: "Error occurred"))
        }
    }
    
    
    func deleteData(item:FavoriteTeam){
        do{
            try db?.deleteData(item: item)
            
        }catch CallDataException.mainError(let message){
            view?.fetchError(error: CallDataException.mainError(message: message))

        }catch CallDataException.noFeedError(let message){
            view?.fetchError(error: CallDataException.noFeedError(message: message))

        }catch CallDataException.noDateError(let message){
            view?.fetchError(error: CallDataException.noDateError(message: message))
        }catch{
            view?.fetchError(error: CallDataException.mainError(message: "Error occurred"))
        }
    }
    

    
    
}
