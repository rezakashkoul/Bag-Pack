//
//  DashboradViewController.swift
//  Bag-Pack
//
//  Created by Reza Kashkoul on 20/Bahman/1400 .
//

import UIKit
import netfox

class DashboradViewController: UIViewController, NewEntryViewControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
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
        loadData()
        DispatchQueue.main.async {[self] in
            tableView.reloadData()
            tableView.showNoDataIfNeeded()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        view.window?.tintColor = appGlobalTintColor
        if isDarkMode {
            if #available(iOS 13.0, *) {
                view.window?.overrideUserInterfaceStyle = .dark
            } else {
                // Fallback on earlier versions
            }
        } else {
            if #available(iOS 13.0, *) {
                view.window?.overrideUserInterfaceStyle = .light
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func setupNavigationBarAndItems() {
        navigationItem.title = "BagPack"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New", style: .done, target: self, action: #selector(newButtonTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Settings", style: .done, target: self, action: #selector(goToSettings))
    }
    
    func setupUI() {
        setupNavigationBarAndItems()
        tableView.register(UINib(nibName: "DashboardTableViewCell", bundle: nil), forCellReuseIdentifier: "DashboardTableViewCell")
        if appGlobalTintColor == nil {
            appGlobalTintColor = .systemBlue
        }
    }
    
    @objc func newButtonTapped () {
        let vc = storyboard?.instantiateViewController(withIdentifier: "NewEntryViewController") as! NewEntryViewController
        currentTrip = nil
        vc.delegate = self
        navigationController?.present(vc, animated: true)
    }
    
    @objc func goToSettings() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func goForFillData(tripData: Travel) {
        allTrips.append(currentTrip!)
        saveData()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        let vc = storyboard?.instantiateViewController(withIdentifier: "MainTabBarController")
        navigationController?.pushViewController(vc!, animated: true)
        //        if allTrips?.filter({
        //            $0.title.lowercased() == tripData.title.lowercased() &&
        //            $0.place.lowercased() == tripData.place.lowercased() &&
        //            $0.days.lowercased() == tripData.days.lowercased()
        //        }).count == 0 {
        //            allTrips?.append(tripData)
        //            saveData()
        //            DispatchQueue.main.async {
        //                self.tableView.reloadData()
        //            }
        //
        //            let vc = storyboard?.instantiateViewController(withIdentifier: "MainTabBarController")
        //            navigationController?.pushViewController(vc!, animated: true)
        //        } else {
        //            AlertManager.shared.showAlert(parent: self, title: "Dublicated trip", body: "The trip you entered is already exist", buttonTitles: ["Try again"], style: .alert, showCancelButton: true) { buttonIndex in
        //                if buttonIndex == 0 {
        //                    self.newButtonTapped()
        //                }
        //            }
        //        }
    }
    
    func fetchTravelData() {
        NetworkManager.shared.getTravelData(useMockData: useMockData) { result in
            switch result {
            case .success(let travelList):
                allTrips = travelList
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

extension DashboradViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "DashboardTableViewCell", for: indexPath) as! DashboardTableViewCell)
        cell.travelTitleLabel.text = allTrips[indexPath.row].title
        //        cell.climateLabel.text = travelList[indexPath.row].climate
        cell.currencyRateLabel.text = allTrips[indexPath.row].budget
        //        cell.dateLabel.text = travelList[indexPath.row].date
        cell.placeLabel.text = allTrips[indexPath.row].place
        cell.travelLengthLabel.text = allTrips[indexPath.row].days.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTrips.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "MainTabBarController")
        currentTrip = allTrips[indexPath.row]
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            allTrips.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveData()
            tableView.showNoDataIfNeeded()
        }
    }
}
