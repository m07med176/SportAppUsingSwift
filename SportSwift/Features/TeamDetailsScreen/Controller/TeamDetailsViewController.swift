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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = TeamDetailsPresenter(view: self)
        presenter?.fetchTeamData(sportType: sportType, teamId: teamId)
    }
    
    
    func fetchResult(result: [TeamDetailsResult]) {
        if result.count != 0{
            playesList = result[0].players
            playersTable.reloadData()
        }
  
    }
    
    func fetchError(error: CallDataException) {
    
        
    }
    
    @IBAction func favButtonAction(_ sender: Any) {
               
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerscell", for: indexPath) as! TeamTableViewCell
        
        cell.contentView.layer.cornerRadius = 20
        cell.contentView.layer.masksToBounds = true
        
        let player =  playesList[indexPath.row]
//        cell.playerName.text = player?.player_name ?? "Unknown"
//        cell.playerNumber.text = player?.player_number ?? "Unknown"
        
        //MARK: - predicate
//        let string = player?.player_image
//        let predicate = NSPredicate(format:"SELF ENDSWITH[c] %@", ".jpg")
//        let result = predicate.evaluate(with: string)
        //        print(result) // true
        //MARK: - kingfisher
//        if result{
//            let url = URL(string: (player?.player_image)!)
//            cell.playerImg.kf.setImage(with: url)
//        }else
//        {
//            switch teamIndex {
//            case 0 :
//                cell.playerImg.image = UIImage(named: "football")
//            case 1 :
//                cell.playerImg.image = UIImage(named: "NewBasketball")
//            case 2 :
//                cell.playerImg.image = UIImage(named: "NewCricket")
//            case 3 :
//                cell.playerImg.image = UIImage(named: "tennis")
//            default:
//                break
//            }
//        }
        //MARK: - make the cell look round
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  playesList.count
    }
}
