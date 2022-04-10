//
//  SettingsTableViewCell.swift
//  Bag-Pack
//
//  Created by Reza Kashkoul on 21/1/1401 AP.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var colorView: UIView!
    
    @IBAction func themeSwitch(_ sender: Any) {
        print("switch changed value")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        colorView.layer.cornerRadius = 16.5 //colorView.frame.size.width/2
        colorView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
