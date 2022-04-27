//
//  DashboradViewController.swift
//  Bag-Pack
//
//  Created by Reza Kashkoul on 20/Bahman/1400 .
//

import UIKit
import netfox
import WhatsNewKit

class DashboradViewController: UIViewController, NewEntryViewControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var showWelcomeToAppIsShown = false {
        didSet{
                if showWelcomeToAppIsShown {
                    showWelcomeToDashBoard()
                    showWelcomeToAppIsShown = false
                }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        setupUI()
        //        fetchTravelData()
        showWelcomeToApp()
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
    
    func showWelcomeToDashBoard() {
        let detailVc = WhatsNewViewController(
            whatsNew:
                WhatsNew(title: "Add a New Entry!", items: [
                    WhatsNew.Item(title: "To add a new entry, press the \"New\" button on the top right corner", subtitle: "", image: UIImage(named: "new")),
                ]))
        present(detailVc, animated: true)
        showWelcomeToAppIsShown = false
    }
    
    func showWelcomeToApp() {
        let vc = WhatsNewViewController(
            whatsNew:
                WhatsNew(title: "Welcome to BagPack!", items: [
                    WhatsNew.Item(title: "You can add manage your trips by", subtitle: "", image: UIImage(named: "manage")),
                    WhatsNew.Item(title: "Adding a trip, you can easily", subtitle: "", image: UIImage(named: "add")),
                    WhatsNew.Item(title: "Set a name for it", subtitle: "", image: UIImage(named: "easy")),
                    WhatsNew.Item(title: "Specify the distenation", subtitle: "", image: UIImage(named: "destination")),
                    WhatsNew.Item(title: "Set your desired budget", subtitle: "", image: UIImage(named: "budget")),
                    WhatsNew.Item(title: "The period of the travel days", subtitle: "", image: UIImage(named: "days")),
                    WhatsNew.Item(title: "Write down your essential items", subtitle: "", image: UIImage(named: "essential")),
                    WhatsNew.Item(title: "Keep your total spending by details", subtitle: "", image: UIImage(named: "spending")),
                    WhatsNew.Item(title: "Note your comments freely", subtitle: "", image: UIImage(named: "noteItem")),
                    WhatsNew.Item(title: "And finaly save them easily with the date", subtitle: "", image: UIImage(named: "ok")),
                ])
        )
//        vc.configuration.tintColor = appGlobalTintColor
        //        vc.configuration.itemsView.autoTintImage = false
        showWelcomeToAppIsShown = true
        present(vc, animated: true)
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
