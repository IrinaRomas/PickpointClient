//
//  JSONDecoder + Extension.swift
//  pickpointlib
//
//  Created by Irina Romas on 23.04.2020.
//  Copyright © 2020 Irina Romas. All rights reserved.
//

import  Foundation

extension JSONDecoder {
    func decode<T>(_ type: T.Type, from data: Data, path: String? = nil) throws -> T where T : Decodable {
        guard let path = path else {
            return try decode(type, from: data)
        }
        
        var paths = path.split(separator: ".").map({ String($0) })
        
        var currentPath = ""
        var _data = data
        
        repeat {
            currentPath = paths.removeFirst()
            if let js = try JSONSerialization.jsonObject(with: _data) as? [String: Any] {
                if let jsInternal = js[currentPath] {
                    _data = try JSONSerialization.data(withJSONObject: jsInternal)
                }
            }
        } while !paths.isEmpty; do {
            return try decode(type, from: _data)
        }
    }
}
