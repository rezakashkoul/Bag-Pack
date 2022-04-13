//
//  DashboradViewController.swift
//  Bag-Pack
//
//  Created by Reza Kashkoul on 20/Bahman/1400 .
//

import UIKit
import netfox

@available(iOS 14.0, *)
class DashboradViewController: UIViewController, NewEntryViewControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var travelList: [Travel] = [] {
        willSet {
//            tableView.setNoDataInTableViewIFNotExists(tableView: tableView, data: travelList)
        }
        didSet {
            travelList = loadData()
            DispatchQueue.main.async { [self] in
                tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        setupUI()
        //        fetchTravelData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        travelList = loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        view.window?.tintColor = appGlobalTintColor
        if isDarkMode {
            view.window?.overrideUserInterfaceStyle = .dark
        } else {
            view.window?.overrideUserInterfaceStyle = .light
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func setupUI() {
        navigationItem.title = "BagPack"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New", style: .done, target: self, action: #selector(newButtonTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Settings", style: .done, target: self, action: #selector(goToSettings))
        tableView.register(UINib(nibName: "DashboardTableViewCell", bundle: nil), forCellReuseIdentifier: "DashboardTableViewCell")
//        tableView.setNoDataInTableViewIFNotExists(tableView: tableView, data: travelList)
        tableView.allowsSelection = false
    }
    
    @objc private func newButtonTapped () {
        let vc = storyboard?.instantiateViewController(withIdentifier: "NewEntryViewController") as! NewEntryViewController
        vc.delegate = self
        navigationController?.present(vc, animated: true)
    }
    
    @objc private func goToSettings() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func goForFillData(tripData: Travel) {
        travelList.append(tripData)
        saveData(travelList)
        let vc = storyboard?.instantiateViewController(withIdentifier: "MainTabBarController")
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    func fetchTravelData() {
        NetworkManager.shared.getTravelData(useMockData: useMockData) { result in
            switch result {
            case .success(let travelList):
                self.travelList = travelList
            case .failure(let error):
                print(error.localizedDescription)
                self.showAlertAndHandleEvent(error)
            }
        }
    }
    
    func showAlertAndHandleEvent(_ error: ApplicationError) {
        switch error {
        case .badURL, .decode:
            AlertManager.shared.showAlert(parent: self, title: "Network failure", body: "Please check your Internet", buttonTitles: [], style: .alert, showCancelButton: true, completion: {index in
                self.showAlertAndHandleEvent(.badURL)
            })
        case .general:
            print(error)
            AlertManager.shared.showAlert(parent: self, title: "Error", body: "Please check your Internet", buttonTitles: ["Try again"], style: .alert, showCancelButton: true, completion: {index in
                if let index = index {
                    if index == 0 {
                        self.fetchTravelData()
                    }
                } else {
                    //
                }
            })
        case .timeout:
            print(error)
            AlertManager.shared.showAlert(parent: self, title: "Request timeout", body: "Please try again", buttonTitles: ["Try again", "More"], style: .alert, showCancelButton: true, completion: {index in
                if index == 0 {
                    self.fetchTravelData()
                } else {
                    NFX.sharedInstance().show()
                }
            })
        case .noData:
            print("No data ", error)
        }
    }
    
}

//MARK: Setup tableView

@available(iOS 14.0, *)
extension DashboradViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "DashboardTableViewCell", for: indexPath) as! DashboardTableViewCell)
        cell.travelTitleLabel.text = travelList[indexPath.row].title
        cell.climateLabel.text = travelList[indexPath.row].climate
        cell.currencyRateLabel.text = travelList[indexPath.row].budget
        cell.dateLabel.text = travelList[indexPath.row].date
        cell.placeLabel.text = travelList[indexPath.row].place
        cell.travelLengthLabel.text = travelList[indexPath.row].days.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelList.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            travelList.remove(at: indexPath.row)
            saveData(travelList)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

//MARK: - Save/Load list to userDefault
@available(iOS 14.0, *)
extension DashboradViewController {
    
    func saveData(_ data: [Travel]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(data)
            UserDefaults.standard.set(data, forKey: "travel")
        } catch {
            print("Unable to Encode travel object (\(error))")
        }
    }
    
    func loadData()-> [Travel] {
        if let data = UserDefaults.standard.data(forKey: "travel") {
            do {
                let decoder = JSONDecoder()
                return try decoder.decode([Travel].self, from: data)
            } catch {
                print("Unable to Decode travel object (\(error))")
                return MockData.shared.travelMockData
            }
        }
        return travelList
    }
}



