//
//  Personal.swift
//  Workshop_CoreData
//
//  Created by Macintosh on 6/25/2559 BE.
//  Copyright © 2559 Macintosh. All rights reserved.
//

import RealmSwift
import UIKit
class Person: IdentifiableObject {
    
    dynamic var picture:NSData? = nil
    dynamic var name = ""
    dynamic var lastName = ""
    dynamic var age = 0
    dynamic var birth = ""
    dynamic var career = ""
    dynamic var sex = ""
    dynamic var title = ""
    let interests = List<Interest>()
    

}
