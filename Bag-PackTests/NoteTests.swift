//
//  NoteTests.swift
//  Bag-PackTests
//
//  Created by Reza Kashkoul on 17/1/1401 AP.
//

import Foundation
import XCTest
@testable import Bag_Pack
//
//class NoteTests: XCTestCase {
//    
//    var note = NoteViewController()
//    
//    func test_validateViewControllerTitle(){
//        let esVC = createEssentialViewControllerInstance()
//        esVC.setTabBarStyle()
//        let vc = createNoteViewControllerInstance()
//        XCTAssertNotNil(vc)
//        XCTAssertEqual(vc.tabBarController?.tabBar.items?[0].title,"Notes")
//            //.tabBarController?.tabBar.items![0].title, "Note")
//    }
//}
//
////MARK: - Create an Instance for this ViewController
//func createNoteViewControllerInstance() -> NoteViewController {
//    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//    let vc = storyboard.instantiateViewController(withIdentifier: "NoteViewController") as! NoteViewController
//    vc.view.layoutIfNeeded()
//    return vc
//}
//
//func createEssentialViewControllerInstance() -> EssentialViewController {
//    let tab = UITabBarController()
//    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//    let vc = storyboard.instantiateViewController(withIdentifier: "EssentialViewController")  as! EssentialViewController
//    let nav = UINavigationController(rootViewController: vc)
//    vc.view.layoutIfNeeded()
//    tab.viewControllers = [nav]
//    return (tab.viewControllers?.first! as! UINavigationController).viewControllers.first as! EssentialViewController
//}
//
//
