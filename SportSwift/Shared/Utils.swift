//
//  Utils.swift
//  SportSwift
//
//  Created by Mohamed on 08/05/2023.
//

import Foundation




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
