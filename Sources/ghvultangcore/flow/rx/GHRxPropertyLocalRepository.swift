//
//  File.swift
//  
//
//  Created by Javier Carapia on 08/06/22.
//

import Foundation
import Combine

@available(iOS 13.0, *)
internal class GHRxPropertyLocalRepository {
    private var subscriber: AnyCancellable?
    
    func save() -> AnyPublisher<GHPropertyRealmEntity, Error> {
        let jsonPublisher = Result<Any, Error>.Publisher(
            .success(
                [
                    "id": UUID().uuidString,
                    "streetAddress": "Avenida de Pruneridge, 19111"
                ]
            )
        )
        
        return jsonPublisher
            .writeObject(type: GHPropertyRealmEntity.self, receiveOn: .main)
            .eraseToAnyPublisher()
    }
}
