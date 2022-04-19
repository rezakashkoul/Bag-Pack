//
//  EssentialTests.swift
//  Bag-PackTests
//
//  Created by Reza Kashkoul on 16/1/1401 AP.
//

import Foundation
import XCTest
@testable import Bag_Pack

class EssentialTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        currentTrip = nil
    }
    
    var essential = EssentialViewController()
    
    func test_showAlertFunctionality() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "EssentialViewController")  as! EssentialViewController
        vc.showAlertWithTextFieldToAddItems { text in
            XCTAssertFalse(text.isEmpty )
        }
    }
    
    func test_tableViewDelegateIsConnected(){
        let vc = createEssentialViewControllerInstance()
        XCTAssertNotNil(vc.tableView.delegate)
    }

    func test_tableViewDataSourceIsConnected() {
        let vc = createEssentialViewControllerInstance()
        XCTAssertNotNil(vc.tableView.dataSource)
    }

    func test_tableViewShowsData() {
        let vc = createEssentialViewControllerInstance()
        XCTAssertTrue(vc.tableView.visibleCells.isEmpty)
        currentTrip = MockData.shared.travelMockData[0]
        vc.tableView.reloadData()
        XCTAssertNotNil(currentTrip)
        XCTAssertFalse(vc.tableView.visibleCells.isEmpty)
//        currentTrip = nil
    }
    
//MARK: - Create an Instance for this ViewController
    func createEssentialViewControllerInstance() -> EssentialViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "EssentialViewController")  as! EssentialViewController
        vc.view.layoutIfNeeded()
        return vc
    }
    
}
