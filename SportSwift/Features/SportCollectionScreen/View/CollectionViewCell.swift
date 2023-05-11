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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.gray.cgColor
        contentView.layer.cornerRadius = 25
    }
    
    
    override var isSelected: Bool {
         didSet {
             UIView.animate(withDuration: 0.2) {
                 self.contentView.backgroundColor = self.isSelected ? UIColor.lightGray : UIColor.white
             }
         }
     }
    
    
}
