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
    
    func test_isTravelFetchDateAPIWorks() {
        NetworkManager.shared.getTravelData(useMockData: useMockData) { result in
            switch result {
            case .success(let travel):
                XCTAssertFalse(travel.isEmpty)
            case .failure(_):
                XCTAssertFalse(true)
            }
        }
    }
    
    func test_tableViewDataNotEmpty() {
        let vc = createDashboradViewControllerInstance()
        let expectationJob = expectation(description: "data")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectationJob.fulfill()
        }
        waitForExpectations(timeout: 1.1, handler: { _ in
            XCTAssertFalse(vc.travelList.isEmpty)
        })

    }
    
    func test_tableViewDelegateIsConnected(){
        let vc = createDashboradViewControllerInstance()
        XCTAssertNotNil(vc.tableView.delegate)
    }
    
    func test_tableViewDataSourceIsConnected() {
        let vc = createDashboradViewControllerInstance()
        XCTAssertNotNil(vc.tableView.dataSource)
    }
    
    func test_tableViewShowsData() {
        let vc = createDashboradViewControllerInstance()
        XCTAssertNotNil(vc.tableView.visibleCells)
    }
    
    func createDashboradViewControllerInstance() -> DashboradViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DashboradViewController")  as! DashboradViewController
        vc.view.layoutIfNeeded()
        return vc
    }
        
}
