//
//  Extensions.swift
//  Bag-Pack
//
//  Created by Reza Kashkoul on 17/1/1401 AP.
//

import Foundation
import UIKit

//MARK: - Setup Title For ViewController
extension UIViewController {
    
    func setTitle(title:String, subtitle:String) -> UIView {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: -2, width: 0, height: 0))
        let subtitleLabel = UILabel(frame: CGRect(x: 0, y: 18, width: 0, height: 0))
        if #available(iOS 13.0, *) {
            titleLabel.textColor = UIColor.label
            subtitleLabel.textColor = UIColor.label
        } else {
            titleLabel.textColor = UIColor.black
            subtitleLabel.textColor = UIColor.black
        }
        titleLabel.backgroundColor = UIColor.clear
        subtitleLabel.backgroundColor = UIColor.clear
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        subtitleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.text = title
        subtitleLabel.text = subtitle
        titleLabel.sizeToFit()
        subtitleLabel.sizeToFit()
        
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: max(titleLabel.frame.size.width, subtitleLabel.frame.size.width), height: 30))
        titleView.addSubview(titleLabel)
        titleView.addSubview(subtitleLabel)
        
        let widthDiff = subtitleLabel.frame.size.width - titleLabel.frame.size.width
        
        if widthDiff < 0 {
            let newX = widthDiff / 2
            subtitleLabel.frame.origin.x = abs(newX)
        } else {
            let newX = widthDiff / 2
            titleLabel.frame.origin.x = newX
        }
        
        return titleView
    }
    
}

extension UITextView: UITextViewDelegate {
    
    override open var bounds: CGRect {
        didSet {
            self.resizePlaceholder()
        }
    }
    
    public var placeholder: String? {
        get {
            var placeholderText: String?
            
            if let placeholderLabel = self.viewWithTag(100) as? UILabel {
                placeholderText = placeholderLabel.text
            }
            
            return placeholderText
        }
        set {
            if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
                placeholderLabel.text = newValue
                placeholderLabel.sizeToFit()
            } else {
                self.addPlaceholder(newValue!)
            }
        }
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        if let placeholderLabel = self.viewWithTag(100) as? UILabel {
            placeholderLabel.isHidden = !self.text.isEmpty
        }
    }
    
    private func resizePlaceholder() {
        if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
            let labelX = self.textContainer.lineFragmentPadding
            let labelY = self.textContainerInset.top - 2
            let labelWidth = self.frame.width - (labelX * 2)
            let labelHeight = placeholderLabel.frame.height
            placeholderLabel.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
        }
    }
    
    private func addPlaceholder(_ placeholderText: String) {
        let placeholderLabel = UILabel()
        placeholderLabel.text = placeholderText
        placeholderLabel.sizeToFit()
        placeholderLabel.font = self.font
        placeholderLabel.textColor = appGlobalTintColor
        placeholderLabel.tag = 100
        placeholderLabel.isHidden = !self.text.isEmpty
        self.addSubview(placeholderLabel)
        self.resizePlaceholder()
        self.delegate = self
    }
}

extension UITextField {
    
    func setPlaceHolderColor(color: UIColor){
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : color])
    }
    
    func setupUI(){
        borderStyle = .roundedRect
        layer.masksToBounds = true
        layer.cornerRadius = frame.size.height/2
        clipsToBounds = false
        layer.shadowOpacity=0.2
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowColor = UIColor.darkGray.cgColor
        setPlaceHolderColor(color: .gray)
    }
}

extension UITableView {
    
    func showNoDataIfNeeded() {
        let noDataLabel : UILabel = UILabel()
        noDataLabel.frame = CGRect(x: 0, y: 0 , width: (bounds.width), height: (bounds.height))
        noDataLabel.text = "There's no data"
        noDataLabel.textColor = appGlobalTintColor
        noDataLabel.textAlignment = .center
        DispatchQueue.main.async { [self] in
            if visibleCells.isEmpty {
                backgroundView = noDataLabel
                separatorStyle = .none
            } else {
                backgroundView = nil
                separatorStyle = .singleLine
            }
        }
    }
}

extension UserDefaults {
    
    func colorForKey(key: String) -> UIColor? {
        var colorReturnded: UIColor?
        if let colorData = data(forKey: key) {
            do {
                if let color = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(colorData) as? UIColor {
                    colorReturnded = color
                }
            } catch {
                print("Error UserDefaults: colorForKey")
                return nil
            }
        }
        return colorReturnded
    }
    
    func setColor(color: UIColor?, forKey key: String) {
        var colorData: NSData?
        if let color = color {
            do {
                let data = try NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: false) as NSData?
                colorData = data
            } catch {
                print("Error UserDefaults: setColor")
            }
        }
        set(colorData, forKey: key)
    }
}

extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

extension Int {
    
    func convertToCurrencyUnit() -> String {
        switch self {
        case 0:
            return "$"
        case 1:
            return "€"
        case 2:
            return "Rials"
        default:
            return "Not Specified"
        }
    }
    
}
