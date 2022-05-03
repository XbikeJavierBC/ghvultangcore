//
//  File.swift
//  
//
//  Created by Javier Carapia on 27/04/22.
//

import Foundation
import ghgungnircore

public class GHVultangCore: GHVultangCoreDelegate {
    internal var coreStorageDelegate: GHStorageVultangDelegate?
    public var delegate: GHVultangCoreDelegate?
    public var bundle: Bundle!

    public init(bundle: Bundle, idStorege: GHStorageCoreType) throws {
        let strClass = idStorege.getClass()
        
        guard let classCoreService = NSClassFromString(strClass) as? GHStorageVultangDelegate.Type else {
            throw GHStorageErrorCore.coreNotFound
        }
        
        self.coreStorageDelegate = classCoreService.init()
        
        self.coreStorageDelegate?.delegate = self
        self.bundle = bundle
    }
    
    public func fetchDataFail(identifier: Any, code: Int, data: NSDictionary, whith error: Error) {
        
    }
}
