//
//  DetailsLeagueViewController.swift
//  SportSwift
//
//  Created by Mohamed on 05/05/2023.
//


import UIKit


protocol DetailsLeaguesDelegateView{
    func fetchResult(result: [Results])
}

class DetailsLeagueViewController: UIViewController,UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout,DetailsLeaguesDelegateView {
    
    

    
    var presenter:DetailsLeaguesPresenter?
    // Screen Title
    @IBOutlet weak var teamTitle: UILabel!
    
    // Tables Collections
    @IBOutlet weak var upComingCollection: UICollectionView!
    @IBOutlet weak var latestCollection: UICollectionView!
    @IBOutlet weak var teamCollection: UICollectionView!
    
    
    // Response
    var dataDetails : [Results]?

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
    
    func fetchResult(result: [Results]) {
        DispatchQueue.main.async {
            self.dataDetails = result
            self.upComingCollection.reloadData()
            self.latestCollection.reloadData()
            self.teamCollection.reloadData()
        }
    }
    
    func callData(){
        presenter?.fetchData(sportType: sportType,leagueId: self.legKey)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = DetailsLeaguesPresenter(view: self)

        // Register Collections
        registerCollection()
        
        // Call Data
        callData()
    }
    

    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // cofiguration cell for Teams
        if collectionView == teamCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "team", for: indexPath) as! TeamsCollectionViewCell
            let team = dataDetails?[indexPath.row]
            
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
       
            }
               
            return cell
        }
        
        // cofiguration  cell for upComing Event
        if collectionView == upComingCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcoming", for: indexPath) as! UpComingCollectionViewCell
            let team = dataDetails?[indexPath.row]
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
    
                
            }
            
            cell.updateData(item: team ?? Results())
            return cell
        }
        
        
        
        // cofiguration  cell for Latest Results
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "latest", for: indexPath) as! LatestResultCollectionViewCell
        // let team = dataDetails?[indexPath.row + 20 ]
        cell.layer.borderColor = UIColor.darkGray.cgColor
        cell.layer.borderWidth = 0.3

        /*
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
            
        }
        */
        
        return cell
    }
    
    
    
    
    // ****** Click Node ******* //

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if(collectionView == teamCollection){
            let storyBoard = self.storyboard?.instantiateViewController(withIdentifier: "TeamDetailsViewController") as! TeamDetailsViewController
            
            let team = dataDetails?[indexPath.row]
            let homeTeamImg = team?.home_team_logo ?? ""
//            storyBoard.teeamImg = String(homeTeamImg)
            if sportType == .cricket {
                let homeTeamKey = team?.first_player_key ?? 0
//                storyBoard.teamKey = String(homeTeamKey)
            }
            else {
                let homeTeamKey = team?.home_team_key ?? 0
//                storyBoard.teamKey = String(homeTeamKey)
            }
            
           /*
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
            */
            
            
            self.navigationController?.pushViewController(storyBoard, animated: true)
        }
    }
    
    
    
    // ****** Handle Size ******* //
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView{
        case teamCollection:
            print(dataDetails?.count ?? 1)
            return dataDetails?.count ?? 1
            
        case upComingCollection:
            return dataDetails?.count ?? 0
            //            return homeTeam.count
        
        case latestCollection:
            return dataDetails?.count ?? 0
            
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



