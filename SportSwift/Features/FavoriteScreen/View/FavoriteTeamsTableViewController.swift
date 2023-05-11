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
    
    var favoriteItemFootball:[FavoriteTeam] = []
    var favoriteItemTennis:[FavoriteTeam] = []
    var favoriteItemBasketball:[FavoriteTeam] = []
    var favoriteItemCricket:[FavoriteTeam] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = FavoritePresenter(view: self)
        self.title = "Favorite Teams"
    }

  
    func fetchResult(result: [FavoriteTeam]) {
        favoriteItemFootball = result.filter({ item in
            item.sport == SportsType.football.rawValue
        })
        
        favoriteItemTennis = result.filter({ item in
            item.sport == SportsType.tennis.rawValue
        })
        
        favoriteItemCricket = result.filter({ item in
            item.sport == SportsType.cricket.rawValue
        })
        
        favoriteItemBasketball = result.filter({ item in
            item.sport == SportsType.basketball.rawValue
        })
        
        
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
            favoriteItemTennis = []
            favoriteItemFootball = []
            favoriteItemBasketball = []
            favoriteItemCricket = []
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
        switch indexPath.section{
            case 0:
                navigateToNextScreen(favoritePlayer: self.favoriteItemFootball[indexPath.row])
            case 1:
                navigateToNextScreen(favoritePlayer: self.favoriteItemBasketball[indexPath.row])
            case 2:
                navigateToNextScreen(favoritePlayer: self.favoriteItemTennis[indexPath.row])
            case 3:
                navigateToNextScreen(favoritePlayer: self.favoriteItemCricket[indexPath.row])
            default:
                break
        }

    }
    
    
    func navigateToNextScreen(favoritePlayer:FavoriteTeam){
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
        switch section{
        case 0:
            return favoriteItemFootball.count
        case 1:
            return favoriteItemBasketball.count
        case 2:
            return favoriteItemTennis.count
        case 3:
            return favoriteItemCricket.count
        
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoriteTable.dequeueReusableCell(withIdentifier: "favoritecell") as! FavoriteTeamsTableViewCell

        switch indexPath.section{
        case 0:
            cell.updateData(player: favoriteItemFootball[indexPath.row])
            return cell
        case 1:
            cell.updateData(player: favoriteItemBasketball[indexPath.row])
            return cell
        case 2:
            cell.updateData(player: favoriteItemTennis[indexPath.row])
            return cell
        case 3:
            cell.updateData(player: favoriteItemCricket[indexPath.row])
            return cell

        default:
            return cell
        }
        

        

        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // Create an alert controller
            let alert = UIAlertController(title: "Remove Team", message: "Are you sure you want to remove it?", preferredStyle: .alert)
            
            // Add actions to the alert controller
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Remove", style: .destructive, handler: { _ in
                
                switch indexPath.section{
                case 0:
                    self.presenter?.deleteData(item: self.favoriteItemFootball[indexPath.row])
                case 1:
                    self.presenter?.deleteData(item: self.favoriteItemBasketball[indexPath.row])
                case 2:
                    self.presenter?.deleteData(item: self.favoriteItemTennis[indexPath.row])
                case 3:
                    self.presenter?.deleteData(item: self.favoriteItemCricket[indexPath.row])
                default:
                    break
                }
                
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
        switch section{
        case 0:
            return "Football Favorites"
        case 1:
            return "Basketball Favorite"
        case 2:
            return "Tennis Favorite"
        case 3:
            return "Cricket Favorite"
        
        default:
            return "Favorite"
        }
       
    }
    
}
