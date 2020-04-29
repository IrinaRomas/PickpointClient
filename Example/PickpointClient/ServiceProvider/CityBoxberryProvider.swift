//
//  CityBoxberryProvider.swift
//  PickpointDemo
//
//  Created by Irina Romas on 26.04.2020.
//  Copyright © 2020 Irina Romas. All rights reserved.
//

import PickpointClient

class CityBoxberryProvider: ServiceProvider {
    
    let path: String? = nil
    
    
    let isLogingEnabled: Bool = true
    
    typealias C = CitiBoxberry
    
    let endPoint: String = "http://api.boxberry.ru/json.php"
    
    let parameters = [
        "token":"your_token",
        "method":"ListCities"
    ]
}
