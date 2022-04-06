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
    
    override func setUp() {
        super.setUp()
    }
    
    override class func tearDown() {
        super.tearDown()
    }
    
    func test_showAlertFunctionality() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "EssentialViewController")  as! EssentialViewController
        vc.showAlertWithTextFieldToAddItems { text in
            XCTAssertFalse(text.isEmpty )
        }
    }
    
    func test_essentialListIsNotEmpty() {
        XCTAssertTrue(essential.essentialList.isEmpty)
    }
    
    
}
