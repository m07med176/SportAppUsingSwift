//
//  LeagueTableViewController.swift
//  SportSwift
//
//  Created by Mohamed on 05/05/2023.
//

import UIKit
import Kingfisher

class LeagueTableViewController: UITableViewController {
    var legTitles: [String] = []
    var legImg: [Any] = []
    var legCountry: [String] = []
    var legKey: [Int] = []
    var data: [[String: Any]] = []
    
    var sportType : SportsType = SportsType.football
    
    
    // Loading Action
    var activityIndicator = UIActivityIndicatorView(style: .large)
    func loadingAction(){
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    
    func callData(){
        switch sportType {
        case .football :
            self.title = "Football leagues"
            fetchData(apiLink: sportsApi.Football.rawValue)
        case .basketball:
            self.title = "Basketball leagues"
            fetchData(apiLink: sportsApi.Basketball.rawValue)
        case .cricket:
            self.title = "Cricket leagues"
            fetchCricketData()
        case .tennis:
            self.title = "Tennis leagues"
            fetchData(apiLink: sportsApi.Tennis.rawValue)
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
        
        cell.lableItem.text = legTitles[indexPath.row]
        
        switch sportType {
            
        case .football :
            let str = legImg[indexPath.row]
            let predicate = NSPredicate(format:"SELF ENDSWITH[c] %@", ".png")
            let result = predicate.evaluate(with: str)
            
            if result{
                let url = URL(string: str as! String)
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
        main.legKey = legKey[indexPath.row]
        self.navigationController?.pushViewController(main, animated: true)

    }

    // ****** Handle Size ******* //
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return legTitles.count
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    }
    



