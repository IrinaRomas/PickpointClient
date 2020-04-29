//
//  PickpointClientTests.swift
//  PickpointClient_Example
//
//  Created by Irina Romas on 27.04.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
@testable import PickpointClient

class PickpointClientTests: XCTestCase {
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    override class func setUp() {
        super.setUp()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    override class func tearDown() {
        super.tearDown()
    }
    
    func testInitPickpointClient() {
        let pickpointClient = PickpointClient(serviceProvider: CityBoxberryProvider())
        
        XCTAssertNotNil(pickpointClient)
    }
}


extension PickpointClientTests {
    
    struct CitiBoxberry: Codable {
        
    }
    
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
}
