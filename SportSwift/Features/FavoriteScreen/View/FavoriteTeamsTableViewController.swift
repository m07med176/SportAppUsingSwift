//
//  FavoriteTeamsTableViewController.swift
//  SportSwift
//
//  Created by Mohamed on 09/05/2023.
//

import UIKit


protocol FavoriteTeamsDelegateView {
    func fetchResult(result:[FavoriteTeam])
    func fetchError(error:CallDataException )
}

class FavoriteTeamsTableViewController: UIViewController,UITableViewDataSource, UITableViewDelegate,FavoriteTeamsDelegateView {
    @IBOutlet weak var favoriteTable: UITableView!
    
    var presenter:FavoritePresenter?
    
    var favoriteItem:[FavoriteTeam] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = FavoritePresenter(view: self)
    }

  
    func fetchResult(result: [FavoriteTeam]) {
        favoriteItem = result
        favoriteTable.reloadData()
    }
    
    func fetchError(error: CallDataException) {
        let alert = UIAlertController(title: "Data Error", message: "There is an error of fetching data", preferredStyle: .alert)
        
        switch error {
        case .mainError(let message):
            alert.title = message

            break
        case .noFeedError(let message):
            alert.title = message
            

            break
        case .noDateError(let message):
            alert.title = message
            favoriteItem = []
            favoriteTable.reloadData()
            break
        
        }
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alert, animated: true)
    }
  
    override func viewDidAppear(_ animated: Bool) {
        presenter?.fetchData()
    }

    
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favoritePlayer = favoriteItem[indexPath.row]
        
        let teamScreen = self.storyboard?.instantiateViewController(withIdentifier: "TeamDetailsViewController") as! TeamDetailsViewController
        
        switch favoritePlayer.sport{
            case SportsType.football.rawValue:
                teamScreen.sportType = SportsType.football
            
            case SportsType.tennis.rawValue:
                teamScreen.sportType = SportsType.tennis

            case SportsType.basketball.rawValue:
                teamScreen.sportType = SportsType.basketball

            case SportsType.cricket.rawValue:
                teamScreen.sportType = SportsType.cricket

        default:
            teamScreen.sportType = SportsType.football
        }
        
        teamScreen.teamId = favoritePlayer.key
        teamScreen.isFavoriteVisisble = false
        
        self.navigationController?.pushViewController(teamScreen, animated: true)
    }
    
    // DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteItem.count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = favoriteTable.dequeueReusableCell(withIdentifier: "favoritecell") as! FavoriteTeamsTableViewCell

        let favoritePlayer = favoriteItem[indexPath.row]
        cell.FavoriteTeamName.text = favoritePlayer.name
        cell.FavoriteTeamImage.kf.setImage(with: URL(string: favoritePlayer.logo ))

        cell.FavoriteTeamView.layer.cornerRadius = cell.contentView.frame.height / 2.5
        cell.FavoriteTeamImage.layer.cornerRadius = cell.FavoriteTeamImage.frame.height / 2.5
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Remove the corresponding data item from your data source
            let favoritePlayer = favoriteItem[indexPath.row]

            // Create an alert controller
            let alert = UIAlertController(title: "Remove Team", message: "Are you sure you want to remove \(favoritePlayer.name) from favorites?", preferredStyle: .alert)
            
            // Add actions to the alert controller
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Remove", style: .destructive, handler: { _ in
                
                self.presenter?.deleteData(item: favoritePlayer)
                self.presenter?.fetchData()
            }))
            
            // Present the alert controller
            self.present(alert, animated: true, completion: nil)
        }}
    
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection
                                section: Int) -> String? {
       return "Favorites"
    }
    
}
