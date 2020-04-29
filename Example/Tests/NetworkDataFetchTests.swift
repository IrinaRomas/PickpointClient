//
//  NetworkDataFetchTests.swift
//  PickpointClient_Example
//
//  Created by Irina Romas on 27.04.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
@testable import PickpointClient

class NetworkDataFetchTests: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    override class func setUp() {
        super.setUp()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    let sut = NetworkDataFetch()
    let sp = CityBoxberryProvider()
    let jsonDataStub = "[{\"Code\":\"68\",\"Name\":\"Москва\"},{\"Code\":\"00148\",\"Name\":\"Белебей\"}]".data(using: .utf8)
    
    func testSuccessfulCityBoxberryProvider() {
        let mockURLSession = MockURLSession(data: jsonDataStub, urlResponse: HTTPURLResponse(url: URL(string: sp.endPoint)!, statusCode: 200, httpVersion: "", headerFields: ["" : ""]), responseError: nil)
        
        sut.urlSession = mockURLSession
        let cityExpectation = expectation(description: "City expectation")
        var caughtCity: String?
        
        func y(_ s: [CitiBoxberry]?) {
            caughtCity = s?.first?.Name
            cityExpectation.fulfill()
        }
        
        
        sut.sendRequest(urlServer: sp.endPoint,
                        parameters: sp.parameters,
                        force: true,
                        isLog: sp.isLogingEnabled,
                        path: sp.path,
                        entryLifetime: sp.entryLifetime,
                        success: y,
                        failure: { _ in
                            
        })
        waitForExpectations(timeout: 2) { y in
            XCTAssertEqual(caughtCity, "Москва")
        }
    }
    
    func testCityBoxberryProviderInvalidJSONReturnsError() {
        let mockURLSession = MockURLSession(data: Data(), urlResponse: HTTPURLResponse(url: URL(string: sp.endPoint)!, statusCode: 200, httpVersion: "", headerFields: ["" : ""]), responseError: nil)
        sut.urlSession = mockURLSession
        let errorExpectation = expectation(description: "Error expectation")

        func y(_ s: [CitiBoxberry]?) {

        }

        var caughtError: Error?
        sut.sendRequest(urlServer: sp.endPoint,
                        parameters: sp.parameters,
                        force: true,
                        isLog: sp.isLogingEnabled,
                        path: sp.path,
                        entryLifetime: sp.entryLifetime,
                        success: y,
                        failure: { error in
                            caughtError = error
                            errorExpectation.fulfill()
        })
        waitForExpectations(timeout: 1) { _ in
            XCTAssertNotNil(caughtError)
        }
    }
    
    func testCityBoxberryProviderWhenDataIsNilReturnsError() {
        let mockURLSession = MockURLSession(data: nil, urlResponse: HTTPURLResponse(url: URL(string: sp.endPoint)!, statusCode: 200, httpVersion: "", headerFields: ["" : ""]), responseError: NSError(domain: "PPL", code: 404, userInfo: ["" : ""]))
        sut.urlSession = mockURLSession
        let errorExpectation = expectation(description: "Error expectation")

        func y(_ s: [CitiBoxberry]?) {

        }

        var caughtError: Error?
        sut.sendRequest(urlServer: sp.endPoint,
                        parameters: sp.parameters,
                        force: true,
                        isLog: sp.isLogingEnabled,
                        path: sp.path,
                        entryLifetime: sp.entryLifetime,
                        success: y,
                        failure: { error in
                            caughtError = error
                            errorExpectation.fulfill()
        })
        waitForExpectations(timeout: 1) { _ in
            XCTAssertNotNil(caughtError)
        }
    }
    
    func testCityBoxberryProviderWhenResponseErrorReturnsError() throws {
        let error = NSError(domain: "Server error", code: 404, userInfo: nil)
        let mockURLSession = MockURLSession(data: jsonDataStub, urlResponse: nil, responseError: error)
        sut.urlSession = mockURLSession

        func y(_ s: [CitiBoxberry]?) {

        }
        let errorExpectation = expectation(description: "Error expectation")

        var caughtError: Error?
        sut.sendRequest(urlServer: sp.endPoint,
                        parameters: sp.parameters,
                        force: true,
                        isLog: sp.isLogingEnabled,
                        path: sp.path,
                        entryLifetime: sp.entryLifetime,
                        success: y,
                        failure: { error in
                            caughtError = error
                            errorExpectation.fulfill()
        })

        waitForExpectations(timeout: 1) { _ in
            XCTAssertNotNil(caughtError)
        }
    }

}


extension NetworkDataFetchTests {
    class MockURLSession: URLSessionProtocol {
        var url: URL?
        private let mockDataTask: MockURLSessionDataTask
        var urlComponents: URLComponents? {
            guard let url = url else {
                return nil
            }
            return URLComponents(url: url, resolvingAgainstBaseURL: true)
        }
        
        init(data: Data?, urlResponse: URLResponse?, responseError: Error?) {
            mockDataTask = MockURLSessionDataTask(data: data, urlResponse: urlResponse, responseError: responseError)
        }
        
        func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            mockDataTask.completionHandler = completionHandler
            return mockDataTask
        }

    }
    
    class MockURLSessionDataTask: URLSessionDataTask {
        private let data: Data?
        private let urlResponse: URLResponse?
        private let responseError: Error?
        
        typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
        var completionHandler: CompletionHandler?
        
        init(data: Data?, urlResponse: URLResponse?, responseError: Error?) {
            self.data = data
            self.urlResponse = urlResponse
            self.responseError = responseError
        }
        
        override func resume() {
            DispatchQueue.main.async {
                self.completionHandler?(
                    self.data,
                    self.urlResponse,
                    self.responseError
                )
            }
        }
    }
}


extension NetworkDataFetchTests {
    
    struct CitiBoxberry: Codable {
        let Code: String
        let Name: String
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
