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
    func fetchError(error:CallNetworkException )
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
    
    func fetchError(error: CallNetworkException) {
        let alert = UIAlertController(title: "Internet Connection Error", message: "Please check your connection and try again", preferredStyle: .alert)
        
        switch error {
        case .mainNetworkError(let message):
            alert.title = message

            break
        case .noConnectionError(let message):
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
        
        cell.lableItem.text = leaguesResults[indexPath.row].leagueName
        
        switch sportType {
            
        case .football :
            let str = leaguesResults[indexPath.row].leagueLogo
            let predicate = NSPredicate(format:"SELF ENDSWITH[c] %@", ".png")
            let result = predicate.evaluate(with: str)
            
            if result{
                let url = URL(string: str!)
                cell.imageItem.kf.setImage(with: url)
            }else{
                cell.imageItem.image = UIImage(named: ImagesAssets.football.rawValue)
            }
        case .basketball :
            cell.imageItem.image = UIImage(named: ImagesAssets.basketball.rawValue)
        case .cricket :
            cell.imageItem.image = UIImage(named: ImagesAssets.cricket.rawValue)
        case .tennis :
            cell.imageItem.image = UIImage(named: ImagesAssets.tennis.rawValue)

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
    }
    



