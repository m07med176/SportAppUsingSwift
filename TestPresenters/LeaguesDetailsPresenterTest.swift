//
//  LeaguesDetailsPresenter.swift
//  TestPresenters
//
//  Created by Mohamed on 11/05/2023.
//

import XCTest
@testable import SportSwift
final class LeaguesDetailsPresenterTest: XCTestCase {

    
    func testLiveScoreFromNetwrok() {
        let expectation = expectation (description: "Data should not be nil")
        let response:ResponseOperationLivescore = {data in
            expectation.fulfill ()
            return
        }
        let presenter:DetailsLeaguesPresenter? = DetailsLeaguesPresenter(response: response)
        presenter?.fetchDataLivesocre(sportType: SportsType.football)
        waitForExpectations(timeout: 5)
    }
    
    func testFixtureFromNetwrok() {
        let expectation = expectation (description: "Data should not be nil")
        let response:ResponseOperationFixture = {data in
            expectation.fulfill ()
            return
        }
        let presenter:DetailsLeaguesPresenter? = DetailsLeaguesPresenter(response: response)
        presenter?.fetchDataFixture(sportType: SportsType.football, leagueId: 152)
        waitForExpectations(timeout: 5)
    }


}
