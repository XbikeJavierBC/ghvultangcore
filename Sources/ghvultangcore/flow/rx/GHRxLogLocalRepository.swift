//
//  File.swift
//  
//
//  Created by Javier Carapia on 08/08/22.
//

import Foundation
import Combine
import RealmSwift
import ghgungnircore

@available(iOS 13.0, *)
public class GHRXLogLocalRepository: GHRxDaoDelegate {
    public typealias T = GHLogModel
    public typealias U = Int
    private let coreNotFound = "Core not initialice"
    
    public func get(id: Int) throws -> AnyPublisher<GHLogModel, Error>? {
        guard let realm = GHRealmCore().core else {
            return Fail(
                error: GHError.make(message: self.coreNotFound)
            ).eraseToAnyPublisher()
        }
        
        return realm.objects(GHLogRealmEntity.self)
            .collectionPublisher
            .tryMap { GHLogRealmConverter.entityToModel(entity: $0.filter { $0.id == id }.first) }
            .eraseToAnyPublisher()
    }
    
    public func getAll() -> AnyPublisher<[GHLogModel], Error>? {
        guard let realm = GHRealmCore().core else {
            return Fail(
                error: GHError.make(message: self.coreNotFound)
            ).eraseToAnyPublisher()
        }
        
        return realm.objects(GHLogRealmEntity.self)
            .collectionPublisher
            .tryMap { $0.map { GHLogRealmConverter.entityToModel(entity: $0) } }
            .eraseToAnyPublisher()
    }
    
    public func save(model: GHLogModel) -> AnyPublisher<Bool, Error>? {
        return GHPublisher<GHLogRealmEntity, Error>(initialValue: GHLogRealmConverter.modelToEntity(model: model))
            .tryMap { realmEntity in
                guard let realm = GHRealmCore().core else {
                    throw GHError.make(message: self.coreNotFound)
                }
                
                try realm.write {
                    realm.add(realmEntity, update: .modified)
                }
                return true
            }
            .eraseToAnyPublisher()
    }
    
    public func saveAll(modelList: [GHLogModel]) -> AnyPublisher<Bool, Error>? {
        let list = modelList.map { GHLogRealmConverter.modelToEntity(model: $0) }
        
        return GHPublisher<[GHLogRealmEntity], Error>(initialValue: list)
            .tryMap { realmEntity in
                guard let realm = GHRealmCore().core else {
                    throw GHError.make(message: self.coreNotFound)
                }
                
                try realm.write {
                    realm.add(realmEntity, update: .modified)
                }
                return true
            }
            .eraseToAnyPublisher()
    }
    
    public func delete(id: Int) -> AnyPublisher<Bool, Error>? {
        guard let realm = GHRealmCore().core else {
            return Fail(
                error: GHError.make(message: self.coreNotFound)
            ).eraseToAnyPublisher()
        }
        
        return realm.objects(GHLogRealmEntity.self)
            .collectionPublisher
            .tryMap {
                guard let realmEntity = $0
                    .filter("id == \(id)")
                    .first else  {
                    return false
                }
                
                try realm.write {
                    realm.delete(realmEntity)
                }
                
                return true
            }
            .eraseToAnyPublisher()
    }
    
    public func deleteAll() -> AnyPublisher<Bool, Error>? {
        guard let realm = GHRealmCore().core else {
            return Fail(
                error: GHError.make(message: self.coreNotFound)
            ).eraseToAnyPublisher()
        }
        
        return realm.objects(GHLogRealmEntity.self)
            .collectionPublisher
            .tryMap { elements in
                try realm.write {
                    realm.delete(elements)
                }
                
                return true
            }
            .eraseToAnyPublisher()
    }
}
