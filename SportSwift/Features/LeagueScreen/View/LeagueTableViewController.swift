//
//  LeagueTableViewController.swift
//  SportSwift
//
//  Created by Mohamed on 05/05/2023.
//

import UIKit
import Kingfisher


protocol LeagueDelegateView {
    func fetchResult(result:[LeagueDetails] )
    func fetchError(error:CallDataException )
}

class LeagueTableViewController: UITableViewController,LeagueDelegateView {

    
    var presenter:LeaguesPresenter?
    

    
    var leaguesResults: [LeagueDetails] = []
    
    var sportType : SportsType = SportsType.football
    
    
    func fetchResult(result: [LeagueDetails]) {
        DispatchQueue.main.async {
            self.leaguesResults = result
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }
    }
    
    func fetchError(error: CallDataException) {
        let alert = UIAlertController(title: "Internet Connection Error", message: "Please check your connection and try again", preferredStyle: .alert)
        
        switch error {
        case .mainError(let message):
            alert.title = message

            break
        case .noFeedError(let message):
            alert.title = message

            break
        case .noDateError(let message):
            alert.title = message
            break
        
        }
        DispatchQueue.main.async {
            self.leaguesResults = []
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alert, animated: true)
    }
    // Loading Action
    var activityIndicator = UIActivityIndicatorView(style: .large)
    func loadingAction(){
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    
    func callData(){
        
        presenter = LeaguesPresenter(view: self)
        presenter?.getLeaguesData(sportType: sportType)
        
        switch sportType {
        case .football :
            self.title = "Football leagues"
        case .basketball:
            self.title = "Basketball leagues"
        case .cricket:
            self.title = "Cricket leagues"
        case .tennis:
            self.title = "Tennis leagues"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingAction()
        callData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! SingleSportTableViewCell
        
        // Handel Boarder
        cell.contentView.layer.cornerRadius = 20
        cell.contentView.layer.masksToBounds = true
        
        let league = leaguesResults[indexPath.row]
        cell.lableItem.text = league.leagueName
        
        switch sportType {
        case .football:
            ImageDownloader.setImage(image: cell.imageItem, url: URL(string: league.leagueLogo ?? PlaceHolders.footballPlaceHolder)!)
        case .basketball:
            ImageDownloader.setImage(image: cell.imageItem, url: URL(string: league.leagueLogo ?? PlaceHolders.basketballPlaceHolder)!)
        case .cricket:
            ImageDownloader.setImage(image: cell.imageItem, url: URL(string: league.leagueLogo ?? PlaceHolders.cricketPlaceHolder)!)
        case .tennis:
            ImageDownloader.setImage(image: cell.imageItem, url: URL(string: league.leagueLogo ?? PlaceHolders.tennisPlaceHolder)!)
        }
        
        return cell
    }
    
    
    
    
    // ****** Click Node ******* //
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Navigate to DetailsLeague Screen
        let main = self.storyboard?.instantiateViewController(withIdentifier: "DetailsLeagueViewController") as! DetailsLeagueViewController
        main.sportType = sportType
        main.legKey = leaguesResults[indexPath.row].leagueKey
        self.navigationController?.pushViewController(main, animated: true)

    }

    // ****** Handle Size ******* //
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaguesResults.count
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    }
    



