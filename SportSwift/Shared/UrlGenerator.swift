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
        return "\(BASE_URL)/\(sportType)?APIkey=\(API_KEY)&met=Leagues"
    }
}




