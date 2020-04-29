//
//  PointsCDEKProvider.swift
//  PickpointDemo
//
//  Created by Irina Romas on 27.04.2020.
//  Copyright © 2020 Irina Romas. All rights reserved.
//

import PickpointClient

class PointsCDEKProvider: ServiceProvider {
    typealias C = PointCDEK
    
    let path: String? = "pvz"
    let isLogingEnabled: Bool = true
    let endPoint: String = "http://integration.cdek.ru/pvzlist/v1/json"
    let parameters = [
        "cityid": "44"
    ]
}
