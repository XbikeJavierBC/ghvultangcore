//
//  File.swift
//  
//
//  Created by Javier Carapia on 27/04/22.
//

import RealmSwift
import Foundation
import ghgungnircore

public class GHRealmCore: GHStorageVultangDelegate {
    public var core: Realm?
    public static var objectTypes: [ObjectBase.Type]?
    public var delegate: GHVultangCoreDelegate?
    
    public required init() {
        self.commonInit()
    }
    
    required public init(queue: DispatchQueue? = nil) {
        self.commonInit(queue: queue)
    }
    
    private func commonInit(queue: DispatchQueue? = nil) {
        do {
            let realm = try Realm(configuration: self.getConfiguration(), queue: queue)
            
            if let folderPath = Realm.Configuration.defaultConfiguration.fileURL?.path {
                try FileManager.default.setAttributes(
                    [
                        FileAttributeKey.protectionKey: FileProtectionType.none
                    ],
                    ofItemAtPath: folderPath
                )
            }
            
            self.core = realm
        }
        catch {
            print(GHError.make(message: "GHRealmCore: \(error.localizedDescription)"))
        }
    }
    
    private func getConfiguration() -> Realm.Configuration {
        #if targetEnvironment(simulator)
            var config = Realm.Configuration()
        #else
            let key = self.getKey()
            var config = Realm.Configuration(encryptionKey: key)
        #endif
        
        config.schemaVersion = 1
        
        if let types = GHRealmCore.objectTypes {
            config.objectTypes = types
        }
        
        Realm.Configuration.defaultConfiguration = config
        
        return config
    }
    
    public static func deleteAllReference() {
        guard let realmURL = Realm.Configuration.defaultConfiguration.fileURL else { return }
        let realmURLs = [
            realmURL,
            realmURL.appendingPathExtension("lock"),
            realmURL.appendingPathExtension("note"),
            realmURL.appendingPathExtension("management")
        ]
        
        do {
            for url in realmURLs {
                try FileManager.default.removeItem(at: url)
            }
        }
        catch let error {
            print(GHError.make(message: "GHRealmCore: \(error.localizedDescription)"))
        }
    }
    
    private func getKey() -> Data {
        // Identifier for our keychain entry
        let keychainIdentifier = "gipsyhub.com.smstoragecore"
        let keychainIdentifierData = keychainIdentifier.data(using: String.Encoding.utf8, allowLossyConversion: false)!
            
        // First check in the keychain for an existing key
        var query: [NSString: AnyObject] = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
            kSecAttrKeySizeInBits: 512 as AnyObject,
            kSecReturnData: true as AnyObject
        ]
            
        var dataTypeRef: AnyObject?
        var status = withUnsafeMutablePointer(to: &dataTypeRef) { SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0)) }
        if status == errSecSuccess {
            return dataTypeRef as! Data
        }
            
        // No pre-existing key, so generate a new one
        let keyData = NSMutableData(length: 64)!
        let result = SecRandomCopyBytes(kSecRandomDefault, 64, keyData.mutableBytes.bindMemory(to: UInt8.self, capacity: 64))
        assert(result == 0, "Failed to get random bytes")
            
        // Store the key in the keychain
        query = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
            kSecAttrKeySizeInBits: 512 as AnyObject,
            kSecValueData: keyData
        ]
            
        status = SecItemAdd(query as CFDictionary, nil)
        assert(status == errSecSuccess, "Failed to insert the new key in the keychain")
            
        return keyData as Data
    }
    
    public func removeReferenceContext() {
        
    }
}
