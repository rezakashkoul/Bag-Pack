//
//  DashBoardTests.swift
//  Bag-PackTests
//
//  Created by Reza Kashkoul on 16/1/1401 AP.
//

import Foundation
import XCTest
@testable import Bag_Pack

class DashboardTests: XCTestCase {
    
    let travel = DashboradViewController()

    override class func setUp() {
        super.setUp()
        

    }

    override class func tearDown() {
        super.tearDown()
    }
    
    func testIsTravelFetchaDateAPIWorks() {
        
//        travel.fetchTravelData()
        
        NetworkManager.shared.getTravelData(useMockData: useMockData) { result in
            switch result {
            case .success(let travel):
                XCTAssertFalse(travel.isEmpty)
            case .failure(_):
                XCTAssertFalse(true)
            }
        }
    }
    
//    func testAddButtonAction() {
//        XCTAssertNil(dashboard.addButtonTapped())
//    }
}
