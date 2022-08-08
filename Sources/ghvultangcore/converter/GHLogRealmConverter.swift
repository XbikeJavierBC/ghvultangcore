//
//  File.swift
//  
//
//  Created by Javier Carapia on 08/08/22.
//

struct GHLogRealmConverter {
    public static func modelToEntity(model: GHLogModel) -> GHLogRealmEntity {
        let realmEntity = GHLogRealmEntity()

        realmEntity.id          = model.id
        realmEntity.status      = model.status
        realmEntity.responseStr = model.responseStr
        realmEntity.requestStr  = model.requestStr
        realmEntity.date        = model.date

        return realmEntity
    }
    
    public static func entityToModel(entity: GHLogRealmEntity?) -> GHLogModel {
        guard let entity = entity else {
            return GHLogModel()
        }
        
        return GHLogModel(
            id: entity.id,
            status: entity.status,
            responseStr: entity.responseStr,
            requestStr: entity.requestStr,
            date: entity.date
        )
    }
}
