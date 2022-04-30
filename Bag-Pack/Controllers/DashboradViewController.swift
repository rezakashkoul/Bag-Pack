//
//  DashboradViewController.swift
//  Bag-Pack
//
//  Created by Reza Kashkoul on 20/Bahman/1400 .
//

import UIKit
import netfox
import AppleWelcomeScreen

class DashboradViewController: UIViewController, NewEntryViewControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var showWelcomeToAppIsShown = false
    
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
        changeTheme()
        if !appWelcomeDidShow {
            showGuide()
        }

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func setupNavigationBarAndItems() {
        navigationItem.title = "BagPack"
        let newItemsButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newButtonTapped))
        let showGuideButton = UIBarButtonItem(image: UIImage(named: "help"), style: .plain, target: self, action: #selector(showGuideAction))
        navigationItem.rightBarButtonItems = [newItemsButton,showGuideButton]
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Settings", style: .done, target: self, action: #selector(goToSettings))
    }
    
    func setupUI() {
        setupNavigationBarAndItems()
        tableView.register(UINib(nibName: "DashboardTableViewCell", bundle: nil), forCellReuseIdentifier: "DashboardTableViewCell")
        tableView.tableFooterView = UIView()
        if appGlobalTintColor == nil {
            appGlobalTintColor = .systemBlue
        }
    }
    
    func changeTheme() {
        if #available(iOS 13.0, *) {
            if isDarkMode {
                view.window?.overrideUserInterfaceStyle = .dark
            } else {
                view.window?.overrideUserInterfaceStyle = .light
            }
        } else {
        }
    }
    
    @objc func newButtonTapped () {
        let vc = storyboard?.instantiateViewController(withIdentifier: "NewEntryViewController") as! NewEntryViewController
        currentTrip = nil
        vc.delegate = self
        navigationController?.present(vc, animated: true)
    }
    
    @objc private func showGuideAction() {
        showGuide()
    }
    
    @objc func goToSettings() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func goForFillData() {
        guard let currentTrip = currentTrip else { return }
        
        if allTrips.filter({$0.title == currentTrip.title && $0.place == currentTrip.place}).isEmpty {
            allTrips.append(currentTrip)
            saveData()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            let vc = storyboard?.instantiateViewController(withIdentifier: "MainTabBarController")
            navigationController?.pushViewController(vc!, animated: true)
        } else {
            AlertManager.shared.showAlert(parent: self, title: "Dublicated trip", body: "The trip you entered is already exist", buttonTitles: ["Try again"], style: .alert, showCancelButton: true) { buttonIndex in
                if buttonIndex == 0 {
                    self.newButtonTapped()
                }
            }
        }
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
    
    func showGuide() {
        var configuration = WelcomeScreenConfiguration(
            appName: "BagPack!",
            appDescription: "A good travel manager helps you to keep track of:",
            features: [
                WelcomeScreenFeature(
                    image: UIImage(named: "easy")!,
                    title: "Before trip plans;",
                    description: "Like desired budgets, places to visit and trip date."
                ),
                WelcomeScreenFeature(
                    image: UIImage(named: "add")!,
                    title: "Essential items;",
                    description: "The stuff you shouldn't forget to bring with you like phone charger etc.."
                ),
                WelcomeScreenFeature(
                    image: UIImage(named: "spending")!,
                    title: "Costs",
                    description: "You can easily add payment details with names during your trip."
                ),
                WelcomeScreenFeature(
                    image: UIImage(named: "noteItem")!,
                    title: "Notes",
                    description: "You can attach a note to your trip. This can helps you to never forgetting things about that event"
                )
            ]
        )
        appWelcomeDidShow = true
        configuration.tintColor = appGlobalTintColor
        present(WelcomeScreenViewController(configuration: configuration), animated: true)
    }
        
}

//MARK: Setup tableView

extension DashboradViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "DashboardTableViewCell", for: indexPath) as! DashboardTableViewCell)
        //        cell.climateLabel.text = travelList[indexPath.row].climate
        cell.currencyUnitLabel.text = appCurrencyUnit?.rawValue.convertToCurrencyUnit()
        cell.travelTitleLabel.text = allTrips[indexPath.row].title
        cell.currencyRateLabel.text = allTrips[indexPath.row].budget
        cell.dateLabel.text = allTrips[indexPath.row].date
        cell.placeLabel.text = allTrips[indexPath.row].place
        let days = allTrips[indexPath.row].days == "1" ? (allTrips[indexPath.row].days + " " + "Day") :  (allTrips[indexPath.row].days + " " + "Days")
        cell.travelLengthLabel.text = days
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

