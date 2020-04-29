//
//  CitiyCDEK.swift
//  PickpointDemo
//
//  Created by Irina Romas on 27.04.2020.
//  Copyright © 2020 Irina Romas. All rights reserved.
//

import Foundation

struct CityCDEK: Codable {
    let cityName: String
    let cityCode: String
    let cityUuid: String
    let country: String
    let countryCode: String
    let region: String
    let regionCode: String?
    let subRegion: String?
    let paymentLimit: Double
    let regionCodeExt: String?
    let latitude: Float?
    let longitude: Float?
    let kladr: String?
    let fiasGuid: String?
    let regionFiasGuid: String?
    let timezone: String?
}
