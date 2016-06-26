//
//  UpdateController.swift
//  Workshop_CoreData
//
//  Created by Macintosh on 6/26/2559 BE.
//  Copyright © 2559 Macintosh. All rights reserved.
//

import UIKit
import RealmSwift

class UpdateController: UIViewController{
    
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var birth: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var sex: UITextField!
    @IBOutlet weak var career: UITextField!
    @IBOutlet weak var profileImage: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewDidAppear(animated: Bool) {
        
    }
   
    
    @IBAction func profilePicBtn(sender: AnyObject) {
    }
    
}
