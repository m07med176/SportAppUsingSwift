//
//  Models.swift
//  SportSwift
//
//  Created by Mohamed on 08/05/2023.
//

import Foundation


struct Fixture: Codable {
    let success: Int?
    let result: [ResultFixture]
}

struct ResultFixture: Codable {
    var event_date:String?
    var event_time:String?
    var event_first_player:String?
    var event_second_player:String?
    var event_home_team:String?
    var home_team_key:Int?
    var event_away_team:String?
    var away_team_key:Int?
    var event_final_result:String?
    var home_team_logo:String?
    var away_team_logo:String?
    var event_home_team_logo:String?
    var event_away_team_logo:String?
    var event_second_player_logo:String?
    var event_date_stop:String?
    var event_home_final_result:String?
    var event_first_player_logo:String?
    var first_player_key: Int?
    var second_player_key: Int?
}


struct Livescore: Codable {
    let success: Int
    let result: [LivescoreResult]
}

struct LivescoreResult: Codable {
    var event_key: Int?
    var event_date: String?
    var event_time: String?
    var event_home_team: String?
    var home_team_key: Int?
    var event_away_team: String?
    var away_team_key: Int?
    var event_halftime_result: String?
    var event_final_result: String?
    var event_ft_result: String?
    var event_penalty_result: String?
    var event_status: String?
    var country_name: String?
    var league_name: String?
    var league_key: Int?
    var league_round: String?
    var league_season: String?
    var event_live: String?
    var event_stadium: String?
    var event_referee: String?
    var home_team_logo: String?
    var away_team_logo: String?
    var event_country_key: Int?
    var league_logo: String?
    var country_logo: String?
    var event_home_formation: String?
    var event_away_formation: String?
    var fk_stage_key: Int?
    var stage_name: String?
    var event_quarter: String?
    var event_home_team_logo: String?
    var event_away_team_logo: String?
    var event_first_player: String?
    var first_player_key: Int?
    var event_second_player: String?
    var second_player_key: Int?
    var event_game_result: String?
    var event_serve: String?
    var event_winner: String?
    var event_first_player_logo: String?
    var event_second_player_logo: String?
    var event_date_start: String?
    var event_date_stop: String?
    var event_service_home: String?
    var event_service_away: String?
    var event_home_final_result: String?
    var event_away_final_result: String?
    var event_home_rr: String?
    var event_away_rr: String?
    var event_status_info: String?
    var event_type: String?
    var event_toss: String?
    var event_man_of_match: String?
}
