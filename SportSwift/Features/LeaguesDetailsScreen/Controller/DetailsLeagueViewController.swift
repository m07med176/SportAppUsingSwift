//
//  DetailsLeagueViewController.swift
//  SportSwift
//
//  Created by Mohamed on 05/05/2023.
//

import UIKit

class DetailsLeagueViewController: UIViewController,UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    
    // Screen Title
    @IBOutlet weak var teamTitle: UILabel!
    
    // Tables Collections
    @IBOutlet weak var upComingCollection: UICollectionView!
    @IBOutlet weak var latestCollection: UICollectionView!
    @IBOutlet weak var teamCollection: UICollectionView!
    
    
    // Response
    var dataDetails : DetailsResponse?

    // Flags
    var sportType : SportsType = SportsType.football
    
    var legKey : Int = 0
    
    // Identifires
    let upcomingID = (identifier:"upcoming",nibName:"UpComingCollectionViewCell")
    let teamID = (identifier:"team",nibName:"TeamsCollectionViewCell")
    let latestID = (identifier:"latest",nibName:"LatestResultCollectionViewCell")
    
    
    
    func registerCollection(){
        let nibUpcoming = UINib(nibName: upcomingID.nibName, bundle: nil)
        upComingCollection.register(nibUpcoming, forCellWithReuseIdentifier: upcomingID.identifier)
        
        let nibTeam = UINib(nibName: teamID.nibName, bundle: nil)
        teamCollection.register(nibTeam, forCellWithReuseIdentifier: teamID.identifier)
        
        let nibLatest = UINib(nibName:latestID.nibName, bundle: nil)
        latestCollection.register(nibLatest, forCellWithReuseIdentifier: latestID.identifier)
        
    }
    
    func callData(){
        
        switch sportType {
            
        case .football:
            let footBallApi = "https://apiv2.allsportsapi.com/football/?met=Fixtures&APIkey=e52ecd181c43330ca2817d83ad2ca66f343324dd638d18e240bdc67666bd0cad&from=2022-02-19&to=2023-02-28&leagueId=\(legKey)"
            fetchData(apiLink: footBallApi) { res in
                print("Football")
            }
        case .basketball:
            let BasketBallApi = "https://apiv2.allsportsapi.com/basketball/?met=Fixtures&APIkey=e52ecd181c43330ca2817d83ad2ca66f343324dd638d18e240bdc67666bd0cad&from=2022-12-13&to=2023-02-20&leagueId=\(legKey)"
            fetchData(apiLink: BasketBallApi) { res in
                print("Basketball")
            }
        case .cricket:
            fetchData(apiLink: upcomingApi.Cricket.rawValue) { res in
                print("Cricket")
            }
        case .tennis:
            fetchData(apiLink: upcomingApi.Tennis.rawValue) { res in
                print("Tennis")
            }
        default:
            break
        }
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register Collections
        registerCollection()
        
        // Call Data
        callData()

    }
    

    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // cofiguration cell for Teams
        if collectionView == teamCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "team", for: indexPath) as! TeamsCollectionViewCell
            let team = dataDetails?.result[indexPath.row]
            
            switch sportType {
                // FootBall
                
            case .football:
                let url = URL(string: (team?.home_team_logo) ?? "https://goplexe.org/wp-content/uploads/2020/04/placeholder-1.png")
                //cell.teamImage.kf.setImage(with: url)
                
                // Basketball and Cricket
            case .basketball , .cricket:
                let url = URL(string: (team?.event_home_team_logo) ?? "https://goplexe.org/wp-content/uploads/2020/04/placeholder-1.png")
                cell.teamImage.kf.setImage(with: url)
                
                //tennis
            case .tennis:
                teamTitle.text = "Players"
                let url = URL(string: (team?.event_first_player_logo) ?? "https://i.ibb.co/G9YtDLp/tennis.jpg")
                cell.teamImage.kf.setImage(with: url)
                
            default:
                break
            }
               
            return cell
        }
        
        // cofiguration  cell for upComing Event
        if collectionView == upComingCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcoming", for: indexPath) as! UpComingCollectionViewCell
            let team = dataDetails?.result[indexPath.row]
            cell.layer.borderColor = UIColor.darkGray.cgColor
            cell.layer.borderWidth = 0.5
            switch sportType {
            case .football :
                // FootBall
                break
            case .basketball :
                // BasketBall
                team?.home_team_logo = (team?.home_team_logo) ?? "https://goplexe.org/wp-content/uploads/2020/04/placeholder-1.png"
                team?.away_team_logo  = (team?.away_team_logo) ?? "https://goplexe.org/wp-content/uploads/2020/04/placeholder-1.png"
                break
            case .cricket:
                //Cricket
                team?.home_team_logo = (team?.event_home_team_logo) ?? "https://goplexe.org/wp-content/uploads/2020/04/placeholder-1.png"
                team?.away_team_logo  = (team?.event_away_team_logo) ?? "https://goplexe.org/wp-content/uploads/2020/04/placeholder-1.png"
                break
                
            case .tennis :
                //tennis
                team?.home_team_logo = (team?.event_first_player_logo) ?? "https://i.ibb.co/G9YtDLp/tennis.jpg"
                team?.away_team_logo  = (team?.event_second_player_logo) ?? "https://i.ibb.co/G9YtDLp/tennis.jpg"
                break
                
                
            default :
                break
                
            }
            
            cell.updateData(item: team ?? Results())
            return cell
        }
        
        
        
        // cofiguration  cell for Latest Results
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "latest", for: indexPath) as! LatestResultCollectionViewCell
        let team = dataDetails?.result[indexPath.row + 20 ]
        cell.layer.borderColor = UIColor.darkGray.cgColor
        cell.layer.borderWidth = 0.3

        
        switch sportType {
            // FootBall
        case .football:
            
            team?.home_team_logo =  (team?.home_team_logo) ?? "https://goplexe.org/wp-content/uploads/2020/04/placeholder-1.png"
            team?.away_team_logo =  (team?.away_team_logo) ?? "https://goplexe.org/wp-content/uploads/2020/04/placeholder-1.png"
            cell.updateData(item: team ?? Results())
            
            // Basketball
        case .basketball:
            team?.home_team_logo =  (team?.event_home_team_logo) ?? "https://goplexe.org/wp-content/uploads/2020/04/placeholder-1.png"
            team?.away_team_logo =  (team?.event_away_team_logo) ?? "https://goplexe.org/wp-content/uploads/2020/04/placeholder-1.png"
            cell.updateData(item: team ?? Results())
            
            //Cricket
        case .cricket:
            team?.home_team_logo =  (team?.event_home_team_logo) ?? "https://goplexe.org/wp-content/uploads/2020/04/placeholder-1.png"
            team?.away_team_logo =  (team?.event_away_team_logo) ?? "https://goplexe.org/wp-content/uploads/2020/04/placeholder-1.png"
            cell.updateData(item: team ?? Results())
            
            //tennis
        case .tennis:

            team?.home_team_logo =  (team?.event_first_player_logo) ?? "https://i.ibb.co/G9YtDLp/tennis.jpg"
            team?.away_team_logo =  (team?.event_second_player_logo) ?? "https://i.ibb.co/G9YtDLp/tennis.jpg"
            cell.updateData(item: team ?? Results())
            
        default:
            break
        }
        return cell
    }
    
    
    
    // ****** Handle Size ******* //
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView{
        case teamCollection:
            print(dataDetails?.result.count ?? 1)
            return dataDetails?.result.count ?? 1
            
        case upComingCollection:
            return dataDetails?.result.count ?? 0
            //            return homeTeam.count
        
        case latestCollection:
            return dataDetails?.result.count ?? 0
            
        default:
            return 0
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == upComingCollection{
            //return CGSize(width: UIScreen.main.bounds.width/1.5, height: UIScreen.main.bounds.height/5)
            return CGSize(width: 150, height: 150)
        }
        if collectionView == teamCollection{
            return CGSize(width: 150, height: 150)
        }
        return CGSize(width: UIScreen.main.bounds.width/1.5, height: UIScreen.main.bounds.height/5)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == upComingCollection{
            return UIEdgeInsets(top: 1, left: 5, bottom: 1, right: 5)
        }
        return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    }
    
}




