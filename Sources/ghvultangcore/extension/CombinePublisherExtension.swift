//
//  File.swift
//  
//
//  Created by Javier Carapia on 27/05/22.
//

import Foundation
import Combine
import Realm
import RealmSwift
import ghgungnircore

@available(iOS 13.0, *)
extension Publisher {
    func writeObject<T: Object>(type: T.Type, receiveOn callbackQueue: DispatchQueue) -> AnyPublisher<T, Error> where Output == Any, Failure == Error {
        let publisher = self
            .flatMap { value in
                AddObject(type: type, value: value)
            }
            /*.subscribe(on: callbackQueue)
            .threadSafeReference()
            .receive(on: callbackQueue)*/
        
        return publisher.eraseToAnyPublisher()
    }
}

@available(iOS 13.0, *)
struct AddObject<T: Object>: Publisher {
    public typealias Output = T // 1
    public typealias Failure = Error // 2
    
    private let type: T.Type
    private let value: Any

    init(type: T.Type, value: Any) {
        self.type = type
        self.value = value
    }

    func receive<S>(subscriber: S) where S: Subscriber, S.Failure == Failure, S.Input == Output {
        subscriber.receive(subscription: RealmWriteSubscription(subscriber: subscriber, type: type, value: value))
    }
}

@available(iOS 13.0, *)
class RealmWriteSubscription<S: Subscriber, T: Object>: Subscription where S.Input == T, S.Failure == Error {
    private var subscriber: S?
    private let type: T.Type
    private let value: Any
    private var result: Result<T, Error>?
    
    init(subscriber: S, type: T.Type, value: Any) {
        self.subscriber = subscriber
        self.type = type
        self.value = value
    }

    func request(_ demand: Subscribers.Demand) { // 2
        switch result {
            case .success(let object):
                _ = subscriber?.receive(object)
            case .failure(let error):
                subscriber?.receive(completion: .failure(error))
            case nil:
                addToRealm()
        }
    }
    
    func cancel() { // 3
        subscriber = nil
    }
    
    private func addToRealm() {
        do {
            guard let realm = GHRealmCore().core else {
                result = .failure(GHError.make(message: "Error instance realm"))
                subscriber?.receive(completion: .failure(GHError.make(message: "Error instance realm")))
                
                return
            }
            
            let object: T
            if realm.isInWriteTransaction {
                object = realm.create(type, value: value)
            }
            else {
                realm.beginWrite()
                object = realm.create(type, value: value)
                try realm.commitWrite()
            }
            result = .success(object)
            _ = subscriber?.receive(object) // 4
            subscriber?.receive(completion: .finished) // 5
        }
        catch {
            result = .failure(error)
            subscriber?.receive(completion: .failure(error)) // 6
        }
    }
}
