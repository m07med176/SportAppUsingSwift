//
//  LatestResultCollectionViewCell.swift
//  SportSwift
//
//  Created by Mohamed on 05/05/2023.
//

import UIKit

class LatestResultCollectionViewCell: UICollectionViewCell,UpdateCollectionData {
    @IBOutlet weak var eventFinalResultLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var homeTeamLabel: UILabel!
    
    @IBOutlet weak var homeTeamImageView: UIImageView!
    
    @IBOutlet weak var awayTeamImageView: UIImageView!
    
    @IBOutlet weak var awayTeamLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateData(item: Results) {
        self.layer.cornerRadius = 25
        
        homeTeamLabel.text = item.event_home_team
        awayTeamLabel.text = item.event_away_team
        eventDateLabel.text = item.event_date
        eventFinalResultLabel.text = item.event_time
        
        homeTeamImageView.kf.setImage(with: URL(string: item.home_team_logo ?? ""))
        homeTeamImageView.kf.indicatorType = .activity
        awayTeamImageView.kf.setImage(with: URL(string: item.away_team_logo ?? ""))
    }
    
  

}
