//
//  DashboradController.swift
//  Bag-Pack
//
//  Created by Reza Kashkoul on 20/Bahman/1400 .
//

import UIKit

class DashboradController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var travelList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        setupUI()
        
    }
    
    func setupUI() {
        navigationItem.title = "Bag-Pack"
        navigationController?.navigationBar.prefersLargeTitles = true
        setNoDataInfoIfAbsenceNotExists()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    }
    
    func setNoDataInfoIfAbsenceNotExists() {
        let noDataLabel : UILabel = UILabel()
        noDataLabel.frame = CGRect(x: 0, y: 0 , width: (self.tableView.bounds.width), height: (self.tableView.bounds.height))
        noDataLabel.text = "There's no record"
        noDataLabel.textColor = UIColor.systemBlue
        noDataLabel.textAlignment = .center
        DispatchQueue.main.async { [self] in
            if travelList.isEmpty {
                tableView.backgroundView = noDataLabel
            } else {
                tableView.backgroundView = nil
            }
        }
    }
    
    @objc private func addButtonTapped () {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") as! UITabBarController
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

//TableView Setup
extension DashboradController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelList.count
    }
}
