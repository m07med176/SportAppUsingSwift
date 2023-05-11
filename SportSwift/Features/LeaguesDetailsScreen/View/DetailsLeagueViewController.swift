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
            
            self.teamErrorMessage.isHidden = false
            self.UpComingErrorMessage.isHidden = false
            
            self.teamCollection.isHidden = true
            self.upComingCollection.isHidden = true
            
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
            self.latestErrorMessage.isHidden = false
            self.latestCollection.isHidden = true

            
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
    

    
    func handleTeamCollcectionView(cell:TeamsCollectionViewCell,cellForItemAt indexPath: IndexPath)-> UICollectionViewCell{
        let team = dataDetailsFixture?[indexPath.row]
        cell.updateData(item: team ?? ResultFixture(), sportType: sportType)
        if sportType == .tennis{
            teamTitle.text = "Players"
        }

        return cell
    }
    
    
    func handleUpComingCollectionView(cell:UpComingCollectionViewCell,cellForItemAt indexPath: IndexPath)-> UICollectionViewCell{
        let team = dataDetailsFixture?[indexPath.row]
        cell.updateData(item: team ?? ResultFixture(),sportType: sportType)
        return cell
    }
    
    func handleLatestCollectionView(cell:LatestResultCollectionViewCell,cellForItemAt indexPath: IndexPath)-> UICollectionViewCell{
        let team = dataDetailsLivescore?[indexPath.row]
        cell.updateData(item: team!,sportType: sportType)
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == teamCollection{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "team", for: indexPath) as! TeamsCollectionViewCell
            return handleTeamCollcectionView(cell:cell,cellForItemAt: indexPath)
        }
        
        if collectionView == upComingCollection{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcoming", for: indexPath) as! UpComingCollectionViewCell
            return handleUpComingCollectionView(cell: cell, cellForItemAt: indexPath)
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "latest", for: indexPath) as! LatestResultCollectionViewCell
        return handleLatestCollectionView(cell: cell, cellForItemAt: indexPath)
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
            return dataDetailsFixture?.count ?? 0
            
        case upComingCollection:
            return dataDetailsFixture?.count ?? 0
            
        case latestCollection:
            return dataDetailsLivescore?.count ?? 0
            
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




