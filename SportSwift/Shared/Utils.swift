//
//  Utils.swift
//  SportSwift
//
//  Created by Mohamed on 08/05/2023.
//

import Foundation
import UIKit
import Kingfisher



enum ImagesAssets:String{
    case football = "football"
    case basketball = "basketball"
    case cricket = "cricket"
    case tennis = "tennis"
}


enum CallDataException:Error{
    case noFeedError(message:String)
    case mainError(message:String)
    case noDateError(message:String)
}


struct PlaceHolders{
    static let footballPlaceHolder = "https://www.kindpng.com/picc/m/8-83714_vector-player-football-players-free-frame-clipart-football.png"
    static let tennisPlaceHolder = "https://www.kindpng.com/picc/m/115-1157665_tennis-ball-png-transparent-image-tennis-ball-png.png"
    static let basketballPlaceHolder = "https://www.kindpng.com/picc/m/3-31675_72-inch-basketball-hoop-hd-png-download.png"
    static let cricketPlaceHolder = "https://www.kindpng.com/picc/m/133-1332750_cricket-batting-cricket-batsman-png-transparent-png.png"
    
}

class ImageDownloader{
    
    static func setImage(image:UIImageView,url:URL){
        let processor = DownsamplingImageProcessor(size: image.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 20)
        image.kf.indicatorType = .activity
        image.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholder"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
}
