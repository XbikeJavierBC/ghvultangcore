//
//  File.swift
//  
//
//  Created by Javier Carapia on 27/04/22.
//

import Foundation

public enum GHStorageCoreType {
    case Realm
    case CoreData
    
    func getClass() -> String {
        var nameClass: String = .empty
        
        switch self {
        case .Realm:
                nameClass = String(
                    format: "%@.%@",
                    arguments: [
                        "ghvultangcore",
                        "GHRealmCore"
                    ]
                )
            case .CoreData:
                nameClass = String(
                    format: "%@.%@",
                    arguments: [
                        "ghvultangcore",
                        "GHCoreDataCore"
                    ]
                )
        }
        
        return nameClass
    }
}
