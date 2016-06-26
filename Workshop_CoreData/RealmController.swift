//
//  ViewController.swift
//  Workshop_CoreData
//
//  Created by Macintosh on 6/25/2559 BE.
//  Copyright © 2559 Macintosh. All rights reserved.
//

import UIKit

class RealmController: UIViewController,UITabBarDelegate,UITableViewDataSource {
    var dao = DAOPersonal()
    var result = [Personal]()
    @IBOutlet weak var realmTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
   

        var image:UIImage = UIImage(named: "yothin.JPG")!
        var imageData:NSData = UIImageJPEGRepresentation(image, 0)!
        
     
        // Do any additional setup after loading the view, typically from a nib.
      var yothin = Personal(value: ["id":0,"picture":imageData,"name":"Yothin","lastName":"Junlatat","age":22,"date":"April 12, 1994","sex":"Male","career":"ios developer"])
        dao.addPersonal(yothin)
        result = dao.getPersonal()
        print(result.count)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let realmCell = tableView.dequeueReusableCellWithIdentifier("realm") as! RealmTableCell
        realmCell.name.text =  result[indexPath.row]["name"] as! String + " "
        realmCell.name.text? += result[indexPath.row]["lastName"] as! String
        let imageData = result[indexPath.row]["picture"] as! NSData
        realmCell.profilePicture.image = UIImage(data: imageData)
        print(String(result[indexPath.row]["id"]!))
        realmCell.age.text = String(result[indexPath.row]["age"]!)
        realmCell.birth.text = result[indexPath.row]["date"] as! String
        realmCell.career.text = result[indexPath.row]["career"] as! String
        realmCell.sex.text = result[indexPath.row]["sex"] as! String
        return realmCell
    }
    
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let update = UITableViewRowAction(style: .Default, title: "UPDATE") { (action, indexPath) in
            let changeVC_To_UpdateVC = self.storyboard?.instantiateViewControllerWithIdentifier("UpdateVC") as! UpdateController
            self.presentViewController(changeVC_To_UpdateVC, animated: true, completion: nil)
        }
        update.backgroundColor = UIColor.blueColor()
        return [update]
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


