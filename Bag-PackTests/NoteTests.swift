//
//  NoteTests.swift
//  Bag-PackTests
//
//  Created by Reza Kashkoul on 17/1/1401 AP.
//

import Foundation
import XCTest
@testable import Bag_Pack

class NoteTests: XCTestCase {
    
    var note = NoteViewController()
    
    func test_dataLoadsFromUserDefaultsSuccessfully() {
        XCTAssertFalse(note.loadNote().isEmpty)
    }
    
    func test_dataDecodesSuccessfully() {
        if let data = UserDefaults.standard.data(forKey: "note") {
            XCTAssertNoThrow(try JSONDecoder().decode(String.self, from: data))
        }
    }
    
    func test_userDefaultsInNotEmpty() {
        if let data = UserDefaults.standard.data(forKey: "note") {
            XCTAssertFalse(try JSONDecoder().decode(String.self, from: data).isEmpty)
        }
    }
    
}
