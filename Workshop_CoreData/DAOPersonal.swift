//
//  Realm_Model.swift
//  Workshop_CoreData
//
//  Created by Macintosh on 6/25/2559 BE.
//  Copyright © 2559 Macintosh. All rights reserved.
//

import UIKit
import RealmSwift

class DAOPersonal: Object {
    

    
    func addPersonal(person:Personal){
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(person)
        }
    }
    
    
    func getPersonal() -> [Personal]{
        let results = try! Realm().objects(Personal)
        var personals = [Personal]()
        if results.count > 0 {
            for result in results{
                let personal = result as Personal
                personals.append(personal)
            }
        }
        return personals
    }
    
    func update(id:Int,personUpdate:[String:AnyObject]){
        dispatch_async(dispatch_queue_create("background", nil)) {
            let realm = try! Realm()
            let personFilter = realm.objects(Personal).filter("id == \(id)").first
            try! realm.write {
                personFilter!.name = personUpdate["name"] as! String
                personFilter?.lastName = personUpdate["lastName"] as! String
                personFilter?.age = personUpdate["age"] as! Int
                personFilter?.date = personUpdate["date"] as! String
                personFilter?.career = personUpdate["career"] as! String
                
            }
        }
    }

}
