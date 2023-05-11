//
//  LeaguePresenter.swift
//  TestPresenters
//
//  Created by Mohamed on 11/05/2023.
//

import XCTest
@testable import SportSwift

final class LeaguePresenterTest: XCTestCase {

    func testFetchLeaguesFromNetwrok() {
        let expectation = expectation (description: "Data should not be nil")
        var presenter:LeaguesPresenter? = LeaguesPresenter { result in
            expectation.fulfill ()
            return
        }
        presenter?.getLeaguesData(sportType: SportsType.football)
        waitForExpectations(timeout: 5)
    }

}
