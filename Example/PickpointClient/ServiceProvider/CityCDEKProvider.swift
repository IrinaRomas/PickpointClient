//
//  CityCDEKProvider.swift
//  PickpointDemo
//
//  Created by Irina Romas on 27.04.2020.
//  Copyright © 2020 Irina Romas. All rights reserved.
//

import PickpointClient

class CityCDEKProvider: ServiceProvider {
    var path: String? = nil
    
    var isLogingEnabled: Bool = true
   
    typealias C = CityCDEK
    
    var endPoint: String = "http://integration.cdek.ru/v1/location/cities/json"
    
    var parameters = ["":""]
    
}
