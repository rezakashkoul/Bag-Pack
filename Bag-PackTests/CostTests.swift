//
//  CostTests.swift
//  Bag-PackTests
//
//  Created by Reza Kashkoul on 21/1/1401 AP.
//

import Foundation
import XCTest
@testable import Bag_Pack

class CostTests: XCTestCase {
    
    var cost = CostViewController()
    
    override func setUp() {
        super.setUp()
        currentTrip = nil
    }
    
    func test_showAlertFunctionality() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CostViewController")  as! CostViewController
        vc.showAddItemAlert(completion: {items in
            XCTAssertFalse(items.isEmpty)
        })
    }
    
    func test_tableViewDelegateIsConnected(){
        let vc = createCostlViewControllerInstance()
        XCTAssertNotNil(vc.tableView.delegate)
    }

    func test_tableViewDataSourceIsConnected() {
        let vc = createCostlViewControllerInstance()
        XCTAssertNotNil(vc.tableView.dataSource)
    }

    func test_tableViewShowsData() {
        let vc = createCostlViewControllerInstance()
        XCTAssertTrue(vc.tableView.visibleCells.isEmpty)
        currentTrip = MockData.shared.travelMockData[0]
        vc.tableView.reloadData()
        XCTAssertFalse(vc.tableView.visibleCells.isEmpty)
    }
        
//MARK: - Create an Instance for this ViewController
    func createCostlViewControllerInstance() -> CostViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CostViewController")  as! CostViewController
        vc.view.layoutIfNeeded()
        return vc
    }
    
}
