//
//  EssentialViewController.swift
//  Bag-Pack
//
//  Created by Reza Kashkoul on 20/Bahman/1400 .
//

import UIKit

class EssentialViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var list = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    func setupUI() {
        tableView.register(UINib(nibName: "EssentialTableViewCell", bundle: nil), forCellReuseIdentifier: "EssentialTableViewCell")
        setTabBarStyle()
        navigationItem.title = "Essential"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewItemToCheckList))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Dashboard", style: .done, target: self, action: #selector(backButton))
        showNoDataForTableView()
    }
    
    @objc private func backButton() {
        tabBarController?.navigationController?.popViewController(animated: true)
    }
    
    @objc private func addNewItemToCheckList() {
        showAlert()
    }
    
    func showAlert() {
        var aTextField = UITextField()
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Write an item to remember"
            aTextField = textField
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: .none))
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { item in
            if !aTextField.text!.isEmpty && !self.list.contains(where: {$0 == aTextField.text?.lowercased()}) {
                self.list.append(aTextField.text!)
                DispatchQueue.main.async { [self] in
                    showNoDataForTableView()
                    tableView.reloadData()
                }
            }
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func showNoDataForTableView() {
        let noDataLabel : UILabel = UILabel()
        noDataLabel.frame = CGRect(x: 0, y: 0 , width: (self.tableView.bounds.width), height: (self.tableView.bounds.height))
        noDataLabel.text = "There's no record"
        noDataLabel.textColor = UIColor.systemBlue
        noDataLabel.textAlignment = .center
        DispatchQueue.main.async { [self] in
            if list.isEmpty {
                tableView.backgroundView = noDataLabel
            } else {
                tableView.backgroundView = nil
            }
        }
    }
    
    func setTabBarStyle() {
        tabBarController?.tabBar.items![0].title = "Essential"
        tabBarController?.tabBar.items![0].image = UIImage(named: "essential")
        tabBarController?.tabBar.items![0].selectedImage = UIImage(named: "essential_filled")
        tabBarController?.tabBar.items![1].title = "Costs"
        tabBarController?.tabBar.items![1].image = UIImage(named: "cost")
        tabBarController?.tabBar.items![1].selectedImage = UIImage(named: "cost_filled")
        tabBarController?.tabBar.items![2].title = "Note and Points"
        tabBarController?.tabBar.items![2].image = UIImage(named: "notes")
        tabBarController?.tabBar.items![2].selectedImage = UIImage(named: "notes_filled")
    }
    
}


//TableView Setup
extension EssentialViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EssentialTableViewCell", for: indexPath)
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
}
