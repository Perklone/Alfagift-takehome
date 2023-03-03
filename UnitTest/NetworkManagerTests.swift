//
//  NetworkManagerTests.swift
//  NetworkManagerTests
//
//  Created by Rizky Maulana on 02/03/23.
//

import XCTest
@testable import AlfagiftTakeHome

final class NetworkManagerTests: XCTestCase {
    var sut: URLSession!
    let networkMonitor = NetworkManager.shared
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        sut = URLSession(configuration: .default)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        try super.tearDownWithError()
    }
    
    func testValidApiCall() throws {
        
        let urlString = MovieBaseURL.baseURL + "trending/movie/day" + MovieBaseURL.apiKey + "&page=1"
        let url = URL(string: urlString)!
        let promise = expectation(description: "Status code: 200")
        
        let dataTask = sut.dataTask(with: url) { __, response, error in
            if let error = error {
                XCTFail("error : \(error.localizedDescription)")
                return
            }
            else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        
        wait(for: [promise], timeout: 5)
        
    }

}
