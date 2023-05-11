//
//  FavoriteTeamsTableViewCell.swift
//  SportSwift
//
//  Created by Mohamed on 10/05/2023.
//

import UIKit

class FavoriteTeamsTableViewCell: UITableViewCell {

    @IBOutlet weak var FavoriteTeamView: UIView!
    
    @IBOutlet weak var FavoriteTeamImage: UIImageView!
    
    @IBOutlet weak var FavoriteTeamName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    
    func updateData(player:FavoriteTeam){
        FavoriteTeamName.text = player.name
        ImageDownloader.setImage(image: FavoriteTeamImage, url: URL(string: player.logo ?? "" )!)
        FavoriteTeamView.layer.cornerRadius = contentView.frame.height / 2.5
        FavoriteTeamImage.layer.cornerRadius = FavoriteTeamImage.frame.height / 2.5
        
    }
}
