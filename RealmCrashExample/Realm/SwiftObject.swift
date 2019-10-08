//
//  SwiftObject.swift
//  RealmCrashExample
//
//  Created by Uwe Meier on 08.10.19.
//  Copyright © 2019 Uwe Meier. All rights reserved.
//

import UIKit
import Realm
import Realm.Dynamic

class SwiftObject: RLMObject {
    
    @objc dynamic var id: String!
    @objc dynamic var type: String!
    @objc dynamic open var version: Int64 = 0
    @objc dynamic open var time: Date = Date()
    
    override class func primaryKey() -> String? {
        return "id"
    }

    open class func buildSubclass() -> RLMObject.Type? {
        
        guard let superClass = SwiftObject.classForCoder() as? SwiftObject.Type else {
            return nil
        }
        
        let className = "ObjectiveCObject"
        
        // check if this class already exists and if so, don't build it again
        if (objc_getClass(className) as? AnyClass) != nil {
            return nil
        }
        
        // create a new Class
        guard let cls = objc_allocateClassPair(superClass, className, 0) as? SwiftObject.Type else {
            return nil
        }
        
        // register the new Class
        objc_registerClassPair(cls)
        
        return NSClassFromString(className) as? SwiftObject.Type
    }
}
