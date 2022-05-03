//
//  File.swift
//  
//
//  Created by Javier Carapia on 03/05/22.
//

public protocol GHDaoDelegate {
    associatedtype T
    
    func get(id: Int) -> T?
    func getAll(closure: @escaping ([T]) -> ())
    
    func save(model: T, closure: @escaping (Bool) -> ())
    func saveAll(list: [T])
    
    func update(model: T)
    func delete(id: Int)
    
    func deleteAll()
}
