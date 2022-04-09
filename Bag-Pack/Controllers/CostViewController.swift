//
//  CostViewController.swift
//  Bag-Pack
//
//  Created by Reza Kashkoul on 20/Bahman/1400 .
//

import UIKit

class CostViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var items: [String: String] = [:] {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CostTableViewCell", bundle: nil), forCellReuseIdentifier: "CostTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
        items = loadCostList()
    }
    
    func setupUI() {
        navigationItem.title = "Costs"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Dashboard", style: .done, target: self, action: #selector(backButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewItemToCostList))
    }
    @objc private func backButton() {
        tabBarController?.navigationController?.popViewController(animated: true)
    }
    
    @objc private func addNewItemToCostList() {
        
        showAddItemAlert()
        
    }
    
    func showAddItemAlert() {
        AlertManager.shared.showCompleteFormOfAlert(parent: self, title: "Add items", message: "", placeHolders: ["Title","Price"], buttonTitles: ["Add"], style: .alert, showCancelButton: true) { _ in
        } textCompletion: { texts in
            print(texts)
            self.items[texts[0]] = texts[1]
            print(self.items)
        }
    }
    
    
}

//MARK: - Setup TableView
extension CostViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CostTableViewCell", for: indexPath) as! CostTableViewCell
        
        let names = Array(items.keys.sorted())
        let costs = Array(items.values.sorted())
        cell.itemNameLabel?.text = names[indexPath.row]
        cell.itemCostLabel?.text = costs[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            //            costList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            saveCostList(items)
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        if tableView.isEditing == false {
            return .delete
        } else {
            return .none
        }
    }
}

//MARK: - Save/Load list to userDefault
extension CostViewController {
    
    func saveCostList(_ list: [String: String]){
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(list)
            UserDefaults.standard.set(data, forKey: "cost")
        } catch {
            print("Unable to Encode costList (\(error))")
        }
    }
    
    func loadCostList()-> [String: String] {
        if let data = UserDefaults.standard.data(forKey: "cost") {
            do {
                let decoder = JSONDecoder()
                return try decoder.decode([String: String].self, from: data)
            } catch {
                print("Unable to Decode costlList (\(error))")
                return [:]
            }
        }
        return [:]
    }
}
//
