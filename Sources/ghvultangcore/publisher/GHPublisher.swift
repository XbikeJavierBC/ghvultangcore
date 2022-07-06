//
//  File.swift
//  
//
//  Created by Javier Carapia on 08/06/22.
//

import Foundation
import Combine

@available(iOS 13.0, *)
struct GHPublisher<Output, Failure: Swift.Error>: Publisher {
    public typealias Output = Output
    public typealias Failure = Failure
    
    private let initialValue: Output?
    
    init(initialValue: Output? = nil) {
        self.initialValue = initialValue
    }
    
    func receive<S>(subscriber: S) where S: Subscriber, S.Failure == Failure, S.Input == Output {
        subscriber.receive(subscription: GHSubscription<Output, Failure>(subscriber: subscriber, initialValue: initialValue))
    }
    
    private final class GHSubscription<Output, Failure: Error>: Subscription {
        private var subscriber: AnySubscriber<Output, Failure>?
        private var initialValue: Output?
        
        init<S>(
            subscriber: S,
            initialValue: Output?
        ) where S: Subscriber, Failure == S.Failure, Output == S.Input {
            self.subscriber = AnySubscriber(subscriber)
            self.initialValue = initialValue
        }
        
        func request(_ demand: Subscribers.Demand) {
            if let subscriber = self.subscriber {
                if let initialValue = self.initialValue {
                    _ = subscriber.receive(initialValue)
                }
            }
        }
        
        func cancel() {
            self.subscriber = nil
        }
    }
}
