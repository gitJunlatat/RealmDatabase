//
//  Realm_Model.swift
//  Workshop_CoreData
//
//  Created by Macintosh on 6/25/2559 BE.
//  Copyright © 2559 Macintosh. All rights reserved.
//

import UIKit
import RealmSwift

class DAOPersonal:Object  {
    
    func addPersonal(person:Person){
        let realm = try! Realm()
        try! realm.write {
            realm.add(person)
            
        }
    }
    
    func getPersonal() -> [Person]{
        let results = try! Realm().objects(Person)
        var personals = [Person]()
        if results.count > 0 {
            for result in results{
                let personal = result as Person
                personals.append(personal)
            }
        }
        return personals
    }
    
    
    
    func deletePersonal(_personal:Person) {
        
        let realm = try! Realm()
        try! realm.write {
            realm.delete(_personal)
        }
        NSNotificationCenter.defaultCenter().postNotificationName("updatePerson", object: nil)
    }
    
    
    
    func update(personal:[String:AnyObject],interests:[String:AnyObject]){
        dispatch_async(dispatch_queue_create("background", nil)) {
            let realm = try! Realm()
            let personFilter = realm.objects(Person.self).filter("uuid == '\(personal["uuid"] as! String)'").first
            try! realm.write {
                personFilter?.picture = personal["picture"] as! NSData
                personFilter?.name = personal["name"] as! String
                personFilter?.age = personal["age"] as! Int
                personFilter?.sex = personal["sex"] as! String
                personFilter?.birth = personal["birth"] as! String
                personFilter?.career = personal["career"] as! String
                
                personFilter?.interests[0].image = interests["image1"] as! NSData
                personFilter?.interests[1].image = interests["image2"] as! NSData
                personFilter?.interests[2].image = interests["image3"] as! NSData
                personFilter?.interests[3].image = interests["image4"] as! NSData
                
                personFilter?.interests[0].interest = interests["t_interest1"] as! String
                personFilter?.interests[1].interest = interests["t_interest2"] as! String
                personFilter?.interests[2].interest = interests["t_interest3"] as! String
                personFilter?.interests[3].interest = interests["t_interest4"] as! String


            }
            NSNotificationCenter.defaultCenter().postNotificationName("updatePerson", object: nil)
        }
    }
    
}
