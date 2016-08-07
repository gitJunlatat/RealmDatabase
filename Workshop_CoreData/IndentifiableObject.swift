//
//  IndentifiableObject.swift
//  Workshop_CoreData
//
//  Created by Macintosh on 7/7/2559 BE.
//  Copyright © 2559 Macintosh. All rights reserved.
//

import RealmSwift

class IdentifiableObject : Object {
    private(set) dynamic var uuid = NSUUID().UUIDString
}
