//
//  Network.swift
//  SportSwift
//
//  Created by Mohamed on 04/05/2023.
//

import Foundation

/*
 protocol MovieProtocol{
 static func fetchResult(complitionHandler: @escaping (MovieResult?)->Void)
 }
 
 
 
 class NetworkService : MovieProtocol {
 func fetchData(compilation: @escaping (TeamResponse?) -> Void){
 let footUrl =  "https://apiv2.allsportsapi.com/football/?met=Teams&teamId=\(teamKey)&APIkey=ed1c5c7c52b5fe5d2d9330d77e933c2718b6f8399bc960f0d2be45c42f016d9c"
 let basketUrl =  "https://apiv2.allsportsapi.com/basketball/?met=Teams&teamId=\(teamKey)&APIkey=ed1c5c7c52b5fe5d2d9330d77e933c2718b6f8399bc960f0d2be45c42f016d9c"
 let cricketUrl =  "https://apiv2.allsportsapi.com/cricket/?met=Teams&teamId=\(teamKey)&APIkey=ed1c5c7c52b5fe5d2d9330d77e933c2718b6f8399bc960f0d2be45c42f016d9c"
 let tennisUrl =  "https://apiv2.allsportsapi.com/tennis/?met=Players&playerId=\(teamKey)&APIkey=ed1c5c7c52b5fe5d2d9330d77e933c2718b6f8399bc960f0d2be45c42f016d9c"
 
 switch teamIndex {
 case 0 :
 AF.request(footUrl).response
 { response in
 if let data = response.data {
 do{
 let result = try JSONDecoder().decode(TeamResponse.self, from: data)
 compilation(result)
 }
 catch{
 compilation(nil)
 }
 } else {
 compilation(nil)
 }
 }
 case 1 :
 AF.request(basketUrl).response
 { response in
 if let data = response.data {
 do{
 let result = try JSONDecoder().decode(TeamResponse.self, from: data)
 compilation(result)
 }
 catch{
 compilation(nil)
 }
 } else {
 compilation(nil)
 }
 }
 case 2 :
 AF.request(cricketUrl).response
 { response in
 if let data = response.data {
 do{
 let result = try JSONDecoder().decode(TeamResponse.self, from: data)
 compilation(result)
 }
 catch{
 compilation(nil)
 }
 } else {
 compilation(nil)
 }
 }
 case 3:
 AF.request(tennisUrl).response
 { response in
 if let data = response.data {
 do{
 let result = try JSONDecoder().decode(TeamResponse.self, from: data)
 compilation(result)
 }
 catch{
 compilation(nil)
 }
 } else {
 compilation(nil)
 }
 }
 default:
 break
 }
 }
 
 
 
 
 }
 
 */
