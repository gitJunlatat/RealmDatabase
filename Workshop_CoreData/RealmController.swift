 
 import UIKit
 
 class RealmController: UIViewController{
    var dao = DAOPersonal()
    var result = [Person]()
    
    
    var indexPath:Int = 0
    @IBOutlet weak var realmTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updatePerson()
    }
    
    func updatePerson(){
        
        result = dao.getPersonal()
        dispatch_async(dispatch_get_main_queue()){
            self.realmTable.reloadData()
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        
        let realmCell = tableView.dequeueReusableCellWithIdentifier("realm") as! RealmTableCell
        
        if result.count > 0 {
            print(result[indexPath.row].interests)
            let imageData = result[indexPath.row]["picture"] as! NSData
            let image1Data = result[indexPath.row].interests[0]["image"] as! NSData
            let image2Data = result[indexPath.row].interests[1]["image"] as! NSData
            let image3Data = result[indexPath.row].interests[2]["image"] as! NSData
            let image4Data = result[indexPath.row].interests[3]["image"] as! NSData
            
            
            realmCell.name.text   =  result[indexPath.row]["name"] as! String
            realmCell.profilePicture.image = UIImage(data: imageData)
            realmCell.age.text    = String(result[indexPath.row]["age"]!)
            realmCell.birth.text  = result[indexPath.row]["birth"] as! String
            realmCell.career.text = result[indexPath.row]["career"] as! String
            realmCell.sex.text    = result[indexPath.row]["sex"] as! String
            
            
            
            
            //interest image
            realmCell.image1.image = UIImage(data: image1Data)
            realmCell.image2.image = UIImage(data: image2Data)
            realmCell.image3.image = UIImage(data: image3Data)
            realmCell.image4.image = UIImage(data: image4Data)
            //interest label
            realmCell.t_interest1.text = result[indexPath.row].interests[0]["interest"] as! String
            realmCell.t_interest2.text = result[indexPath.row].interests[1]["interest"] as! String
            realmCell.t_interest3.text = result[indexPath.row].interests[2]["interest"] as! String
            realmCell.t_interest4.text = result[indexPath.row].interests[3]["interest"] as! String
            
            
            
        }else{
            print("not found data")
        }
        
        return realmCell
    }
    
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let update = UITableViewRowAction(style: .Default, title: "UPDATE") { (action, indexPath) in
            self.indexPath = indexPath.row as! Int
            self.performSegueWithIdentifier("UpdateVC", sender: self)
        }
        let delete = UITableViewRowAction(style: .Default, title: "DELETE") { (action, indexPath) in
            self.dao.deletePersonal(self.result[indexPath.row])
            let alert = UIAlertController(title: "Alert", message: "Delete Success", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            self.updatePerson()
        }
        
        update.backgroundColor = UIColor.blueColor()
        delete.backgroundColor = UIColor.redColor()
        return [update,delete]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "UpdateVC" {
            let updateVC:UpdateController = segue.destinationViewController as! UpdateController
            updateVC.userInfo = result[self.indexPath]
            updateVC.state = "update"
            
        }else if segue.identifier == "AddVC"{
            let updateVC:UpdateController = segue.destinationViewController as! UpdateController
            updateVC.state = "add"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func addPerson(sender: AnyObject) {
        self.performSegueWithIdentifier("AddVC", sender: self)
    }
    
 }
 
 
