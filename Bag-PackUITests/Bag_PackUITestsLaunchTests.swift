//
//  Bag_PackUITestsLaunchTests.swift
//  Bag-PackUITests
//
//  Created by Reza Kashkoul on 6/2/1401 AP.
//

import XCTest

class Bag_PackUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
    
    func test_addingANewTrip() {
        
        let app = XCUIApplication()
        app.launch()
        addingAnewEntry(app)
        deleteEntry(app)

    }
    
    func test_settings(){

        let app = XCUIApplication()
        app.launch()
        
        let settings = app.navigationBars.buttons.element(boundBy: 0)
        settings.tap()
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Rials"]/*[[".cells",".segmentedControls.buttons[\"Rials\"]",".buttons[\"Rials\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["€"]/*[[".cells",".segmentedControls.buttons[\"€\"]",".buttons[\"€\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["$"]/*[[".cells",".segmentedControls.buttons[\"$\"]",".buttons[\"$\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery.switches["ThemeSwitch"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Reset Settings"]/*[[".cells.staticTexts[\"Reset Settings\"]",".staticTexts[\"Reset Settings\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.alerts["Reset application Settings"].scrollViews.otherElements.buttons["Reset Settings"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Reset Application Data"]/*[[".cells.staticTexts[\"Reset Application Data\"]",".staticTexts[\"Reset Application Data\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.alerts["Reset entire data"].scrollViews.otherElements.buttons["Reset data"].tap()
                        

    }
    
    func addingAnewEntry(_ app: XCUIApplication) {
        
        let newEntryButton = app.navigationBars["BagPack"].buttons["New"]
        newEntryButton.tap()
        
        let elementsQuery = app.scrollViews.otherElements
        elementsQuery.textFields["Travel Title"].tap()
        
        let strings = ["A", "B", "C", "D","E", "F", "G", "H"]
        
        let aKey = app.keys[strings.randomElement()!]
        aKey.tap()
        elementsQuery.textFields["Place Name"].tap()
        
        let bKey = app.keys[strings.randomElement()!]
        bKey.tap()
        elementsQuery.textFields["Desired Budget"].tap()
        
        let key = app/*@START_MENU_TOKEN@*/.keys["1"]/*[[".keyboards.keys[\"1\"]",".keys[\"1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key.tap()
        elementsQuery.textFields["Day(s)"].tap()
        
        let key2 = app/*@START_MENU_TOKEN@*/.keys["2"]/*[[".keyboards.keys[\"2\"]",".keys[\"2\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key2.tap()
        elementsQuery.buttons["Let's Go!"].tap()
    }
    
    func deleteEntry(_ app: XCUIApplication) {
        let homeButton = app.navigationBars.buttons.element(boundBy: 0)
        homeButton.tap()
        let tablesQuery = app.tables
        let staticText = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["2 Days"]/*[[".cells.staticTexts[\"2 Days\"]",".staticTexts[\"2 Days\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        tablesQuery.cells.containing(.staticText, identifier:"A").element.swipeLeft()
        staticText.swipeLeft()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Delete"]/*[[".cells.buttons[\"Delete\"]",".buttons[\"Delete\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
    
    //    func test_completeTripDetails() {
    //
    //        let app = XCUIApplication()
    //        app.launch()
    //        addingAnewEntry(app)
    //
    //        let addEntryButton = app.navigationBars.buttons.element(boundBy: 1)
    //        addEntryButton.tap()
    //
    //
    //        let alertQuery = app.alerts["Add new item"].scrollViews.otherElements
    //

    //        addUIInterruptionMonitor(withDescription: "Alert Dialog") { (alert) -> Bool in
    //
    //            alertQuery.textFields["Write an item to remember"].tap()
    //            alertQuery.keys["f"].tap()
    //            app.children(matching: .window).element(boundBy: 1).tap()
    //            return false
    //        }
    //
    ////        //            alert.buttons["Add"].tap()
    ////        let addButt = NSPredicate(format: "Add")
    ////        app.alerts.buttons.element(matching: addButt).tap()
    ////
    //
    //
    //
    ////        alertQuery.buttons["Add"].tap()
    ////        app.buttons["Return"].tap()
    //
    //
    //
    //
    //
    //
    ////
    ////        let tabBar = app.tabBars["Tab Bar"]
    ////        tabBar.buttons["Costs"].tap()
    ////        app.navigationBars["Costs"].buttons["Add"].tap()
    ////
    ////        let collectionViewsQuery = app.alerts["Add items"].scrollViews.otherElements.collectionViews
    ////        collectionViewsQuery/*@START_MENU_TOKEN@*/.textFields["Title of purchase"]/*[[".cells.textFields[\"Title of purchase\"]",".textFields[\"Title of purchase\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    ////
    ////        let bKey = app/*@START_MENU_TOKEN@*/.keys["b"]/*[[".keyboards.keys[\"b\"]",".keys[\"b\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
    ////        bKey.tap()
    ////        collectionViewsQuery/*@START_MENU_TOKEN@*/.textFields["Price"]/*[[".cells.textFields[\"Price\"]",".textFields[\"Price\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    ////
    ////        let key = app/*@START_MENU_TOKEN@*/.keys["2"]/*[[".keyboards.keys[\"2\"]",".keys[\"2\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
    ////        key.tap()
    //////        app.alerts["Add items"].scrollViews.otherElements.buttons["Add"].tap()
    ////        app.buttons["Return"].tap()
    ////
    ////        tabBar.buttons["Note "].tap()
    ////        app.textViews.containing(.staticText, identifier:"Type here...").element.tap()
    ////
    ////        let gKey = app/*@START_MENU_TOKEN@*/.keys["G"]/*[[".keyboards.keys[\"G\"]",".keys[\"G\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
    ////        gKey.tap()
    ////        app.toolbars["Toolbar"].buttons["Done"].tap()
    ////
    ////
    ////        deleteEntry(app)
    //
    //    }
}
