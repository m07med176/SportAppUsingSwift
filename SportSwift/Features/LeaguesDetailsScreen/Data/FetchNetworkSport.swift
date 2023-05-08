//
//  FetchNetworkSport.swift
//  SportSwift
//
//  Created by Mohamed on 05/05/2023.
//

import Foundation
import UIKit

class Results:Decodable{
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


class DetailsResponse:Decodable{
    
    var success:Int?
    var result:[Results]
}



extension LeagueTableViewController {
    
  // football and basketball and tennis
    func fetchData(apiLink : String) {
        guard let url = URL(string: "\(apiLink)") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let result = (json as? [String: Any])?["result"] as? [[String: Any]] {
                    self.data = result
                    self.legTitles = result.compactMap { $0["league_name"] as? String }
                    self.legCountry = result.compactMap { $0["country_name"] as? String }
                    self.legImg = result.compactMap { $0["league_logo"] }
                    self.legKey = result.compactMap { $0["league_key"] as? Int }
                    
                    self.legImg = self.legImg.map{$0 is NSNull ? "https://goplexe.org/wp-content/uploads/2020/04/placeholder-1.png" : $0}
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.tableView.reloadData()
                    }
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    
    
    func fetchCricketData() {
        guard let url = URL(string: sportsApi.Cricket.rawValue) else {
            print("Invalid URL")
            return
        }
        
        
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let result = (json as? [String: Any])?["result"] as? [[String: Any]] {
                    self.data = result
                    self.legTitles = result.compactMap { $0["league_name"] as? String }
                    self.legCountry = result.compactMap { $0["league_year"] as? String }
                    self.legImg = result.compactMap { $0["league_logo"] as? String }
                    self.legKey = result.compactMap { $0["league_key"] as? Int }
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.tableView.reloadData()
                    }
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    enum sportsApi : String {
        
        case Football = "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=e52ecd181c43330ca2817d83ad2ca66f343324dd638d18e240bdc67666bd0cad"
        case Basketball = "https://apiv2.allsportsapi.com/basketball/?met=Leagues&APIkey=e52ecd181c43330ca2817d83ad2ca66f343324dd638d18e240bdc67666bd0cad"
        case Cricket = "https://apiv2.allsportsapi.com/cricket/?met=Leagues&APIkey=e52ecd181c43330ca2817d83ad2ca66f343324dd638d18e240bdc67666bd0cad"
        case Tennis = "https://apiv2.allsportsapi.com/tennis/?met=Leagues&APIkey=e52ecd181c43330ca2817d83ad2ca66f343324dd638d18e240bdc67666bd0cad"
        
    }
    
}









extension DetailsLeagueViewController {
    
    func fetchData(apiLink : String, compilation: @escaping (DetailsResponse?) -> Void)
    {
        
        guard let url = URL(string: "\(apiLink)") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if (json as? [String: Any])?["result"] is [[String: Any]] {
                    
                    let result = try JSONDecoder().decode(DetailsResponse.self, from: data)
                    print(result.success!)
                    compilation(result)
                    DispatchQueue.main.async {
                        self.dataDetails = result
                        self.upComingCollection.reloadData()
                        self.latestCollection.reloadData()
                        self.teamCollection.reloadData()
                    }
                }
            } catch {
                compilation(nil)
            }
            
            
            
            
        }
        
        task.resume()
        
    }

        
        
    enum upcomingApi : String {
        
        case Football = "https://apiv2.allsportsapi.com/football/?met=Fixtures&APIkey=44ec41896869760bf9da8e3b2ccd2ea8bca5c24e0269d0102507eed1e78a3ae1&from=2021-05-18&to=2021-05-18"
        case Basketball = "https://apiv2.allsportsapi.com/basketball/?met=Fixtures&APIkey=44ec41896869760bf9da8e3b2ccd2ea8bca5c24e0269d0102507eed1e78a3ae1&from=2022-05-23&to=2022-05-23"
        case Cricket = "https://apiv2.allsportsapi.com/cricket/?met=Fixtures&APIkey=44ec41896869760bf9da8e3b2ccd2ea8bca5c24e0269d0102507eed1e78a3ae1&from=2022-03-13&to=2022-03-13"
        case Tennis = "https://apiv2.allsportsapi.com/tennis/?met=Fixtures&APIkey=44ec41896869760bf9da8e3b2ccd2ea8bca5c24e0269d0102507eed1e78a3ae1&from=2020-06-03&to=2020-06-03"
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if(collectionView == teamCollection){
            let storyBoard = self.storyboard?.instantiateViewController(withIdentifier: "TeamDetailsViewController") as! TeamDetailsViewController
            
            let team = dataDetails?.result[indexPath.row]
            let homeTeamImg = team?.home_team_logo ?? ""
            storyBoard.teeamImg = String(homeTeamImg)
            if sportType == .cricket {
                let homeTeamKey = team?.first_player_key ?? 0
                storyBoard.teamKey = String(homeTeamKey)
            }
            else {
                let homeTeamKey = team?.home_team_key ?? 0
                storyBoard.teamKey = String(homeTeamKey)
            }
            
            
            
            switch sportType {
            case .football :
                storyBoard.sportType = "football"
                storyBoard.teamIndex = 0
                
            case .basketball :
                storyBoard.sportType = "basketball"
                storyBoard.teamIndex = 1
                
            case .cricket :
                storyBoard.sportType = "cricket"
                storyBoard.teamIndex = 2
                
            case .tennis :
                storyBoard.sportType = "tennis"
                storyBoard.teamIndex = 3
                
            }
            self.navigationController?.pushViewController(storyBoard, animated: true)
        }
    }
    
    
    
}

