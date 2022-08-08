//
//  File.swift
//  
//
//  Created by Javier Carapia on 08/08/22.
//

import Combine

@available(iOS 13.0, *)
public protocol GHRxDaoDelegate {
    associatedtype T
    associatedtype U
    
    static func get(id: U) throws -> AnyPublisher<T, Error>?
    static func getAll() throws -> AnyPublisher<[T], Error>?
    
    static func save(model: T) throws -> AnyPublisher<Bool, Error>?
    static func saveAll(modelList: [T]) throws -> AnyPublisher<Bool, Error>?
    
    static func delete(id: U) throws -> AnyPublisher<Bool, Error>?
    
    static func deleteAll() throws -> AnyPublisher<Bool, Error>?
}
