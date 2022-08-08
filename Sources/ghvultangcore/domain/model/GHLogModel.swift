//
//  File.swift
//  
//
//  Created by Javier Carapia on 08/08/22.
//

import Foundation
import ghgungnircore

public struct GHLogModel {
    public let id: Int
    public let status: Bool
    public let responseStr: String
    public let requestStr: String
    public let date: String
    
    public init() {
        self.id             = -1
        self.status         = false
        self.responseStr    = .empty
        self.requestStr     = .empty
        self.date           = .empty
    }
    
    public init(id: Int, status: Bool, responseStr: String, requestStr: String, date: String) {
        self.id          = id
        self.status      = status
        self.responseStr = responseStr
        self.requestStr  = requestStr
        self.date        = date
    }
}
