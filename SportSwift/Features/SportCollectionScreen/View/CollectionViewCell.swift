//
//  CollectionViewCell.swift
//  SportSwift
//
//  Created by Mohamed on 05/05/2023.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var labelView: UILabel!
    
    func setCell(name : String , photo : UIImage){
        imageView.image = photo
        labelView.text = name
    }
    
}
