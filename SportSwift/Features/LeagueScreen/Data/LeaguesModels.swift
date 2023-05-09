//
//  Models.swift
//  SportSwift
//
//  Created by Mohamed on 08/05/2023.
//

import Foundation


struct League: Codable {
    let success: Int
    let result: [LeagueDetails]
}

struct LeagueDetails: Codable {
    let leagueKey: Int
    let leagueName: String
//    let countryKey: Int
//    let countryName: String
    let leagueLogo: String?
//    let countryLogo: String?
    
    enum CodingKeys: String, CodingKey {
        case leagueKey = "league_key"
        case leagueName = "league_name"
//        case countryKey = "country_key"
//        case countryName = "country_name"
        case leagueLogo = "league_logo"
//        case countryLogo = "country_logo"
    }
}
