//
//  TeamsCollectionViewCell.swift
//  SportSwift
//
//  Created by Mohamed on 05/05/2023.
//

import UIKit

class TeamsCollectionViewCell: UICollectionViewCell {

    

    @IBOutlet weak var teamImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateData(photo:UIImage){
        teamImage.image = photo
    }
    
  

}
