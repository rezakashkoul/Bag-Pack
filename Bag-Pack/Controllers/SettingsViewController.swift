//
//  SettingsViewController.swift
//  Bag-Pack
//
//  Created by Reza Kashkoul on 21/1/1401 AP.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let items = ["Tint Color", "Light/Dark Theme", "Common Currencies" , "Rest App Data", "App Version"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SettingsTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingsTableViewCell")
        navigationController?.navigationBar.prefersLargeTitles = false
        title = "Settings"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }


}

//MARK: - Setup TableView
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as! SettingsTableViewCell
        cell.titleLabel.text = items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
}
