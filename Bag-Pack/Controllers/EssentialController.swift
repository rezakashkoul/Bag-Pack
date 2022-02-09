//
//  EssentialController.swift
//  Bag-Pack
//
//  Created by Reza Kashkoul on 20/Bahman/1400 .
//

import UIKit

class EssentialController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    func setupUI() {
        setTabBarsStyle()
        navigationController?.visibleViewController?.title = "Essential"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setTabBarsStyle() {
        tabBarController?.tabBar.items![0].title = "Costs"
        tabBarController?.tabBar.items![0].image = UIImage(named: "cost")
        tabBarController?.tabBar.items![0].selectedImage = UIImage(named: "cost_filled")
        tabBarController?.tabBar.items![1].title = "Essential"
        tabBarController?.tabBar.items![1].image = UIImage(named: "essential")
        tabBarController?.tabBar.items![1].selectedImage = UIImage(named: "essential_filled")
        tabBarController?.tabBar.items![2].title = "Note and Points"
        tabBarController?.tabBar.items![2].image = UIImage(named: "notes")
        tabBarController?.tabBar.items![2].selectedImage = UIImage(named: "notes_filled")
    }
    
}
