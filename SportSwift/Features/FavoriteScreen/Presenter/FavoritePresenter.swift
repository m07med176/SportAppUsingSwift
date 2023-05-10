//
//  FavoritePresenter.swift
//  SportSwift
//
//  Created by Mohamed on 09/05/2023.
//

import Foundation


class FavoritePresenter{
    
    var db:CoreDataDb?
    
    var view:FavoriteTeamsDelegateView?
    required init(view: FavoriteTeamsDelegateView? = nil) {
        db = CoreDataDb.initCoreData
        
        self.view = view
    }
    
    func fetchData(){
        
        do{
            let favoriteList = try db?.fetchData() ?? []
            if favoriteList.count == 0{
                view?.fetchError(error: CallDataException.noDateError(message: "No Data"))
            }else{
                view?.fetchResult(result: favoriteList)
            }
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
