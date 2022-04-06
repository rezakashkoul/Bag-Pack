//
//  CostTableViewCell.swift
//  Bag-Pack
//
//  Created by Reza Kashkoul on 17/1/1401 AP.
//

import UIKit

class CostTableViewCell: UITableViewCell {

    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemCostLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
