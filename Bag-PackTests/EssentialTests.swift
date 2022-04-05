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
    
    func test_showAlertFunctionality() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "EssentialViewController")  as! EssentialViewController
        vc.showAlert(comple: { text in
            XCTAssertFalse(text?.isEmpty ?? true)
        })
    }
    
}
