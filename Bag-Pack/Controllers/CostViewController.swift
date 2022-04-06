//
//  CostViewController.swift
//  Bag-Pack
//
//  Created by Reza Kashkoul on 20/Bahman/1400 .
//

import UIKit

class CostViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var costList: [(String, Double)] = [] {
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
        costList = loadCostList()
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
        showAlertWithTextFieldToAddItems { text in
            print(text)
        }
    }
    
//    func showAlertWithTextFieldToAddItems(completion: @escaping (String) -> ()) {
//        AlertManager.shared.showAlertWithTextField(parent: self, title: "Add new item", placeHolder: "Write an item to remember", buttonTitle: "Add", style: .alert, showCancelButton: true) { [self] text in
//            guard let text = text , text != "" else { return }
//            completion(text)
//            costList.append(text)
//            saveCostList(costList)
//        }
    //    }
    
    func showAlertWithTextFieldToAddItems(completion: @escaping (String) -> ()) {
        
    }
    
    
}

//MARK: - Setup TableView
extension CostViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CostTableViewCell", for: indexPath) as! CostTableViewCell
        cell.itemNumberLabel?.text = "\(indexPath.row+1)."
        cell.itemNameLabel?.text = costList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return costList.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            costList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            saveCostList(costList)
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

    func saveCostList(_ list: [(String, Double)]){
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(list)
            UserDefaults.standard.set(data, forKey: "cost")
        } catch {
            print("Unable to Encode costList (\(error))")
        }
    }
    
    func loadCostList()-> [(String, Double)] {
        if let data = UserDefaults.standard.data(forKey: "cost") {
            do {
                let decoder = JSONDecoder()
                return try decoder.decode([(String, Double)].self, from: data)
            } catch {
                print("Unable to Decode costlList (\(error))")
                return []
            }
        }
        return []
    }
}
