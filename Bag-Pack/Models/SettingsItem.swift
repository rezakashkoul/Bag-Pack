//
//  SettingsItem.swift
//  Bag-Pack
//
//  Created by Reza Kashkoul on 31/1/1401 AP.
//

import Foundation

struct SettingItem {
    var title: String
    var type: SettingCellType
}

enum SettingCellType {
    case tintColor, darkMode, currencyUnit, resetAppData, resetSettings, appVersion
}
