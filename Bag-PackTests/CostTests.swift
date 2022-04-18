//
//  CostTests.swift
//  Bag-PackTests
//
//  Created by Reza Kashkoul on 21/1/1401 AP.
//

import Foundation
import XCTest
@testable import Bag_Pack

//class CostTests: XCTestCase {
//
//    var cost = CostViewController()
//    
//    func test_showAlertFunctionality() {
//        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "CostViewController")  as! CostViewController
//        vc.showAddItemAlert(completion: {items in
//            XCTAssertFalse(items.isEmpty)
//        })
//    }
//    
//    func test_essentialListIsNotEmpty() {
//        XCTAssertTrue(cost.items.isEmpty)
//    }
//    
//    func test_dataLoadsFromUserDefaultsSuccessfully() {
//        XCTAssertFalse(cost.loadCostList().isEmpty)
//    }
//    
//    func test_dataDecodesSuccessfully() {
//        if let data = UserDefaults.standard.data(forKey: "cost") {
//            XCTAssertNoThrow(try JSONDecoder().decode([CostDetails].self, from: data))
//        }
//    }
//    
//    func test_userDefaultsInNotEmpty() {
//        if let data = UserDefaults.standard.data(forKey: "cost") {
//            XCTAssertFalse(try JSONDecoder().decode([CostDetails].self, from: data).isEmpty)
//        }
//    }
//    
//    
//}
