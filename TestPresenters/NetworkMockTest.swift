//
//  NetworkMockTest.swift
//  TestPresenters
//
//  Created by Mohamed on 11/05/2023.
//

import XCTest
@testable import SportSwift


final class NetworkMockTest: XCTestCase {


    func testMockNetwrok() {
        let expectation = expectation (description: "Data should not be nil")

        let network = MockNetworkService<Livescore>(responseMock: DummyString.liveScoreResponse)
        network.fetchResult(complitionHandler: { (res) in
            switch res {
            case .success(let success):
                let data = success.result
    
                XCTAssertNotNil(data, "Movie data should not be nil")
                expectation.fulfill()
                return
                
            case .failure(_):
                XCTFail()
                expectation.fulfill()
                return
            }
            
        },url: URL(string: ""))
        
        waitForExpectations(timeout: 5)

    }

}
