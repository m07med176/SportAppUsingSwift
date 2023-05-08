//
//  TeamDetailsViewController.swift
//  SportSwift
//
//  Created by Mohamed on 05/05/2023.
//

import UIKit

class TeamDetailsViewController: UIViewController {

    var teamIndex = 0
    var sportType = ""
    var teamKey = ""
    var teeamImg = ""
    var dataTeam : TeamResponse?
    var playerData : TeamResponseNew?
    var favArray = [String]()
    var keyFav = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
