//
//  NoteController.swift
//  Bag-Pack
//
//  Created by Reza Kashkoul on 20/Bahman/1400 .
//

import UIKit

class NoteController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    func setupUI() {
        navigationController?.visibleViewController?.title = "Notes"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
}
