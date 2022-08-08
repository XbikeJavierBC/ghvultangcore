//
//  File.swift
//  
//
//  Created by Javier Carapia on 03/05/22.
//

import ghgungnircore

public protocol GHDaoDelegate {
    associatedtype T
    associatedtype U
    
    func get(id: U) throws -> T?
    func getAll(closure: @escaping ([T]) -> ()) throws
    
    func save(model: T, closure: @escaping (Bool) -> ()) throws
    func saveAll(list: [T], closure clousure: @escaping (Bool) -> ()) throws
    
    func delete(id: U) throws
    
    func deleteAll() throws
}
