//
//  File.swift
//  
//
//  Created by Javier Carapia on 08/08/22.
//

import Foundation
import RealmSwift

public class GHLogStorage: GHDaoDelegate {
    public typealias T = GHLogModel
    
    private let serialQueue = DispatchQueue(label: "serial-queue")
    private var realm: Realm?
    
    public init() {
        self.realm = GHRealmCore(queue: self.serialQueue).core
    }
    
    public func get(id: Int) -> GHLogModel? {
        return nil
    }
    
    public func getAll(closure clousure: @escaping ([GHLogModel]) -> ()) {
        guard let realm = self.realm else {
            clousure([])
            return
        }
        
        let realmList = realm.objects(GHLogRealmEntity.self)
        
        let listModel: [GHLogModel] = realmList.map {
            GHLogRealmConverter.entityToModel(entity: $0)
        }
        
        clousure(listModel)
    }
    
    public func save(model: GHLogModel, closure clousure: @escaping (Bool) -> ()) {
        do {
            guard let realm = self.realm else {
                clousure(false)
                return
            }
            
            let realmEntity = GHLogRealmConverter.modelToEntity(model: model)
            try realm.write {
                realm.add(realmEntity, update: .modified)
            }
            
            clousure(true)
        }
        catch let error {
            debugPrint(error.localizedDescription)
            clousure(false)
        }
    }
    
    public func saveAll(list: [GHLogModel], closure clousure: @escaping (Bool) -> ()) {
        do {
            guard let realm = self.realm else {
                clousure(false)
                return
            }
            
            try list.forEach { model in
                let realmEntity = GHLogRealmConverter.modelToEntity(model: model)
                try realm.write {
                    realm.add(realmEntity, update: .modified)
                }
            }
            
            clousure(true)
        }
        catch let error {
            debugPrint(error.localizedDescription)
            clousure(false)
        }
    }
    
    public func delete(id: Int) {
        guard let realm = self.realm else { return }
        
        let realmList = realm.objects(GHLogRealmEntity.self)
        
        guard let realmEntity = realmList
                .filter("id == '\(id)'")
                .first else  {
                return
        }
        
        do {
            try realm.write {
                realm.delete(realmEntity)
            }
        }
        catch let error {
            debugPrint(error.localizedDescription)
        }
    }
    
    public func deleteAll() {
        guard let realm = self.realm else { return }
        
        do {
            try realm.write {
                realm.deleteAll()
            }
        }
        catch let error {
            debugPrint(error.localizedDescription)
        }
    }
}
