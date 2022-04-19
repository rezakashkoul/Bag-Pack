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
        XCTAssertFalse(vc.tableView.visibleCells.isEmpty)
    }
    
    func test_loadData() {
        let travelData = UserDefaults.standard.data(forKey: "travel")
        XCTAssertNotNil(travelData)
    }
    
//MARK: - Create an Instance for this ViewController
    func createEssentialViewControllerInstance() -> SettingsViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SettingsViewController")  as! SettingsViewController
        vc.view.layoutIfNeeded()
        return vc
    }
    
}
