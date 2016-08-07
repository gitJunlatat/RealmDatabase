//
//  UpdateController.swift
//  Workshop_CoreData
//
//  Created by Macintosh on 6/26/2559 BE.
//  Copyright © 2559 Macintosh. All rights reserved.
//

import UIKit
import RealmSwift

class UpdateController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    private var sender = 0
    var state:String = ""
    
    // outlet
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var birth: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var sex: UITextField!
    @IBOutlet weak var career: UITextField!
    @IBOutlet weak var profileImage: UIButton!
    
    @IBOutlet weak var image1: UIButton!
    @IBOutlet weak var image2: UIButton!
    @IBOutlet weak var image3: UIButton!
    @IBOutlet weak var image4: UIButton!
    
    @IBOutlet weak var t_Interest1: UITextField!
    @IBOutlet weak var t_Interest2: UITextField!
    @IBOutlet weak var t_Interest3: UITextField!
    @IBOutlet weak var t_Interest4: UITextField!
    
    
    @IBOutlet weak var done: UIBarButtonItem!
    
    
    // instance
    var x = 1
    
    
    var imagePicker = UIImagePickerController()
    var dao = DAOPersonal()
    var userInfo = Person()
    var interest1 = Interest()
    var interest2 = Interest()
    var interest3 = Interest()
    var interest4 = Interest()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "ADD"

        if self.state == "update" {
            showed_Old_Data()
        }else{
            self.navigationItem.title = "ADD"
        }
    }
    override func viewWillAppear(animated: Bool) {
      self.navigationItem.title = "ADD"
    }
    
    func showed_Old_Data(){
        let imageData = userInfo.picture
        let imageData1 = userInfo.interests[0].image
        let imageData2 = userInfo.interests[1].image
        let imageData3 = userInfo.interests[2].image
        let imageData4 = userInfo.interests[3].image

        self.profileImage.setBackgroundImage(UIImage(data: imageData!), forState: .Normal)
        self.image1.setBackgroundImage(UIImage(data: imageData1!), forState: .Normal)
        self.image2.setBackgroundImage(UIImage(data: imageData2!), forState: .Normal)
        self.image3.setBackgroundImage(UIImage(data: imageData3!), forState: .Normal)
        self.image4.setBackgroundImage(UIImage(data: imageData4!), forState: .Normal)
        
        self.t_Interest1.text = userInfo.interests[0].interest
        self.t_Interest2.text = userInfo.interests[1].interest
        self.t_Interest3.text = userInfo.interests[2].interest
        self.t_Interest4.text = userInfo.interests[3].interest

        self.name.text = userInfo.name
        self.age.text = String(userInfo.age)
        self.birth.text = userInfo.birth
        self.sex.text = userInfo.sex
        self.career.text = userInfo.career
        
        
    }
    func imageConvert() -> [NSData]{
        let imageProfile:UIImage = self.profileImage.currentBackgroundImage! as UIImage
        let imageProfileData:NSData = UIImageJPEGRepresentation(imageProfile, 0)!
        
        let image1:UIImage = self.image1.currentBackgroundImage! as UIImage
        let imageData1:NSData = UIImageJPEGRepresentation(image1, 0)!
        
        let image2:UIImage = self.image2.currentBackgroundImage! as UIImage
        let imageData2:NSData = UIImageJPEGRepresentation(image2, 0)!
        
        let image3:UIImage = self.image3.currentBackgroundImage! as UIImage
        let imageData3:NSData = UIImageJPEGRepresentation(image3, 0)!
        
        let image4:UIImage = self.image4.currentBackgroundImage! as UIImage
        let imageData4:NSData = UIImageJPEGRepresentation(image4, 0)!
        
        var arr:[NSData] = NSArray() as! [NSData]
        arr += [imageProfileData,imageData1,imageData2,imageData3,imageData4]
        return arr
    }
    
    
    func update(){
        var arrImage:[NSData] = imageConvert()

        var updatePersonal = ["picture":arrImage[0],
                              "name":self.name.text!,
                              "birth":self.birth.text!,
                              "age":Int(self.age.text!)!,
                              "sex":self.sex.text!,
                              "career":self.career.text!,
                              "uuid":userInfo.uuid]
        
        var updateInterests = ["image1":arrImage[1],
                               "image2":arrImage[2],
                               "image3":arrImage[3],
                               "image4":arrImage[4],
                               "t_interest1":self.t_Interest1.text!,
                               "t_interest2":self.t_Interest2.text!,
                               "t_interest3":self.t_Interest3.text!,
                               "t_interest4":self.t_Interest4.text!]
        dao.update(updatePersonal,interests: updateInterests)
        let alert = UIAlertController(title: "Alert", message: "Update Success", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func add(){
        var arrImage:[NSData] = imageConvert()
        // profile
        userInfo.picture = arrImage[0]
        userInfo.name = self.name.text!
        userInfo.age = Int(self.age.text!)!
        userInfo.birth = self.birth.text!
        userInfo.sex = self.sex.text!
        userInfo.career = self.career.text!
        
        
        // interest
        interest1.image = arrImage[1]
        interest2.image = arrImage[2]
        interest3.image = arrImage[3]
        interest4.image = arrImage[4]
        interest1.interest = self.t_Interest1.text!
        interest2.interest = self.t_Interest2.text!
        interest3.interest = self.t_Interest3.text!
        interest4.interest = self.t_Interest4.text!
        
        userInfo.interests.append(interest1)
        userInfo.interests.append(interest2)
        userInfo.interests.append(interest3)
        userInfo.interests.append(interest4)
        
        dao.addPersonal(userInfo)
        let alert = UIAlertController(title: "Alert", message: "Add Success", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    
    @IBAction   func Done(sender: AnyObject) {
        if state == "update"{
            update()
        }else{
            add()
        }
    }
    
    
    @IBAction  func PicBtn(sender: AnyObject) {
        
        self.sender = sender.tag
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum;
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
        
        switch self.sender {
        case 0:
            self.profileImage.setBackgroundImage(image, forState: .Normal)
        case 1:
            self.image1.setBackgroundImage(image, forState: .Normal)
        case 2:
            self.image2.setBackgroundImage(image, forState: .Normal)
        case 3:
            self.image3.setBackgroundImage(image, forState: .Normal)
        case 4:
            self.image4.setBackgroundImage(image, forState: .Normal)
        default:
            print("other tag")
        }
        
        
    }
    
}

