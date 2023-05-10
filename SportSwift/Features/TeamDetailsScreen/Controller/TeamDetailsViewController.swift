//
//  TeamDetailsViewController.swift
//  SportSwift
//
//  Created by Mohamed on 05/05/2023.
//

import UIKit

protocol TeamDetailsDelegateView{
    func fetchResult(result:[TeamDetailsResult])
    func fetchError(error:CallDataException )
}
class TeamDetailsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate ,TeamDetailsDelegateView {


    @IBOutlet weak var playersTable: UITableView!
    @IBOutlet weak var teamImg: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    
    @IBOutlet weak var favButton: UIButton!
    
    var presenter:TeamDetailsPresenter?
    
    var sportType:SportsType = SportsType.football
    var teamId:Int = 0
    var playesList:[Player] = []
    var team:FavoriteTeam?
    
    // Loading Action
    var activityIndicator = UIActivityIndicatorView(style: .large)
    func loadingAction(){
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = TeamDetailsPresenter(view: self)
        loadingAction()
        presenter?.fetchTeamData(sportType: sportType, teamId: teamId)
    }
    
    
    func fetchResult(result: [TeamDetailsResult]) {
        DispatchQueue.main.sync {
            if result.count != 0 {
                let teamDetails = result[0]
                team = FavoriteTeam(key: teamDetails.team_key ?? 0, name: teamDetails.team_name ?? "", logo: teamDetails.team_logo ?? "", sport: sportType.rawValue )
                
                teamName.text = teamDetails.team_name
                let url = URL(string: (teamDetails.team_logo)!)
                teamImg.kf.setImage(with: url)
                playesList = teamDetails.players
                self.activityIndicator.stopAnimating()
                playersTable.reloadData()
                
                guard let teamFavorite = team else{
                    return
                }
                
                if presenter?.isExistItem(item: teamFavorite) == true{
                    self.favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                }else{
                    self.favButton.setImage(UIImage(systemName: "heart"), for: .normal)

                }
            }
      
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
            self.playesList = []
            self.activityIndicator.stopAnimating()
            self.playersTable.reloadData()
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alert, animated: true)
        
    }
    
    @IBAction func favButtonAction(_ sender: Any) {
               
        guard let teamFavorite = team else{
            return
        }
        if (favButton.configuration?.image == UIImage(systemName: "heart.fill")){
            self.favButton.setImage(UIImage(systemName: "heart"), for: .normal)
            // Deletes
            presenter?.deleteData(item: teamFavorite)
            
        } else if (favButton.configuration?.image == UIImage(systemName: "heart")){
            self.favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            // Insert
            presenter?.insertFavoriteItem(item: teamFavorite)
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerscell", for: indexPath) as! TeamTableViewCell
        
        cell.contentView.layer.cornerRadius = 20
        cell.contentView.layer.masksToBounds = true
        
        let player =  playesList[indexPath.row]
        cell.playerName.text = player.player_name
        cell.playerNumber.text = player.player_number
        
        //MARK: - predicate
        let string = player.player_image
        let predicate = NSPredicate(format:"SELF ENDSWITH[c] %@", ".jpg")
        let result = predicate.evaluate(with: string)
                print(result) // true
        
        if result{
            let url = URL(string: (player.player_image)!)
            cell.playerImg.kf.setImage(with: url)
        }else
        {
            switch sportType {
            case .football:
                cell.playerImg.image = UIImage(named: "football")

            case .basketball:
                cell.playerImg.image = UIImage(named: "basketball")

            case .cricket:
                cell.playerImg.image = UIImage(named: "cricket")

            case .tennis:
                cell.playerImg.image = UIImage(named: "tennis")

            }
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  playesList.count
    }
}
