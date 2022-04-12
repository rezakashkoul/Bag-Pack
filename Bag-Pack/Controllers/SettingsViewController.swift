//
//  SettingsViewController.swift
//  Bag-Pack
//
//  Created by Reza Kashkoul on 21/1/1401 AP.
//

import UIKit

class SettingsViewController: UIViewController, SettingsTableViewCellDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let items = ["Tint Color", "Dark Theme", "Common Currencies" , "Reset Application Data", "App Version"]
    
    var picker: Any?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        if #available(iOS 14.0, *) {
            setupPicker()
        } else {
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SettingsTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingsTableViewCell")
        tableView.separatorStyle = .none
        navigationController?.navigationBar.prefersLargeTitles = false
        title = "Settings"
    }
    
    func darkModeSwitchIsChanged(switchState: Bool) {
        if #available(iOS 13.0, *) {
            if isDarkMode {
                view.window?.overrideUserInterfaceStyle = .light
            } else {
                view.window?.overrideUserInterfaceStyle = .dark
            }
        } else {
        }
    }
    
    func cleanData() {
        UserDefaults.standard.set(nil, forKey: "settings")
        UserDefaults.standard.set(nil, forKey: "note")
        UserDefaults.standard.set(nil, forKey: "cost")
        UserDefaults.standard.set(nil, forKey: "essential")
        UserDefaults.standard.set(nil, forKey: "unit")
        appGlobalTintColor = nil
        appCurrencyUnit = .dollar
        if #available(iOS 14.0, *) {
            changeSystemTintColor()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } else {
            // Fallback on earlier versions
        }
        
        // and clean model data
    }
    
    
} 

//MARK: - Setup TableView
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as! SettingsTableViewCell
        cell.delegate = self
        cell.titleLabel.text = items[indexPath.row]
        
        if indexPath.row == 0 {
            cell.colorView.isHidden = false
            cell.colorView.backgroundColor = appGlobalTintColor ?? .systemBlue
        } else {
            cell.colorView.isHidden = true
        }
        if indexPath.row == 1 {
            cell.themeSwitch.isHidden = false
        } else {
            cell.themeSwitch.isHidden = true
        }
        if indexPath.row == 2 {
            cell.currencySegment.isHidden = false
            cell.currencySegment.selectedSegmentIndex = appCurrencyUnit?.rawValue ?? 0
        } else {
            cell.currencySegment.isHidden = true
        }
        if indexPath.row == 4 {
            let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
            cell.versionLabel.isHidden = false
            cell.versionLabel.text = appVersion
        } else {
            cell.versionLabel.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if #available(iOS 14.0, *) {
                openPicker()
            } else {
                
            }
        }
        if indexPath.row == 3 {
            AlertManager.shared.showAlert(parent: self, title: "Reset application data", body: "By doing this you'll clean every data and entries", buttonTitles: ["Do it anyway"], style: .alert, showCancelButton: true) { _ in
                self.cleanData()
            }
            
        }
    }
}

@available(iOS 14.0, *)
extension SettingsViewController: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        appGlobalTintColor = viewController.selectedColor
        changeSystemTintColor()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        appGlobalTintColor = viewController.selectedColor
    }
    
    func setupPicker() {
        picker = UIColorPickerViewController()
        (picker as! UIColorPickerViewController).delegate = self
    }
    
    func openPicker() {
        (picker as! UIColorPickerViewController).selectedColor = appGlobalTintColor ?? .systemBlue
        self.present((picker as! UIColorPickerViewController), animated: true, completion: nil)
    }
    
    func changeSystemTintColor() {
        view.window?.tintColor = appGlobalTintColor
        if let appdelegate = UIApplication.shared.delegate as? AppDelegate {
            appdelegate.window = view.window
            appdelegate.window?.makeKeyAndVisible()
        }
    }
}
