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
    
    func get(id: U) throws -> AnyPublisher<T, Error>?
    func getAll() throws -> AnyPublisher<[T], Error>?
    
    func save(model: T) throws -> AnyPublisher<Bool, Error>?
    func saveAll(modelList: [T]) throws -> AnyPublisher<Bool, Error>?
    
    func delete(id: U) throws -> AnyPublisher<Bool, Error>?
    
    func deleteAll() throws -> AnyPublisher<Bool, Error>?
}
