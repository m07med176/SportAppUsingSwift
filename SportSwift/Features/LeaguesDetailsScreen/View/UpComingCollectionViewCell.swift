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
    
    func updateData(item:ResultFixture){
        
        self.layer.cornerRadius = 25
        
        homeTitleView.text = item.event_home_team
        awayTitleView.text = item.event_away_team
        dateTimeView.text = item.event_date
        eventTimeView.text = item.event_time
        homeImageView.kf.setImage(with: URL(string: item.home_team_logo ?? ""))
        homeImageView.kf.indicatorType = .activity
        awayImageView.kf.setImage(with: URL(string: item.away_team_logo ?? ""))
    }

}
