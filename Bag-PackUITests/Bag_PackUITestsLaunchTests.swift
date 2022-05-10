//
//  Bag_PackUITestsLaunchTests.swift
//  Bag-PackUITests
//
//  Created by Reza Kashkoul on 6/2/1401 AP.
//

import XCTest

class Bag_PackUITestsLaunchTests: XCTestCase {

//    override class var runsForEachTargetApplicationUIConfiguration: Bool {
//        true
//    }
//
//    override func setUpWithError() throws {
//        continueAfterFailure = false
//    }
//
//    func testLaunch() throws {
//        let app = XCUIApplication()
//        app.launch()
//
//        let attachment = XCTAttachment(screenshot: app.screenshot())
//        attachment.name = "Launch Screen"
//        attachment.lifetime = .keepAlways
//        add(attachment)
//    }
    
    func test_shit(){
        
//        let elementsQuery = XCUIApplication().scrollViews.otherElements
//        elementsQuery.otherElements["dark red ۲۹"].tap()
//        elementsQuery.buttons["close"].tap()
                
                                        
    }
    
//    func test_addingANewTrip() {
//
//
//        let app = XCUIApplication()
//        app.alerts["Add new item"].scrollViews.otherElements.buttons["Add"].tap()
//        app.tabBars["Tab Bar"].buttons["Costs"].tap()
//
//    }
    
    func test_completeTripDetails() {

        let app = XCUIApplication()
        app.launch()
//        XCUIApplication()/*@START_MENU_TOKEN@*/.staticTexts["Continue"]/*[[".buttons[\"Continue\"].staticTexts[\"Continue\"]",".staticTexts[\"Continue\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        addingAnewEntry(app)

        let addEntryButton = app.navigationBars.buttons.element(boundBy: 2)
        addEntryButton.tap()
        
        let alertQuery = app.alerts["Add new item"].scrollViews.otherElements.collectionViews.textFields["Write an item to remember"]
        alertQuery.typeText("Charger")
        let addButton = app.alerts["Add new item"].scrollViews.otherElements.buttons["Add"]
        addButton.tap()
        
        let tabBar = app.tabBars["Tab Bar"]
        tabBar.buttons["Costs"].tap()
        app.navigationBars["Costs"].buttons["Add"].tap()
        
        let titleAlertQuery = app.alerts["Add items"].scrollViews.otherElements.collectionViews.textFields["Title of purchase"]
        titleAlertQuery.typeText("Tickets")
        
        let priceAlertQuery = app.alerts["Add items"].scrollViews.otherElements.collectionViews.textFields["Price"]
        priceAlertQuery.tap()
        priceAlertQuery.typeText("1000")
        
        let costAddButton = app.alerts["Add items"].scrollViews.otherElements.buttons["Add"]
        costAddButton.tap()
        
        tabBar.buttons["Note"].tap()
        app.textViews.containing(.staticText, identifier:"Type here...").element.tap()
        let text = """
                        This time it was wonderful. We went to some beautiful places, like \"Motel Qou\", \"Namak Abroud" etc. It was not an expensive experiance so we plann the same trip for someday soooooon. Oh I forgot to tell, I rided a hourse for the very first time close to beach!
                   """
        app.textViews.containing(.staticText, identifier:"Type here...").element.typeText(text)
        app.toolbars["Toolbar"].buttons["Done"].tap()

        deleteEntry(app)
    }
    
    func test_settings(){

        let app = XCUIApplication()
        app.launch()
        
        let settings = app.navigationBars.buttons.element(boundBy: 0)
        settings.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Reset Settings"]/*[[".cells.staticTexts[\"Reset Settings\"]",".staticTexts[\"Reset Settings\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.alerts["Reset application Settings"].scrollViews.otherElements.buttons["Reset Settings"].tap()
                
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Rials"]/*[[".cells",".segmentedControls.buttons[\"Rials\"]",".buttons[\"Rials\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["€"]/*[[".cells",".segmentedControls.buttons[\"€\"]",".buttons[\"€\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["$"]/*[[".cells",".segmentedControls.buttons[\"$\"]",".buttons[\"$\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        tablesQuery.switches["ThemeSwitch"].tap()

        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Tint Color"]/*[[".cells.staticTexts[\"Tint Color\"]",".staticTexts[\"Tint Color\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let elementsQuery = app.scrollViews.otherElements
        elementsQuery/*@START_MENU_TOKEN@*/.buttons["Grid"]/*[[".segmentedControls.buttons[\"Grid\"]",".buttons[\"Grid\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        elementsQuery.otherElements["green 54"].tap()
        elementsQuery.buttons["close"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Reset Application Data"]/*[[".cells.staticTexts[\"Reset Application Data\"]",".staticTexts[\"Reset Application Data\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.alerts["Reset entire data"].scrollViews.otherElements.buttons["Reset data"].tap()
        settings.tap()
        XCUIApplication()/*@START_MENU_TOKEN@*/.staticTexts["Continue"]/*[[".buttons[\"Continue\"].staticTexts[\"Continue\"]",".staticTexts[\"Continue\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

    }
    
    func addingAnewEntry(_ app: XCUIApplication) {
        
        let newEntryButton = app.navigationBars["BagPack"].buttons["Add"]
        newEntryButton.tap()
        
        let elementsQuery = app.scrollViews.otherElements
        elementsQuery.textFields["Travel Title"].tap()
        
//        let strings = ["A", "B", "C", "D","E", "F", "G", "H"]
//        let aKey = app.keys[strings.randomElement()!]
        app.keys["S"].tap()
        app.keys["h"].tap()
        app.keys["o"].tap()
        app.keys["m"].tap()
        app.keys["a"].tap()
        app.keys["l"].tap()

        elementsQuery.textFields["Place Name"].tap()
        app.keys["M"].tap()
        app.keys["a"].tap()
        app.keys["s"].tap()
        app.keys["a"].tap()
        app.keys["l"].tap()

        elementsQuery.textFields["Desired Budget"].tap()
        
        app.keys["1"].tap()
        app.keys["0"].tap()
        app.keys["0"].tap()
        app.keys["0"].tap()

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
        tablesQuery.cells.containing(.staticText, identifier:"Shomal").element.swipeLeft()
        staticText.swipeLeft()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Delete"]/*[[".cells.buttons[\"Delete\"]",".buttons[\"Delete\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }

}
