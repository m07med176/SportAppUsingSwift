//
//  ViewController.swift
//  SportSwift
//
//  Created by Mohamed on 04/05/2023.
//

import UIKit
import Reachability


// Table Item
struct Sports {
    var sportName : String
    var sportPhoto : UIImage
    var sportType:SportsType
}


class ViewController: UIViewController , UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout , UICollectionViewDataSource  {

    
    var connectionNetwork:CheckNetworkConnectivity?

    
    // Table Holder
    @IBOutlet var SportCollection: UICollectionView!
    var sportsArr = [Sports]()
    
    override func viewWillAppear(_ animated: Bool) {
        connectionNetwork = CheckNetworkConnectivity.initConncetion
        connectionNetwork?.startConncetionObserver()

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    
    
    
    // Update Table
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sportsArr.append(Sports(sportName: "FootBall", sportPhoto: UIImage(named: "football")!,sportType: SportsType.football))
        sportsArr.append(Sports(sportName: "BasketBall", sportPhoto: UIImage(named: "basketball")!,sportType: SportsType.basketball))
        sportsArr.append(Sports(sportName: "Cricket", sportPhoto: UIImage(named: "cricket")!,sportType: SportsType.cricket))
        sportsArr.append(Sports(sportName: "Tennis", sportPhoto: UIImage(named: "tennis")!,sportType: SportsType.tennis))
    }
    
    

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        let sport = sportsArr[indexPath.row]
        cell.setCell(name: sport.sportName, photo: sport.sportPhoto)
        return cell
    }
    

    // ****** Click Node ******* //
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (connectionNetwork?.getReachablility().connection != .unavailable){

            let table = self.storyboard?.instantiateViewController(withIdentifier: "LeagueTableViewController") as! LeagueTableViewController
            table.sportType = sportsArr[indexPath.row].sportType
            self.navigationController?.pushViewController(table, animated: true)
            
        }else {

            let alert = UIAlertController(title: "No Internet Connection", message: "Please check your connection and try again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(alert, animated: true)
        }
        

        
        
    }
    
    
    // ****** Handle Size ******* //

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportsArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: self.view.frame.width * 0.493, height: self.view.frame.width * 0.49)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 120, left: 1, bottom: 20, right: 1)
    }
}
