//
//  MockNetworkService.swift
//  APITesting
//
//  Created by Mohamed on 07/05/2023.
//

import Foundation
@testable import SportSwift

class MockNetworkService<K:Codable>:NetworkProtocol{

    typealias T = K
    var responseMock = ""

    required init(responseMock:String){
        self.responseMock = responseMock
    }
     
    
    func fetchResult(complitionHandler: @escaping (Result<K, Error>) -> Void, url: URL!) {
        let data = Data(responseMock.utf8)
        do{
            let response = try JSONDecoder().decode (K.self, from: data)
            complitionHandler(.success(response))
        } catch{
            complitionHandler(.failure(CallDataException.mainError(message: error.localizedDescription)))

        }
    }
    
}

class DummyString{
    static let leaguesResponse = "{ \"success\": 1,\"result\": [{\"league_key\": 4,\"league_name\": \"UEFA Europa League\",\"country_key\": 1,\"country_name\": \"eurocups\",\"league_logo\": \"https://apiv2.allsportsapi.com/logo/logo_leagues/\",\"country_logo\": null}]}"
    
    
    static let teamResponse = "{\"success\": 1,\"\"team_key\": \"team_name\": \"Leicester \"team_logo\": \"https://apiv2.allsportsapi.com/logo/155_leicester-city.\"players\": [{\"player_key\": 2930973634,\"player_name\": \"D. Ward\",\"player_number\": \"1\",\"player_country\": null,\"player_type\": \"Goalkeepers\",\"player_age\": \"29\",\"player_match_played\": \"26\",\"player_goals\": \"0\",\"player_yellow_cards\": \"0\",\"player_red_cards\": \"0\",\"player_image\": \"https://apiv2.allsportsapi.com/logo/players/10241_d-ward.jpg\"}],}]}"
    
    static let liveScoreResponse = "{\"success\": 1,\"result\": [{\"event_key\": \"event_date\": \"2023-05-\"event_time\": \"18:\"event_home_team\": \"Al \"home_team_key\": \"event_away_team\": \"Al \"away_team_key\": \"event_halftime_result\": \"1 - \"event_final_result\": \"1 - \"event_ft_\"event_penalty_}]}"

    static let fixtureResponse = "{\"success\": \"result\": [{\"event_key\": 1059495,\"event_date\": \"2023-05-18\",\"event_time\": \"20:3\",\"event_home_team\": \"Newcastle\",\"home_team_key\": 3100, \"league_key\": 152,\"league_round\": \"Round 25\",\"league_season\": \"2022/2023\"}]}"
}
