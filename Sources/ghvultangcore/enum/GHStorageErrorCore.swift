//
//  File.swift
//  
//
//  Created by Javier Carapia on 27/04/22.
//

import Foundation

public enum GHStorageErrorCore: Error {
    case coreNotFound
    
    public var description: String {
        switch self {
            case .coreNotFound:
                return "Core Not Found. Install \(self) Core."
        }
    }
}
