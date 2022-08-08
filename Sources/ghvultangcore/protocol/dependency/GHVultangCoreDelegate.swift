//
//  File.swift
//  
//
//  Created by Javier Carapia on 27/04/22.
//

import Foundation

public protocol GHVultangCoreDelegate: AnyObject {
    func fetchDataFail(identifier: Any, code: Int, data: NSDictionary, whith error: Error)
}
