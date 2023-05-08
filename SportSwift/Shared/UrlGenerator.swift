//
//  Constants.swift
//  SportSwift
//
//  Created by Mohamed on 07/05/2023.
//

import Foundation


class UrlGenerator{
    let API_KEY = "e52ecd181c43330ca2817d83ad2ca66f343324dd638d18e240bdc67666bd0cad"
    let BASE_URL:String = "https://apiv2.allsportsapi.com/"
    
    func getUrl(sportType:SportsType)->String{
        return "\(BASE_URL)/\(sportType.rawValue)?APIkey=\(API_KEY)&met=Leagues"
    }
}

/*
 enum sportsApi : String {
     case Football = "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=e52ecd181c43330ca2817d83ad2ca66f343324dd638d18e240bdc67666bd0cad"
     case Basketball = "https://apiv2.allsportsapi.com/basketball/?met=Leagues&APIkey=e52ecd181c43330ca2817d83ad2ca66f343324dd638d18e240bdc67666bd0cad"
     case Cricket = "https://apiv2.allsportsapi.com/cricket/?met=Leagues&APIkey=e52ecd181c43330ca2817d83ad2ca66f343324dd638d18e240bdc67666bd0cad"
     case Tennis = "https://apiv2.allsportsapi.com/tennis/?met=Leagues&APIkey=e52ecd181c43330ca2817d83ad2ca66f343324dd638d18e240bdc67666bd0cad"
 }
 */




