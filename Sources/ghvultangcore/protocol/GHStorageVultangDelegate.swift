//
//  File.swift
//  
//
//  Created by Javier Carapia on 27/04/22.
//

import Foundation

public protocol GHStorageVultangDelegate {
    var delegate: GHVultangCoreDelegate? { get set }
    
    init()
    
    func submitRequest(bundle: Bundle) -> Bool
    
    func cancelAllRequest()
    func removeReferenceContext()
}
