//
//  File.swift
//  
//
//  Created by Javier Carapia on 08/06/22.
//

import Foundation
import Combine

@available(iOS 13.0, *)
class GHPropertyLocalRepository {
    private var subscriber: AnyCancellable?
    
    func foo() -> AnyPublisher<Property, Error> {
        let jsonPublisher = Result<Any, Error>.Publisher(
            .success(
                [
                    "id": UUID().uuidString,
                    "streetAddress": "Avenida de Pruneridge, 19111"
                ]
            )
        )
        
        return jsonPublisher
            .writeObject(type: Property.self, receiveOn: .main)
            .eraseToAnyPublisher()
    }
}
