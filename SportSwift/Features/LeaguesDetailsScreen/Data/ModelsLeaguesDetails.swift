//
//  Models.swift
//  SportSwift
//
//  Created by Mohamed on 08/05/2023.
//

import Foundation


class Results:Codable{
    var event_date:String?
    var event_time:String?
    var event_first_player:String?
    var event_second_player:String?
    var event_home_team:String?
    var home_team_key:Int?//teams
    var event_away_team:String?
    var away_team_key:Int?//teams
    var event_final_result:String?
    var home_team_logo:String?//teams
    var away_team_logo:String?//teams
    var event_home_team_logo:String?//basketball
    var event_away_team_logo:String?//basketball
    var event_second_player_logo:String?//tennis
    var event_date_stop:String? //cricket
    var event_home_final_result:String? //cricket
    var event_first_player_logo:String?//tennis
    var first_player_key: Int?//tennis
}


class DetailsResponse:Codable{
    
    var success:Int?
    var result:[Results]
}
