//
//  TeamDetailsPresenterTest.swift
//  TestPresenters
//
//  Created by Mohamed on 11/05/2023.
//

import XCTest
@testable import SportSwift


final class TeamDetailsPresenterTest: XCTestCase {


    func testFetchTeamDetailsFromNetwrok() {
        let expectation = expectation (description: "Data should not be nil")
        let presenter:TeamDetailsPresenter? = TeamDetailsPresenter { result in
            expectation.fulfill ()
            return
        }
        presenter?.fetchTeamData(sportType: SportsType.football, teamId: 2)
        waitForExpectations(timeout: 5)        
    }
    
    


}
