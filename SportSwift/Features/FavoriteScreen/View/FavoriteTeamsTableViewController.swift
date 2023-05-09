//
//  FavoriteTeamsTableViewController.swift
//  SportSwift
//
//  Created by Mohamed on 09/05/2023.
//

import UIKit


protocol FavoriteTeamsDelegateView {
    func fetchResult(result:[FavoriteTeam])
    func fetchError(error:CallDataException )
}

class FavoriteTeamsTableViewController: UIViewController,FavoriteTeamsDelegateView {

    var presenter:FavoritePresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = FavoritePresenter(view: self)
        presenter?.fetchData()
    }

  
    func fetchResult(result: [FavoriteTeam]) {
        
    }
    
    func fetchError(error: CallDataException) {
        
    }
  

}
