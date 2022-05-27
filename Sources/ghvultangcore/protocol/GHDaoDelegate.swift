//
//  File.swift
//  
//
//  Created by Javier Carapia on 03/05/22.
//

import ghgungnircore

public protocol GHDaoDelegate {
    associatedtype T
    
    func get<U>(id: U) throws -> T?
    func getAll(closure: @escaping ([T]) -> ()) throws
    
    func save(model: T, closure: @escaping (Bool) -> ()) throws
    func saveAll(list: [T]) throws
    
    func update(model: T) throws
    func delete<U>(id: U) throws
    
    func deleteAll() throws
}

public extension GHDaoDelegate {
    func get<U>(id: U) throws -> T? {
        throw GHError.make(message: "get not implemented")
    }
    
    func getAll(closure: @escaping ([T]) -> ()) throws {
        throw GHError.make(message: "getAll not implemented")
    }
    
    func save(model: T, closure: @escaping (Bool) -> ()) throws {
        throw GHError.make(message: "save not implemented")
    }
    
    func saveAll(list: [T]) throws {
        throw GHError.make(message: "saveAll not implemented")
    }
    
    func update(model: T) throws {
        throw GHError.make(message: "update not implemented")
    }
    
    func delete<U>(id: U) throws {
        throw GHError.make(message: "delete not implemented")
    }
    
    func deleteAll() throws {
        throw GHError.make(message: "deleteAll not implemented")
    }
}
