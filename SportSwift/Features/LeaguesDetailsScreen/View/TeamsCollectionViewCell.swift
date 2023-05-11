//
//  TeamsCollectionViewCell.swift
//  SportSwift
//
//  Created by Mohamed on 05/05/2023.
//

import UIKit

class TeamsCollectionViewCell: UICollectionViewCell {

    

    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var teamImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateData(item:ResultFixture,sportType:SportsType){
        switch sportType {

        case .football:
            titleView.text = item.event_home_team
            ImageDownloader.setImage(image: teamImage, url: URL(string: (item.home_team_logo) ?? PlaceHolders.footballPlaceHolder)!)

        case .basketball:
            titleView.text = item.event_home_team
            ImageDownloader.setImage(image: teamImage, url: URL(string: (item.event_home_team_logo) ?? PlaceHolders.basketballPlaceHolder)!)

         case .cricket:
            titleView.text = item.event_home_team
            ImageDownloader.setImage(image: teamImage, url: URL(string: (item.event_home_team_logo) ?? PlaceHolders.cricketPlaceHolder)!)


        case .tennis:
            titleView.text = item.event_first_player
            ImageDownloader.setImage(image: teamImage, url: URL(string: (item.event_first_player_logo) ?? PlaceHolders.tennisPlaceHolder)!)


        }
        
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
//        contentView.layer.borderWidth = 1.0
//        contentView.layer.borderColor = UIColor.gray.cgColor
    }
    
  

}
