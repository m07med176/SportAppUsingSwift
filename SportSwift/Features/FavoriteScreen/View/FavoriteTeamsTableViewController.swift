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

class FavoriteTeamsTableViewController: UIViewController,UITableViewDataSource, UITableViewDelegate,FavoriteTeamsDelegateView {
    @IBOutlet weak var favoriteTable: UITableView!
    
    var presenter:FavoritePresenter?
    
    var favoriteItem:[FavoriteTeam] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = FavoritePresenter(view: self)
//        presenter?.fetchData()
    }

  
    func fetchResult(result: [FavoriteTeam]) {
        favoriteItem = result
        favoriteTable.reloadData()
        
    }
    
    func fetchError(error: CallDataException) {
        
    }
  

    
    
    
    
    // DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteItem.count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = favoriteTable.dequeueReusableCell(withIdentifier: "favoritecell") as! FavoriteTeamsTableViewCell
        //        cell.c
        let favoritePlayer = favoriteItem[indexPath.row]

        cell.FavoriteTeamName.text = favoritePlayer.name
        
        //MARK: - make the cell look round
        cell.FavoriteTeamView.layer.cornerRadius = cell.contentView.frame.height / 2.5
        //make the image look round
        cell.FavoriteTeamImage.layer.cornerRadius = cell.FavoriteTeamImage.frame.height / 2.5
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Remove the corresponding data item from your data source
            let favoritePlayer = favoriteItem[indexPath.row]

            // Create an alert controller
            let alert = UIAlertController(title: "Remove Team", message: "Are you sure you want to remove \(favoritePlayer.name) from favorites?", preferredStyle: .alert)
            
            // Add actions to the alert controller
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Remove", style: .destructive, handler: { _ in
                
                // Remove the player name from favorites
           
                
                self.presenter?.deleteData(item: favoritePlayer)
                // Delete the row from the table view with an animation
                tableView.deleteRows(at: [indexPath], with: .fade)
                self.favoriteTable.reloadData()
            }))
            
            // Present the alert controller
            self.present(alert, animated: true, completion: nil)
        }}
    
    
    //Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection
                                section: Int) -> String? {
       return "Favorites"
    }
    
}
