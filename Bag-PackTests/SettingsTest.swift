//
//  SettingsTest.swift
//  Bag-PackTests
//
//  Created by Reza Kashkoul on 21/1/1401 AP.
//

import Foundation
import XCTest
@testable import Bag_Pack

class SettingsTest: XCTestCase {
    
    let setting = SettingsViewController()
    
    func test_tableViewDataNotEmpty() {
        let vc = createSettingsViewControllerInstance()
        let items = ["Tint Color", "Dark Theme", "Common Currencies" , "Reset Application Data", "Reset Settings", "App Version"]
        XCTAssertEqual(vc.items, items)
    }
    
    func test_tableViewDelegateIsConnected(){
        let vc = createSettingsViewControllerInstance()
        XCTAssertNotNil(vc.tableView.delegate)
    }
    
    func test_tableViewDataSourceIsConnected() {
        let vc = createSettingsViewControllerInstance()
        XCTAssertNotNil(vc.tableView.dataSource)
    }
    
    func test_tableViewShowsData() {
        let vc = createSettingsViewControllerInstance()
        XCTAssertNotNil(vc.tableView.visibleCells)
    }
    
    func test_navigationTitleHasSet(){
        let vc = createSettingsViewControllerInstance()
        XCTAssertEqual(vc.navigationItem.title, "Settings")
    }
    
    func test_resetApplicationSettings() {
        
        let settingKeys = ["color","unit","theme"]
        for i in 0..<settingKeys.count{
            UserDefaults.standard.set(nil, forKey: settingKeys[i])
        }
        appGlobalTintColor = .systemBlue
        appCurrencyUnit = .dollar
        let userDefault = UserDefaults.standard
        let colorData = userDefault.colorForKey(key: "color")
        let currencyData = userDefault.integer(forKey: "unit")
        let themeData = userDefault.bool(forKey: "theme")
        XCTAssertEqual(colorData, UIColor.systemBlue)
        XCTAssertEqual(appCurrencyUnit, .dollar)
        XCTAssertEqual(currencyData, 0)
        XCTAssertEqual(themeData, false)
    }
    
    func test_resetApplicationData() {
        
        let dataKeys = ["color","unit","theme","travel"]
        for i in 0..<dataKeys.count {
            UserDefaults.standard.set(nil, forKey: dataKeys[i])
        }
        let userDefault = UserDefaults.standard
        let colorData = userDefault.colorForKey(key: "color")
        let currencyData = userDefault.integer(forKey: "unit")
        let themeData = userDefault.bool(forKey: "theme")
        let travelData = userDefault.data(forKey: "travel")
        XCTAssertNil(colorData)
        XCTAssertEqual(currencyData, 0)
        XCTAssertEqual(themeData, false)
        XCTAssertNil(travelData)
    }
        
        func test_appVersionValue(){
        let vc = createSettingsViewControllerInstance()
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        XCTAssertEqual(vc.appVersion, version)
    }
    
    //MARK: - Create an Instance for this ViewController
    func createSettingsViewControllerInstance() -> SettingsViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SettingsViewController")  as! SettingsViewController
        vc.view.layoutIfNeeded()
        return vc
    }
    
}
