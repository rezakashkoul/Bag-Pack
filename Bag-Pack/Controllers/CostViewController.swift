//
//  CostViewController.swift
//  Bag-Pack
//
//  Created by Reza Kashkoul on 20/Bahman/1400 .
//

import UIKit

class CostViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CostTableViewCell", bundle: nil), forCellReuseIdentifier: "CostTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
        loadData()
        DispatchQueue.main.async {[self] in
            tableView.reloadData()
            tableView.showNoDataIfNeeded()
        }    }
    
    func setupUI() {
        navigationItem.title = "Costs"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Home", style: .done, target: self, action: #selector(backButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewItemToCostList))
        //        tableView.setNoDataInTableViewIFNotExists(tableView: tableView, data: items)
    }
    
    @objc private func backButton() {
        tabBarController?.navigationController?.popViewController(animated: true)
    }
    
    @objc private func addNewItemToCostList() {
        showAddItemAlert(completion: {_ in
            return
        })
        
    }
    
    func showAddItemAlert(completion: @escaping ([CostDetails]) -> ()) {
        AlertManager.shared.showCompleteFormOfAlert(parent: self, title: "Add items", message: "", placeHolders: ["Title of purchase","Price"], buttonTitles: ["Add"], style: .alert, showCancelButton: true) { _ in
        } textCompletion: { [self] texts in
            print(texts)
            if !texts.isEmpty {
                let item = CostDetails(title: texts[0], price: texts[1])
                print(item)
                if ((currentTrip?.travelSubData.cost.filter({$0.title.lowercased() == item.title.lowercased()}).isEmpty) != nil) {
                    currentTrip?.travelSubData.cost.append(item)
                    completion(currentTrip?.travelSubData.cost ?? [])
                    DispatchQueue.main.async {[self] in
                        tableView.reloadData()
                        tableView.showNoDataIfNeeded()
                    }
                    for i in 0..<allTrips.count {
                        if allTrips[i].title == currentTrip?.title && allTrips[i].place == currentTrip?.place {
                            allTrips[i] = currentTrip!
                        }
                    }
                    saveData()
                }
            }
        }
    }
    
}

//MARK: - Setup TableView
extension CostViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CostTableViewCell", for: indexPath) as! CostTableViewCell
        
        cell.itemNameLabel?.text = currentTrip?.travelSubData.cost[indexPath.row].title
        cell.itemCostLabel?.text = currentTrip?.travelSubData.cost[indexPath.row].price
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentTrip?.travelSubData.cost.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            currentTrip?.travelSubData.cost.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveData()
            tableView.showNoDataIfNeeded()
        }
    }
}
