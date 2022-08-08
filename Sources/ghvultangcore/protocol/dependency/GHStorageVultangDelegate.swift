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
    init(queue: DispatchQueue?)
    
    func removeReferenceContext()
}
