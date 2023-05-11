//
//  DetailsLeagueViewController.swift
//  SportSwift
//
//  Created by Mohamed on 05/05/2023.
//


import UIKit


protocol DetailsLeaguesDelegateView{
    func fetchResultFixture(result: [ResultFixture])
    func fetchResultLivescore(result: [LivescoreResult])
    func fetchErrorFixture(error:CallDataException )
    func fetchErrorLivescore(error:CallDataException )
}

class DetailsLeagueViewController: UIViewController,UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout,DetailsLeaguesDelegateView {

    
    
    var presenter:DetailsLeaguesPresenter?
    // Screen Title
    @IBOutlet weak var teamTitle: UILabel!
    
    // Tables Collections
    @IBOutlet weak var upComingCollection: UICollectionView!
    @IBOutlet weak var latestCollection: UICollectionView!
    @IBOutlet weak var teamCollection: UICollectionView!
    
    @IBOutlet weak var UpComingErrorMessage: UILabel!
    @IBOutlet weak var teamErrorMessage: UILabel!
    @IBOutlet weak var latestErrorMessage: UILabel!
    
    // Response
    var dataDetailsFixture : [ResultFixture]?
    var dataDetailsLivescore : [LivescoreResult]?

    // Flags
    var sportType : SportsType = SportsType.football
    var legKey : Int = 0
    
    // Identifires
    let upcomingID = (identifier:"upcoming",nibName:"UpComingCollectionViewCell")
    let teamID = (identifier:"team",nibName:"TeamsCollectionViewCell")
    let latestID = (identifier:"latest",nibName:"LatestResultCollectionViewCell")
    
