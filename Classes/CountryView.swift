//
//  CountryView.swift
//  Hyber
//
//  Created by Valentyn Mialin on 16.01.2020.
//  Copyright © 2020 Mialin. All rights reserved.
//

import Foundation
import UIKit

class NibLoadingView: UIView {
    
    @IBOutlet weak var view: UIView!
    
    /// Init
    ///
    /// - Parameter frame: frame descript
    override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }
    
    /// Setup XIB
    fileprivate func nibSetup() {
        backgroundColor = UIColor.clear
        
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        
        addSubview(view)
    }
    
    /// Load XIB
    ///
    /// - Returns: XIBView
    fileprivate func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return nibView
    }
    
}

/// Load country view from XIB file
class CountryView: NibLoadingView {
    
    @IBOutlet weak var flagImageLabel: UILabel!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var countryCodeLabel: UILabel!
    
    init(theme: CountryViewTheme) {
        super.init(frame: .zero)
        setup(theme: theme)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /// Setup custop pickerView to UIPickerView
    /// initialized by country code
    /// - Parameter country: Countrycode
    func setup(_ country: Country) {
        flagImageLabel.text = country.flagName
        countryNameLabel.text = country.name
        countryCodeLabel.text = "+" + (country.phoneCode ?? "")
    }
    
    private func setup(theme: CountryViewTheme) {
        view.backgroundColor = theme.rowBackgroundColor
        countryCodeLabel.textColor = theme.countryCodeTextColor
    }
}
