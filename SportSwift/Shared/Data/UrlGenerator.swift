//
//  Constants.swift
//  SportSwift
//
//  Created by Mohamed on 07/05/2023.
//

import Foundation


class UrlSportBuilder{
    let BASE_URL:String = "https://apiv2.allsportsapi.com/"
    let API_KEY = "e52ecd181c43330ca2817d83ad2ca66f343324dd638d18e240bdc67666bd0cad"
    
    private var url:String = ""
    
    init(sportType:SportsType,methodType:MethodType){
        appendBaseURL()
        appendSportType(sportType:sportType)
        appendAPIKey()
        appendMethodType(methodType: methodType)
    }
    
   
    private func appendBaseURL(){
        url.append(BASE_URL)
    }
    
    private func appendSportType(sportType:SportsType){
        url.append(sportType.rawValue)
    }
    
    private func appendAPIKey(){
        url.append("?APIkey=\(API_KEY)")
    }
    
    
    private func appendMethodType(methodType:MethodType){
        url.append("&met=\(methodType.rawValue)")
    }
    
    
    
    
    
    func appendDateFromTo()->UrlSportBuilder{
           let date = Date()
           let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.locale = Locale(identifier: "en_US")
        
            let startTime = dateFormatter.string(from: date)
            var dateComponent = DateComponents()
            dateComponent.day = 14
            var LastTimeDate = Calendar.current.date(byAdding: dateComponent, to: date)

            
            let lastTime = dateFormatter.string(from: LastTimeDate!)
        
            url.append("&from=\(startTime)&to=\(lastTime)")
            return self
        }
    
    
    func appendLeagueID(id:Int)->UrlSportBuilder{
        
        url.append("&leagueId=\(id)")
        return self
    }
    func toString()->String{
        return url
    }
    
    
    func toURL()->URL!{
        return URL(string: url)!
    }
    
    
    
    
    
}



enum SportsType:String{
    case football = "football"
    case basketball = "basketball"
    case cricket = "cricket"
    case tennis = "tennis"
}


enum MethodType:String{
    case Leagues = "Leagues"
    case Fixtures = "Fixtures"
    case Livescore = "Livescore"
    case Teams = "Teams"
}


