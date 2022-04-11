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
    
} 

//MARK: - Setup TableView
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as! SettingsTableViewCell
        cell.delegate = self
        cell.titleLabel.text = items[indexPath.row]
        
        if indexPath.row == 0 {
            cell.colorView.isHidden = false
            cell.colorView.backgroundColor = appGlobalTintColor ?? .red
        } else {
            cell.colorView.isHidden = true
        }
        
        if indexPath.row == 1 {
            cell.themeSwitch.isHidden = false
        } else {
            cell.themeSwitch.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.allowsSelection = false
        if indexPath.row == 0 {
            if #available(iOS 14.0, *) {
                openPicker()
            } else {
                
            }
        }
    }
}

@available(iOS 14.0, *)
extension SettingsViewController: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        appGlobalTintColor = viewController.selectedColor
        view.window?.tintColor = appGlobalTintColor
        if let appdelegate = UIApplication.shared.delegate as? AppDelegate {
            appdelegate.window = view.window
            appdelegate.window?.makeKeyAndVisible()
        }
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
}

//MARK: - Save/Load Settings to userDefault
extension SettingsViewController {
    
    func saveSettings(_ value: [String]){
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(value)
            UserDefaults.standard.set(data, forKey: "settings")
        } catch {
            print("Unable to Encode Settings (\(error))")
        }
    }
    
    func loadSettings()-> [String] {
        if let data = UserDefaults.standard.data(forKey: "settings") {
            do {
                let decoder = JSONDecoder()
                return try decoder.decode([String].self, from: data)
            } catch {
                print("Unable to Decode Settings (\(error))")
                return []
            }
        }
        return []
    }
}

