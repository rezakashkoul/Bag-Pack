//
//  CostViewController.swift
//  Bag-Pack
//
//  Created by Reza Kashkoul on 20/Bahman/1400 .
//

import UIKit

class CostViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var items: [CostDetails] = [] {
        didSet{
            items = items.sorted(by: {$0.title < $1.title})
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
        AlertManager.shared.showCompleteFormOfAlert(parent: self, title: "Add items", message: "", placeHolders: ["Title of purchase","Price"], buttonTitles: ["Add"], style: .alert, showCancelButton: true) { _ in
        } textCompletion: { [self] texts in
            print(texts)
            if !texts.isEmpty {
                let item = CostDetails(title: texts[0], price: texts[1])
                print(item)
                if items.filter({$0.title.lowercased() == item.title.lowercased()}).isEmpty {
                items.append(item)
                saveCostList(items)
                }
            }
        }
    }
    
    
}

//MARK: - Setup TableView
extension CostViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CostTableViewCell", for: indexPath) as! CostTableViewCell
        
        cell.itemNameLabel?.text = items[indexPath.row].title
        cell.itemCostLabel?.text = items[indexPath.row].price
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            items.remove(at: indexPath.row)
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
    
    func saveCostList(_ list: [CostDetails]){
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(list)
            UserDefaults.standard.set(data, forKey: "cost")
        } catch {
            print("Unable to Encode costList (\(error))")
        }
    }
    
    func loadCostList()-> [CostDetails] {
        if let data = UserDefaults.standard.data(forKey: "cost") {
            do {
                let decoder = JSONDecoder()
                return try decoder.decode([CostDetails].self, from: data)
            } catch {
                print("Unable to Decode costlList (\(error))")
                return []
            }
        }
        return []
    }
}
//
