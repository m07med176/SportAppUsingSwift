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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
    }
    
    
    
}
