//
//  EssentialViewController.swift
//  Bag-Pack
//
//  Created by Reza Kashkoul on 20/Bahman/1400 .
//

import UIKit
import AppleWelcomeScreen

class EssentialViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "EssentialTableViewCell", bundle: nil), forCellReuseIdentifier: "EssentialTableViewCell")
        tableView.tableFooterView = UIView()
        setupUI()
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
        setTabBarStyle()
        navigationItem.title = "Essential"
        let newItemsButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewItemToCheckList))
        let showGuideButton = UIBarButtonItem(image: UIImage(named: "help"), style: .plain, target: self, action: #selector(showGuideAction))
        navigationItem.rightBarButtonItems = [newItemsButton,showGuideButton]
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Home", style: .done, target: self, action: #selector(backButton))
        tableView.allowsSelection = false
    }
    
    @objc private func backButton() {
        tabBarController?.navigationController?.popViewController(animated: true)
    }
    
    @objc private func addNewItemToCheckList() {
        showAlertWithTextFieldToAddItems { text in
            print(text)
        }
    }
    
    @objc private func showGuideAction() {
        showGuide()
    }
    
    func showAlertWithTextFieldToAddItems(completion: @escaping (String) -> ()) {
        AlertManager.shared.showAlertWithTextField(parent: self, title: "Add new item", placeHolder: "Write an item to remember", buttonTitle: "Add", style: .alert, showCancelButton: true) { [self] text in
            guard let text = text , text != "" else { return }
            completion(text)
            if currentTrip != nil {
                currentTrip!.travelSubData.essential.append(text)
                for i in 0..<allTrips.count {
                    if allTrips[i].title == currentTrip?.title && allTrips[i].place == currentTrip?.place {
                        allTrips[i] = currentTrip!
                    }
                }
                saveData()
                DispatchQueue.main.async {[self] in
                    tableView.reloadData()
                    tableView.showNoDataIfNeeded()
                }
            }
        }
    }
    
    func showGuide() {
        var configuration = WelcomeScreenConfiguration(
            appName: "Essential",
            appDescription: "Add a New Essential Item!",
            features: [
                WelcomeScreenFeature(
                    image: UIImage(named: "essentialItem")!,
                    title: "To add a new item, press the \"+\" button on the top right corner",
                    description: "This section Will help you to list your importnant stuff to bring with you in the trip."
                )
            ]
        )
        configuration.welcomeString = ""
        configuration.tintColor = appGlobalTintColor
        present(WelcomeScreenViewController(configuration: configuration), animated: true)
    }
    
}

//MARK: - Setup TableView
extension EssentialViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EssentialTableViewCell", for: indexPath) as! EssentialTableViewCell
        cell.itemNumberLabel?.text = "\(indexPath.row+1)."
        cell.itemNameLabel?.text = currentTrip?.travelSubData.essential[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentTrip?.travelSubData.essential.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            currentTrip?.travelSubData.essential.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveData()
            DispatchQueue.main.async {
                tableView.reloadData()
                tableView.showNoDataIfNeeded()
            }
        }
    }
}

//MARK: Setup tabbar style
extension EssentialViewController {
    func setTabBarStyle() {
        tabBarController?.tabBar.items![0].title = "Essential"
        tabBarController?.tabBar.items![0].image = UIImage(named: "essential")
        tabBarController?.tabBar.items![0].selectedImage = UIImage(named: "essential_filled")
        tabBarController?.tabBar.items![1].title = "Costs"
        tabBarController?.tabBar.items![1].image = UIImage(named: "cost")
        tabBarController?.tabBar.items![1].selectedImage = UIImage(named: "cost_filled")
        tabBarController?.tabBar.items![2].title = "Note"
        tabBarController?.tabBar.items![2].image = UIImage(named: "notes")
        tabBarController?.tabBar.items![2].selectedImage = UIImage(named: "notes_filled")
    }
}
