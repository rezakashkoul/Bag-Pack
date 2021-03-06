//
//  SettingsTableViewCell.swift
//  Bag-Pack
//
//  Created by Reza Kashkoul on 21/1/1401 AP.
//

import UIKit

protocol SettingsTableViewCellDelegate: AnyObject {
    func darkModeSwitchIsChanged(switchState: Bool)
}

class SettingsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var themeSwitch: UISwitch!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var currencySegment: UISegmentedControl!
    
    @IBAction func currencySegmentAction(_ sender: Any) {
        switch currencySegment.selectedSegmentIndex {
        case 0:
            appCurrencyUnit = .dollar
        case 1:
            appCurrencyUnit = .euro
        case 2:
            appCurrencyUnit = .rial
        default:
            break
        }
    }
    
    @IBAction func themeSwitchAction(_ sender: Any) {
        isDarkMode.toggle()
        if #available(iOS 13.0, *) {
            delegate?.darkModeSwitchIsChanged(switchState: isDarkMode)
        } else {
            // Fallback on earlier versions
        }
    }
    
    weak var delegate: SettingsTableViewCellDelegate? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        colorView.layer.cornerRadius = 16.5 //colorView.frame.size.width/2
        colorView.clipsToBounds = true
        themeSwitch.isOn = !isDarkMode
        currencySegment.selectedSegmentIndex = appCurrencyUnit?.rawValue ?? 0
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
