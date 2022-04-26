//
//  EntryTests.swift
//  Bag-PackTests
//
//  Created by Reza Kashkoul on 29/1/1401 AP.
//

import Foundation
import XCTest
@testable import Bag_Pack

class EntryTests: XCTestCase {

    func test_navigationTitleHasSet() {
        let vc = createNewEntryViewControllerInstance()
        XCTAssertEqual(vc.title, "New Entry")
    }
    
    //MARK: - Create an Instance for this ViewController
    func createNewEntryViewControllerInstance() -> NewEntryViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "NewEntryViewController")  as! NewEntryViewController
        vc.view.layoutIfNeeded()
        return vc
    }

}
