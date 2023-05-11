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
    static let teamResponse = "{\"success\":1,\"result\":[{\"team_key\":96,\"team_name\":\"Juventus\",\"team_logo\":\"https:\\/\\/apiv2.allsportsapi.com\\/logo\\/96_juventus.jpg\",\"players\":[{\"player_key\":3932445726,\"player_name\":\"W.Szcz\\u0119sny\",\"player_number\":\"1\",\"player_country\":null,\"player_type\":\"Goalkeepers\",\"player_age\":\"33\",\"player_match_played\":\"23\",\"player_goals\":\"0\",\"player_yellow_cards\":\"0\",\"player_red_cards\":\"0\",\"player_image\":\"https:\\/\\/apiv2.allsportsapi.com\\/logo\\/players\\/10227_w-szczsny.jpg\"},{\"player_key\":1136721488,\"player_name\":\"C.Pinsoglio\",\"player_number\":\"23\",\"player_country\":null,\"player_type\":\"Goalkeepers\",\"player_age\":\"33\",\"player_match_played\":\"0\",\"player_goals\":\"0\",\"player_yellow_cards\":\"0\",\"player_red_cards\":\"0\",\"player_image\":\"https:\\/\\/apiv2.allsportsapi.com\\/logo\\/players\\/124198_c-pinsoglio.jpg\"},{\"player_key\":41841276,\"player_name\":\"M.Perin\",\"player_number\":\"36\",\"player_country\":null,\"player_type\":\"Goalkeepers\",\"player_age\":\"30\",\"player_match_played\":\"10\",\"player_goals\":\"0\",\"player_yellow_cards\":\"0\",\"player_red_cards\":\"0\",\"player_image\":\"https:\\/\\/apiv2.allsportsapi.com\\/logo\\/players\\/472_m-perin.jpg\"}]}]}"

    static let leaguesResponse = "{\"success\":1,\"result\":[{\"league_key\":4,\"league_name\":\"UEFAEuropaLeague\",\"country_key\":1,\"country_name\":\"eurocups\",\"league_logo\":\"https:\\/\\/apiv2.allsportsapi.com\\/logo\\/logo_leagues\\/\",\"country_logo\":null},{\"league_key\":1,\"league_name\":\"EuropeanChampionship\",\"country_key\":1,\"country_name\":\"eurocups\",\"league_logo\":null,\"country_logo\":null},{\"league_key\":683,\"league_name\":\"UEFAEuropaConferenceLeague\",\"country_key\":1,\"country_name\":\"eurocups\",\"league_logo\":null,\"country_logo\":null},{\"league_key\":3,\"league_name\":\"UEFAChampionsLeague\",\"country_key\":1,\"country_name\":\"eurocups\",\"league_logo\":\"https:\\/\\/apiv2.allsportsapi.com\\/logo\\/logo_leagues\\/3_uefa_champions_league.png\",\"country_logo\":null},{\"league_key\":633,\"league_name\":\"UEFANationsLeague\",\"country_key\":1,\"country_name\":\"eurocups\",\"league_logo\":null,\"country_logo\":null},{\"league_key\":28,\"league_name\":\"WorldCup\",\"country_key\":8,\"country_name\":\"Worldcup\",\"league_logo\":\"https:\\/\\/apiv2.allsportsapi.com\\/logo\\/logo_leagues\\/28_world-cup.png\",\"country_logo\":\"https:\\/\\/apiv2.allsportsapi.com\\/logo\\/logo_country\\/8_worldcup.png\"}]}"

    static let liveScoreResponse = "{\"success\":1,\"result\":[{\"event_key\":1071539,\"event_date\":\"2023-05-07\",\"event_time\":\"12:30\",\"event_home_team\":\"Atalanta\",\"home_team_key\":85,\"event_away_team\":\"Juventus\",\"away_team_key\":96,\"event_halftime_result\":\"0-0\",\"event_final_result\":\"0-1\",\"event_ft_result\":\"\",\"event_penalty_result\":\"\",\"event_status\":\"60\",\"country_name\":\"Italy\",\"league_name\":\"SerieA\",\"league_key\":207,\"league_round\":\"Round34\",\"league_season\":\"2022\\/2023\",\"event_live\":\"1\",\"event_stadium\":\"GewissStadium,Bergamo\",\"event_referee\":\"DanieleDoveri,Italy\",\"home_team_logo\":\"https:\\/\\/apiv2.allsportsapi.com\\/logo\\/85_atalanta.jpg\",\"away_team_logo\":\"https:\\/\\/apiv2.allsportsapi.com\\/logo\\/96_juventus.jpg\",\"event_country_key\":5,\"league_logo\":\"https:\\/\\/apiv2.allsportsapi.com\\/logo\\/logo_leagues\\/207_serie-a.png\",\"country_logo\":\"https:\\/\\/apiv2.allsportsapi.com\\/logo\\/logo_country\\/5_italy.png\",\"event_home_formation\":\"3-4-2-1\",\"event_away_formation\":\"3-5-1-1\",\"fk_stage_key\":331,\"stage_name\":\"Current\"}]}"
  
    static let fixtureResponse = "{\"success\":1,\"result\":[{\"event_key\":37180,\"event_date\":\"2021-05-18\",\"event_time\":\"20:00\",\"event_home_team\":\"Brighton&HoveAlbion\",\"home_team_key\":3079,\"event_away_team\":\"ManchesterCity\",\"away_team_key\":80,\"event_halftime_result\":\"0-1\",\"event_final_result\":\"3-2\",\"event_ft_result\":\"3-2\",\"event_penalty_result\":\"\",\"event_status\":\"Finished\",\"country_name\":\"England\",\"league_name\":\"PremierLeague\",\"league_key\":152,\"league_round\":\"Round37\",\"league_season\":\"2020\\/2021\",\"event_live\":\"0\",\"event_stadium\":\"TheAmericanExpressCommunityStadium(Falmer,EastSussex)\",\"event_referee\":\"S.Attwell\",\"home_team_logo\":\"https:\\/\\/apiv2.allsportsapi.com\\/logo\\/3079_brighton--hove-albion.jpg\",\"away_team_logo\":\"https:\\/\\/apiv2.allsportsapi.com\\/logo\\/80_manchester-city.jpg\",\"event_country_key\":44,\"league_logo\":\"https:\\/\\/apiv2.allsportsapi.com\\/logo\\/logo_leagues\\/152_premier-league.png\",\"country_logo\":\"https:\\/\\/apiv2.allsportsapi.com\\/logo\\/logo_country\\/44_england.png\",\"event_home_formation\":\"\",\"event_away_formation\":\"\",\"fk_stage_key\":6,\"stage_name\":\"Current\"}]}"
    

}
