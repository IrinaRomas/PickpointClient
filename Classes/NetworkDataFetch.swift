//
//  NetworkDataFetch.swift
//  pickpointlib
//
//  Created by Irina Romas on 19.04.2020.
//  Copyright © 2020 Irina Romas. All rights reserved.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}

class NetworkDataFetch {
    
    private let allowedDiskSize = 100 * 1024 * 1024
    private var cache: CacheLib!
    
    var urlSession: URLSessionProtocol = URLSession.shared
    
    func sendRequest<T: Decodable>(urlServer: String, parameters: [String: String], force: Bool = false, isLog: Bool, path: String? = nil, entryLifetime: TimeInterval, success response: @escaping (T?) -> (), failure failureCallback: @escaping (Error?) -> ()) {
        
        cache = CacheLib(entryLifetime: entryLifetime, isLog: isLog, path: path)
        
        let parametersSorted = parameters.sorted { $0.key < $1.key }
        var components = URLComponents(string: urlServer)!
        
        components.queryItems = parametersSorted.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        
        let request = URLRequest(url: components.url!)

        if !force, let cachedData = self.cache.cachedResponse(for: request) {
            if isLog {
                print("PPL_Cached data in bytes:", cachedData)
            }

            if let responseObject = self.decodeJSON(type: T.self, from: cachedData, isLog: isLog, path: path, failureCallback: failureCallback) {
                response(responseObject)
            }
        } else {
            urlSession.dataTask(with: request) { data, result, error in
                guard let data = data,
                    let result = result as? HTTPURLResponse,
                    (200 ..< 300) ~= result.statusCode,
                    error == nil else {
                        failureCallback(error)
                        return
                }

                if let responseObject = self.decodeJSON(type: T.self, from: data, isLog: isLog, path: path, failureCallback: failureCallback) {

                    self.cache.storeCachedResponse(data: data)

                    response(responseObject)
                }
            }.resume()
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?, isLog: Bool, path: String? = nil, failureCallback: @escaping (Error) -> ()) -> T? {
        
        let decoder = JSONDecoder()
//        decoder.dateDecodingStrategy = .iso8601
        guard let data = from else { return nil }
        do {
            let objects = try decoder.decode(type.self, from: data, path: path)
            return objects
        } catch let error {
            
            if isLog {
                print("PPL_", error)
            }
            
            failureCallback(error)
            return nil
        }
    }
}


