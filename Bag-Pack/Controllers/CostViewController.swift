//
//  CostViewController.swift
//  Bag-Pack
//
//  Created by Reza Kashkoul on 20/Bahman/1400 .
//

import UIKit
import AppleWelcomeScreen

class CostViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var totalAmount: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CostTableViewCell", bundle: nil), forCellReuseIdentifier: "CostTableViewCell")
        tableView.tableFooterView = UIView()
        setupUI()
        calculateCostSum()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
        DispatchQueue.main.async {[self] in
            tableView.reloadData()
            tableView.showNoDataIfNeeded()
        }
    }
    
    func setupUI() {
        navigationItem.title = "Costs"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Home", style: .done, target: self, action: #selector(backButton))
        let addItemsButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewItemToCostList))
        let showGuideButton = UIBarButtonItem(image: UIImage(named: "help"), style: .plain, target: self, action: #selector(showGuideAction))
        navigationItem.rightBarButtonItems = [addItemsButton,showGuideButton]
        
        tableView.allowsSelection = false
    }
    
    @objc private func backButton() {
        tabBarController?.navigationController?.popViewController(animated: true)
    }
    
    @objc private func addNewItemToCostList() {
        showAddItemAlert(completion: {_ in
            return
        })
    }
    
    @objc private func showGuideAction() {
        showGuide()
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
                        calculateCostSum()
                    }
                    saveData()
                }
            }
        }
    }
    
    func calculateCostSum() {
        if let currentTrip = currentTrip {
            let tripCostArray = currentTrip.travelSubData.cost.compactMap({$0.price}).compactMap({Int($0)})
            totalAmount = tripCostArray.reduce(0, +)
            if let appCurrencyUnit = appCurrencyUnit {
                navigationItem.titleView = setTitle(title: navigationItem.title!, subtitle: "\(totalAmount ?? 0) \(appCurrencyUnit.rawValue.convertToCurrencyUnit())")
            }
        }
    }
    
    func showGuide() {
        var configuration = WelcomeScreenConfiguration(
            appName: "Costs",
            appDescription: "Add a New Item with the Payment Price!",
            features: [
                WelcomeScreenFeature(
                    image: UIImage(named: "money")!,
                    title: "To add a new item, press the \"+\" button on the top right corner",
                    description: "This section is also helpful for you to to have an eye on the trip's costs. You can see the total amount at top in a real time."
                )
            ]
        )
        configuration.welcomeString = ""
        configuration.tintColor = appGlobalTintColor
        present(WelcomeScreenViewController(configuration: configuration), animated: true)
    }
    
}

//MARK: - Setup TableView
extension CostViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CostTableViewCell", for: indexPath) as! CostTableViewCell
        cell.itemNameLabel?.text = currentTrip?.travelSubData.cost[indexPath.row].title
        cell.itemCostLabel?.text = currentTrip?.travelSubData.cost[indexPath.row].price
        cell.currencyUnitLabel.text = appCurrencyUnit?.rawValue.convertToCurrencyUnit()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentTrip?.travelSubData.cost.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            currentTrip?.travelSubData.cost.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            calculateCostSum()
            saveData()
            tableView.reloadData()
            tableView.showNoDataIfNeeded()
        }
    }
}
