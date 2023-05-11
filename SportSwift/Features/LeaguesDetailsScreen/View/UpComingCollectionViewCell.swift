//
//  UpComingCollectionViewCell.swift
//  SportSwift
//
//  Created by Mohamed on 05/05/2023.
//

import UIKit

class UpComingCollectionViewCell: UICollectionViewCell{
    @IBOutlet weak var awayImageView: UIImageView!
    @IBOutlet weak var homeImageView: UIImageView!
    
    @IBOutlet weak var dateTimeView: UILabel!
    @IBOutlet weak var eventTimeView: UILabel!
    @IBOutlet weak var awayTitleView: UILabel!
    @IBOutlet weak var homeTitleView: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateData(item:ResultFixture,sportType:SportsType){

        dateTimeView.text = item.event_date
        eventTimeView.text = item.event_time

        
        switch sportType {
        case .football :
            ImageDownloader.setImage(image: homeImageView, url: URL(string: item.home_team_logo ?? PlaceHolders.footballPlaceHolder)!)
            ImageDownloader.setImage(image: awayImageView, url: URL(string: item.home_team_logo ?? PlaceHolders.footballPlaceHolder)!)
            
            homeTitleView.text = item.event_home_team
            awayTitleView.text = item.event_away_team
            break
            
        case .basketball :
            ImageDownloader.setImage(image: homeImageView, url: URL(string: item.home_team_logo ?? PlaceHolders.footballPlaceHolder)!)
            ImageDownloader.setImage(image: awayImageView, url: URL(string: item.home_team_logo ?? PlaceHolders.basketballPlaceHolder)!)
            
            homeTitleView.text = item.event_home_team
            awayTitleView.text = item.event_away_team
            break
            
        case .cricket:
            ImageDownloader.setImage(image: homeImageView, url: URL(string: item.home_team_logo ?? PlaceHolders.cricketPlaceHolder)!)
            ImageDownloader.setImage(image: awayImageView, url: URL(string: item.home_team_logo ?? PlaceHolders.cricketPlaceHolder)!)
            
            homeTitleView.text = item.event_home_team
            awayTitleView.text = item.event_away_team
            break
            
        case .tennis :
            ImageDownloader.setImage(image: homeImageView, url: URL(string: item.event_first_player_logo ?? PlaceHolders.tennisPlaceHolder)!)
            ImageDownloader.setImage(image: awayImageView, url: URL(string: item.event_second_player_logo ?? PlaceHolders.tennisPlaceHolder)!)
            
            homeTitleView.text = item.event_first_player
            awayTitleView.text = item.event_second_player
            break
            
            
        }
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.borderWidth = 2.0
        contentView.layer.borderColor = UIColor.gray.cgColor
        contentView.layer.cornerRadius = 25
    }
    
    
}
