//
//  PointsBoxberryProvider.swift
//  PickpointDemo
//
//  Created by Irina Romas on 26.04.2020.
//  Copyright © 2020 Irina Romas. All rights reserved.
//

import PickpointClient

class PointsBoxberryProvider: ServiceProvider {
    let path: String? = nil
    
    let isLogingEnabled: Bool = true
    
    let entryLifetime: TimeInterval = .hour
    
    typealias C = PointBoxberry
    
    let endPoint: String = "http://api.boxberry.ru/json.php"
    
    let parameters = [
        "token":"your_token",
        "method":"ListPoints",
        "cityCode":"44",
        "prepaid":"1"
    ]
}



