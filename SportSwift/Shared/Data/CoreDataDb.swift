//
//  CoreDataDb.swift
//  Salary
//
//  Created by Mohamed on 26/04/2023.
//

import Foundation
import CoreData
import UIKit

class CoreDataDb{
    let entityName = "FavoriteTeam"
    
    static let initCoreData=CoreDataDb()
    var context: NSManagedObjectContext!
    var empObj:[NSManagedObject]!
    var allEmpObj:[NSManagedObject]!
    
    private init(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        
    }
    
    func insertData(item:FavoriteTeam!) throws {
        
        if(item == nil){
            return
        }
        let entity=NSEntityDescription.entity(forEntityName: entityName, in: context!)
        let emp=NSManagedObject(entity: entity!, insertInto: context)
        
        emp.setValue(item.key , forKey: "key")
        emp.setValue(item.name, forKey: "name")
        emp.setValue(item.sport, forKey: "sport")
        emp.setValue(item.logo, forKey: "logo")
        
        do{
            try context?.save()
        }
        catch let error as NSError{
            print(error.localizedDescription)
            throw CallDataException.mainError(message: error.localizedDescription)
        }
        
    }
    
    func fetchData() throws ->Array<FavoriteTeam>! {
        var arr:Array<FavoriteTeam>!=[]
        let fetchReq=NSFetchRequest<NSManagedObject>(entityName: entityName)
        do{
            empObj = try context?.fetch(fetchReq)
            for emp in empObj!{
                arr.append(FavoriteTeam(
                    key: emp.value(forKey: "key") as? Int ?? 0,
                    name: emp.value(forKey: "name") as? String ?? "unKown",
                    logo: emp.value(forKey: "logo") as? String ?? "",
                    sport: emp.value(forKey: "sport") as? String ?? "football"))
            }
        }
        
        catch let error as NSError{
            print(error.localizedDescription)
            throw CallDataException.mainError(message: error.localizedDescription)
        }
        
        if arr.count == 0{
            throw CallDataException.noDateError(message: "No Data")
        }
        return arr;
    }
    
    
    func isExistItem(item:FavoriteTeam) throws ->Bool{
        var status:Bool = false
        let data  = try fetchData() ?? []
        for fav in data {
            status = fav.key == item.key
            break
        }
        return status
    }
    
    func deleteData(item:FavoriteTeam) throws {
        let fetchReq=NSFetchRequest<NSManagedObject>(entityName: entityName)
        let predicate=NSPredicate(format: "key==%@", item.key)
        fetchReq.predicate=predicate
        do{
            empObj = try context?.fetch(fetchReq)
            context?.delete(empObj![0])
            try context?.save()
        }
        catch let error as NSError{
            print(error.localizedDescription)
            throw CallDataException.mainError(message: error.localizedDescription)
        }
        
    }
    
}

