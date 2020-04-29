//
//  GetListCitiesBoxberry.swift
//  pickpointlib
//
//  Created by Irina Romas on 19.04.2020.
//  Copyright © 2020 Irina Romas. All rights reserved.
//

import Foundation

/// Interface for City or Point object provider
/// implement **isLogingEnabled** to turn loging on.
public protocol ServiceProvider {
    /// Type of the object located of the **path** or at the root level. See path property. Will get response array these objects
    associatedtype C: Decodable
    
    var endPoint: String { get }
    var parameters: [String: String] { get }
    
    /// Optional string path to nestead JSON object. If the object located at the root this property should be nil
    ///
    /// We use *let path: String? = "a.b.c"* to access [Int]
    /// ```
    /// // Nestead JSON. Target is last level array [1,2,3]
    /// // [a: [b: [c: [1,2,3]]]]
    /// class SomeProvider: ServiceProvider {
    ///    typealias C = Int
    ///    let path: String? = "a.b.c"
    ///
    ///    let isLogingEnabled: Bool = true
    ///    let entryLifetime: TimeInterval = 24*60*60
    ///    let endPoint: String = "http://..."
    ///    let parameters = [String: String]()
    ///}
    /// ```
    var path: String? { get }
    
    /// Optional flag to enabled library loging. Use **PPL_** to filter. Default is false.
    var isLogingEnabled: Bool { get }
    
    /// Cache data uptime. Default is 24 hours.
    var entryLifetime: TimeInterval { get }
}

public extension ServiceProvider {
    var isLogingEnabled: Bool {
        return false
    }
    
    var entryLifetime: TimeInterval {
        return 24*60*60
    }
}

/// Client for specified ServiceProvider
public class PickpointClient<T: ServiceProvider> {
    
    private var serviceProvider: T
    
    /// Creates Client for specified ServiceProvider
    public init(serviceProvider: T) {
        self.serviceProvider = serviceProvider
        
    }
    
    // MARK: - private variable
    private let networkDataFetch = NetworkDataFetch()
    
    /// Get data from API
    /// Interaction with the service occurs online using the standard HTTPS protocol and JSON format.
    /// Data is cashed
    /// - Parameters:
    ///     - force: Get data directly from URL without using a cache. Default is false.
    ///     - completion: Call back completion closure. Return array
    ///     - failureCallback: Call back error closure.
    public func get(force: Bool = false, completion: @escaping ([T.C]) -> Void, failure failureCallback: @escaping (Error) -> ()) {
        print("-----")
        getData(completion: completion, failure: failureCallback)
    }
    
    private func getData(force: Bool = false, completion: @escaping ([T.C]) -> Void, failure failureCallback: @escaping (Error) -> ()) {
        dataFetch(force: force, success: { result in
           completion(result ?? [])
        }, failure: { err in
            if self.serviceProvider.isLogingEnabled {
                print("PPL_", err?.localizedDescription ?? "Unknown error")
            }
        })
    }
    
    private func dataFetch(force: Bool = false, success response: @escaping ([T.C]?) -> (), failure failureCallback: @escaping (Error?) -> ()) {
        networkDataFetch.sendRequest(urlServer: serviceProvider.endPoint,
                                     parameters: serviceProvider.parameters,
                                     force: force,
                                     isLog: serviceProvider.isLogingEnabled,
                                     path: serviceProvider.path,
                                     entryLifetime: serviceProvider.entryLifetime,
                                     success: response,
                                     failure: { error in
            failureCallback(error)
        })
    }
    
    deinit {
        print("----- deinit", #file)
    }
}
