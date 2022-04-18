//
//  EssentialTests.swift
//  Bag-PackTests
//
//  Created by Reza Kashkoul on 16/1/1401 AP.
//

import Foundation
import XCTest
@testable import Bag_Pack

//class EssentialTests: XCTestCase {
//    
//    var essential = EssentialViewController()
//    
//    func test_showAlertFunctionality() {
//        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "EssentialViewController")  as! EssentialViewController
//        vc.showAlertWithTextFieldToAddItems { text in
//            XCTAssertFalse(text.isEmpty )
//        }
//    }
//    
//    func test_essentialListIsNotEmpty() {
//        
//        XCTAssertTrue(essential.essentialList.isEmpty)
//    }
//    
//    func test_dataLoadsFromUserDefaultsSuccessfully() {
//        XCTAssertFalse(essential.loadEssentialList().isEmpty)
//    }
//    
//    func test_dataDecodesSuccessfully() {
//        if let data = UserDefaults.standard.data(forKey: "essential") {
//            XCTAssertNoThrow(try JSONDecoder().decode([String].self, from: data))
//        }
//    }
//    
//    func test_userDefaultsInNotEmpty() {
//        if let data = UserDefaults.standard.data(forKey: "essential") {
//            XCTAssertFalse(try JSONDecoder().decode([String].self, from: data).isEmpty)
//        }
//    }
//    
//    
//}
