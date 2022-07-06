//
//  File.swift
//  
//
//  Created by Javier Carapia on 08/06/22.
//

import Foundation
import RealmSwift

class Property: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var streetAddress: String = ""
    @objc dynamic var city: String?
    
    override class func primaryKey() -> String? {
        return #keyPath(id)
    }
}
