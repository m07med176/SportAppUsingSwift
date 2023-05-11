//
//  TeamTableViewCell.swift
//  SportSwift
//
//  Created by Mohamed on 10/05/2023.
//

import UIKit

class TeamTableViewCell: UITableViewCell{
    
    @IBOutlet weak var playerNumber: UILabel!
    @IBOutlet weak var playerImg: UIImageView!
    @IBOutlet weak var playerName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

    
    func updateData(player:Player,sportType:SportsType){
        playerName.text = player.player_name
        playerNumber.text = player.player_number
        
        switch sportType {
        case .football:
            ImageDownloader.setImage(image: playerImg, url: URL(string: (player.player_image) ?? PlaceHolders.footballPlaceHolder)!)

        case .basketball:
            ImageDownloader.setImage(image: playerImg, url: URL(string: (player.player_image) ?? PlaceHolders.basketballPlaceHolder)!)

        case .cricket:
            ImageDownloader.setImage(image: playerImg, url: URL(string: (player.player_image) ?? PlaceHolders.cricketPlaceHolder)!)

        case .tennis:
            ImageDownloader.setImage(image: playerImg, url: URL(string: (player.player_image) ?? PlaceHolders.tennisPlaceHolder)!)

        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 25
        contentView.layer.borderColor = UIColor.darkGray.cgColor
        contentView.layer.borderWidth = 0.3
        contentView.clipsToBounds = true
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))


        
    }
    
    
}
