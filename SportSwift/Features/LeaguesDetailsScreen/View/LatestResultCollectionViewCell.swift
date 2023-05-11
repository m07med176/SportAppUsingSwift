//
//  LatestResultCollectionViewCell.swift
//  SportSwift
//
//  Created by Mohamed on 05/05/2023.
//

import UIKit

class LatestResultCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var eventFinalResultLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var homeTeamLabel: UILabel!
            
    @IBOutlet weak var homeTeamImageView: UIImageView!
    @IBOutlet weak var eventTimeLable: UILabel!
    @IBOutlet weak var awayTeamImageView: UIImageView!
    @IBOutlet weak var awayTeamLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 25
        contentView.layer.borderColor = UIColor.darkGray.cgColor
        contentView.layer.borderWidth = 0.3
        contentView.clipsToBounds = true
        contentView.frame = CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: self.bounds.width, height: self.bounds.height).insetBy(dx: 7, dy: 1)

        
    }
    
    func updateData(item: LivescoreResult,sportType:SportsType) {
        

        eventDateLabel.text = item.event_date
        eventTimeLable.text = item.event_time

        eventFinalResultLabel.text = item.event_final_result
        
        switch sportType {
        case .football:
            ImageDownloader.setImage(image: homeTeamImageView, url: URL(string: (item.home_team_logo) ?? PlaceHolders.footballPlaceHolder)!)
            ImageDownloader.setImage(image: awayTeamImageView, url: URL(string: (item.away_team_logo) ?? PlaceHolders.footballPlaceHolder)!)
            
            homeTeamLabel.text = item.event_home_team
            awayTeamLabel.text = item.event_away_team
            break
            
        case .basketball:
            ImageDownloader.setImage(image: homeTeamImageView, url: URL(string: (item.event_home_team_logo) ?? PlaceHolders.basketballPlaceHolder)!)
            ImageDownloader.setImage(image: awayTeamImageView, url: URL(string: (item.event_away_team_logo) ?? PlaceHolders.basketballPlaceHolder)!)
            
            homeTeamLabel.text = item.event_home_team
            awayTeamLabel.text = item.event_away_team
            break
            
         case .cricket:
            ImageDownloader.setImage(image: homeTeamImageView, url: URL(string: (item.event_home_team_logo) ?? PlaceHolders.cricketPlaceHolder)!)
            ImageDownloader.setImage(image: awayTeamImageView, url: URL(string: (item.event_away_team_logo) ?? PlaceHolders.cricketPlaceHolder)!)
            
            eventDateLabel.text = item.event_date_start
            homeTeamLabel.text = item.event_home_team
            awayTeamLabel.text = item.event_away_team
            eventFinalResultLabel.text = item.event_home_final_result
            break
            
        case .tennis:
            ImageDownloader.setImage(image: homeTeamImageView, url: URL(string: (item.event_first_player_logo) ?? PlaceHolders.tennisPlaceHolder)!)
            ImageDownloader.setImage(image: awayTeamImageView, url: URL(string: (item.event_second_player_logo) ?? PlaceHolders.tennisPlaceHolder)!)
            
            homeTeamLabel.text = item.event_first_player
            awayTeamLabel.text = item.event_first_player
            break
            
        }
        

        
        
    }
    
  

}