    // Loading Action
    var activityIndicator = UIActivityIndicatorView(style: .large)
    func loadingAction(){
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    func fetchResultFixture(result: [ResultFixture]) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.dataDetailsFixture = result
            self.upComingCollection.reloadData()
            self.teamCollection.reloadData()
        }
    }
    
    func fetchResultLivescore(result: [LivescoreResult]) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.dataDetailsLivescore = result
            self.latestCollection.reloadData()
        }
    }
    
    
    func fetchErrorFixture(error: CallDataException) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            
            self.teamErrorMessage.isHidden = true
            self.UpComingErrorMessage.isHidden = true
            
            self.teamCollection.isHidden = false
            self.UpComingErrorMessage.isHidden = false
            
            switch error {
            case .mainError(let message):
                print(message)
                self.teamErrorMessage.text = message
                self.UpComingErrorMessage.text = message

                break
            case .noFeedError(let message):
                self.teamErrorMessage.text = message
                self.UpComingErrorMessage.text = message

                break
            case .noDateError(let message):
                self.teamErrorMessage.text = message
                self.UpComingErrorMessage.text = message

                break
            
            }
        }
    }
    
    func fetchErrorLivescore(error: CallDataException) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.latestErrorMessage.isHidden = true
            self.latestCollection.isHidden = false

            
            switch error {
            case .mainError(let message):
                self.latestErrorMessage.text = message
                print(message)
                break
            case .noFeedError(let message):
                self.latestErrorMessage.text = message
                print(message)
                break
            case .noDateError(let message):
                self.latestErrorMessage.text = message
                print(message)
                break
            
            }
        }
    }
    
    func callData(){
        presenter?.fetchDataFixture(sportType: sportType,leagueId: self.legKey)
        presenter?.fetchDataLivesocre(sportType: sportType)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = DetailsLeaguesPresenter(view: self)
        // Call Data
        loadingAction()
        callData()
        teamErrorMessage.isHidden = true
        UpComingErrorMessage.isHidden = true
        latestErrorMessage.isHidden = true
    }
    

    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
  
        if collectionView == teamCollection{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "team", for: indexPath) as! TeamsCollectionViewCell
            let team = dataDetailsFixture?[indexPath.row]
            
            switch sportType {
            case .football:
                let url = URL(string: (team?.home_team_logo) ?? "https://goplexe.org/wp-content/uploads/2020/04/placeholder-1.png")
                cell.teamImage.kf.setImage(with: url)
                
            case .basketball , .cricket:
                let url = URL(string: (team?.event_home_team_logo) ?? "https://goplexe.org/wp-content/uploads/2020/04/placeholder-1.png")
                cell.teamImage.kf.setImage(with: url)
                
            case .tennis:
                teamTitle.text = "Players"
                let url = URL(string: (team?.event_first_player_logo) ?? "https://i.ibb.co/G9YtDLp/tennis.jpg")
                cell.teamImage.kf.setImage(with: url)
            }
            
            return cell
        }
        
        
        
        
        if collectionView == upComingCollection{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcoming", for: indexPath) as! UpComingCollectionViewCell
            let team = dataDetailsFixture?[indexPath.row]
            cell.layer.borderColor = UIColor.darkGray.cgColor
            cell.layer.borderWidth = 0.5
            switch sportType {
            case .football :
                // FootBall
                break
            case .basketball :
                // BasketBall
//                team?.home_team_logo = (team?.home_team_logo) ?? "https://goplexe.org/wp-content/uploads/2020/04/placeholder-1.png"
                //                team?.away_team_logo  = (team?.away_team_logo) ?? "https://goplexe.org/wp-content/uploads/2020/04/placeholder-1.png"
                break
            case .cricket:
                //Cricket
                //                team?.home_team_logo = (team?.event_home_team_logo) ?? "https://goplexe.org/wp-content/uploads/2020/04/placeholder-1.png"
                //                team?.away_team_logo  = (team?.event_away_team_logo) ?? "https://goplexe.org/wp-content/uploads/2020/04/placeholder-1.png"
                break
                
            case .tennis :
                //tennis
                //                team?.home_team_logo = (team?.event_first_player_logo) ?? "https://i.ibb.co/G9YtDLp/tennis.jpg"
                //                team?.away_team_logo  = (team?.event_second_player_logo) ?? "https://i.ibb.co/G9YtDLp/tennis.jpg"
                break
                
                
            }
            
            cell.updateData(item: team ?? ResultFixture())
            return cell
        }
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "latest", for: indexPath) as! LatestResultCollectionViewCell
            // let team = dataDetails?[indexPath.row + 20 ]
            cell.layer.borderColor = UIColor.darkGray.cgColor
            cell.layer.borderWidth = 0.3
            
        let team = dataDetailsLivescore?[indexPath.row]
            switch sportType {
                // FootBall
            case .football:
                
//                team?.home_team_logo =  (team?.home_team_logo) ?? "https://goplexe.org/wp-content/uploads/2020/04/placeholder-1.png"
//                team?.away_team_logo =  (team?.away_team_logo) ?? "https://goplexe.org/wp-content/uploads/2020/04/placeholder-1.png"
                cell.updateData(item: team!)
                
                // Basketball
            case .basketball:
//                team?.home_team_logo =  (team?.event_home_team_logo) ?? "https://goplexe.org/wp-content/uploads/2020/04/placeholder-1.png"
//                team?.away_team_logo =  (team?.event_away_team_logo) ?? "https://goplexe.org/wp-content/uploads/2020/04/placeholder-1.png"
                cell.updateData(item: team!)
                
                //Cricket
            case .cricket:
//                team?.home_team_logo =  (team?.event_home_team_logo) ?? "https://goplexe.org/wp-content/uploads/2020/04/placeholder-1.png"
//                team?.away_team_logo =  (team?.event_away_team_logo) ?? "https://goplexe.org/wp-content/uploads/2020/04/placeholder-1.png"
                cell.updateData(item: team!)
                
                //tennis
            case .tennis:

//                team?.home_team_logo =  (team?.event_first_player_logo) ?? "https://i.ibb.co/G9YtDLp/tennis.jpg"
//                team?.away_team_logo =  (team?.event_second_player_logo) ?? "https://i.ibb.co/G9YtDLp/tennis.jpg"
                cell.updateData(item: team!)
                
        
       
        }

        
        return cell

     
    }
    
    
    
    
    // ****** Click Node ******* //

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if(collectionView == teamCollection){
            let teamScreen = self.storyboard?.instantiateViewController(withIdentifier: "TeamDetailsViewController") as! TeamDetailsViewController
            
            let team = dataDetailsFixture?[indexPath.row]
            teamScreen.sportType = sportType
            teamScreen.teamId = team?.home_team_key ?? 0
            
            self.navigationController?.pushViewController(teamScreen, animated: true)
        }
    }
    
    
    
    // ****** Handle Size ******* //
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView{
        case teamCollection:
            print(dataDetailsFixture?.count ?? 1)
            return dataDetailsFixture?.count ?? 1
            
        case upComingCollection:
            return dataDetailsFixture?.count ?? 0
            //            return homeTeam.count
        
        case latestCollection:
            return dataDetailsFixture?.count ?? 0
            
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




