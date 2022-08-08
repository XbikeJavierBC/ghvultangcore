//
//  File.swift
//  
//
//  Created by Javier Carapia on 08/08/22.
//

import Foundation
import RealmSwift

public class GHLogRealmEntity: Object {
    @Persisted(primaryKey: true)
    var id: Int = -1
    
    @Persisted
    var status: Bool = false
    
    @Persisted
    var responseStr: String = .empty
    
    @Persisted
    var requestStr: String = .empty
    
    @Persisted
    var date: String = .empty
}
