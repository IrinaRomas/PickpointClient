//
//  ListPointsCDEK.swift
//  PickpointDemo
//
//  Created by Irina Romas on 27.04.2020.
//  Copyright © 2020 Irina Romas. All rights reserved.
//

import Foundation

struct ListPointsCDEK: Codable {
    let pvz: [PointCDEK]
}
struct PointCDEK: Codable {
    let code: String
    let postalCode: String
    let name: String
    let countryCode: String
    let countryCodeIso: String
    let countryName: String
    let regionCode: String
    let regionName: String
    let cityCode: String
    let city: String
    let workTime: String
    let address: String
    let fullAddress: String
    let phone: String
    let note: String
    let coordX: String
    let coordY: String
    let type: String
    let ownerCode: String
    let isDressingRoom: Bool
    let haveCashless: Bool
    let haveCash: Bool
    let allowedCod: Bool
    let takeOnly: Bool
    let nearestStation: String
    let metroStation: String
    let email: String
    let addressComment: String
    let weightLimit: WeightLimit?
    let officeImageList: [OfficeImageList]?
    let workTimeYList: [WorkTimeYList]
    let workTimeExceptions: [WorkTimeExceptions]?
    let phoneDetailList: [PhoneDetailList]
}

struct WeightLimit: Codable {
    let weightMin: String
    let weightMax: String
}

struct OfficeImageList: Codable {
    let number: Double?
    let url: String?
}

struct WorkTimeYList: Codable {
    let day: String
    let periods: String
}

struct WorkTimeExceptions: Codable {
    let date: String?
    let time: String?
    let isWorking: String?
}

struct PhoneDetailList: Codable {
    let number: String
}
