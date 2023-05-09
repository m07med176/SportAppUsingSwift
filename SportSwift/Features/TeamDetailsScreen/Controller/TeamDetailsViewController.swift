//
//  TeamDetailsViewController.swift
//  SportSwift
//
//  Created by Mohamed on 05/05/2023.
//

import UIKit

protocol TeamDetailsDelegateView{
    func fetchResult(result:TeamDetailsResult)
    func fetchError(error:CallDataException )
}
class TeamDetailsViewController: UIViewController,TeamDetailsDelegateView {


    var presenter:TeamDetailsPresenter?
    
    var sportType:SportsType = SportsType.football
    var teamId:Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = TeamDetailsPresenter(view: self)
        presenter?.fetchTeamData(sportType: sportType, teamId: teamId)
    }
    
    
    func fetchResult(result: TeamDetailsResult) {
  
    }
    
    func fetchError(error: CallDataException) {
    
        
    }
    

}
