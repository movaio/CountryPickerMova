//
//  CountryPicker.swift
//  Hyber
//
//  Created by Valentyn Mialin on 16.01.2020.
//  Copyright © 2020 Mialin. All rights reserved.
//

import Foundation
import UIKit
import CoreTelephony

/// CountryPickerDelegate
///
/// - Parameters:
///   - picker: UIPickerVIew
///   - name: Name of selected element
///   - countryCode: Country code shortcut
///   - phoneCode: Phone digit code of country
///   - flag: Flag of country
@objc public protocol CountryPickerDelegate {
    @objc func countryPhoneCodePicker(_ picker: CountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: String)
}

/// Structure of country code picker
public struct Country {
    public let code: String?
    public let name: String?
    public let phoneCode: String?
    public let flagName: String?
    
    /// Country code initialization
    ///
    /// - Parameters:
    ///   - code: String
    ///   - name: String
    ///   - phoneCode: String
    ///   - flagName: String
    init(code: String?, name: String?, phoneCode: String?, flagName: String?) {
        self.code = code
        self.name = name
        self.phoneCode = phoneCode
        self.flagName = flagName
    }
    
}

public class CountryPicker: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource, UIGestureRecognizerDelegate {
    open var currentCountry: Country?
    @objc public var displayOnlyCountriesWithCodes: [String]?
    @objc public var exeptCountriesWithCodes: [String]?
    
    var countries: [Country] {
        let allCountries: [Country] = CountryPicker.countryNamesByCode()
        if let display = displayOnlyCountriesWithCodes {
            let filtered = allCountries.filter { country in display.contains(where: { code in country.code == code }) }
            return filtered
        }
        if let display = exeptCountriesWithCodes {
            let filtered = allCountries.filter { country in display.contains(where: { code in country.code != code }) }
            return filtered
        }
        return allCountries.sorted { (country1, country2) -> Bool in
            if let country1Name = country1.name,
                let country2Name = country2.name {
                return country1Name < country2Name
            }
            return false
        }
    }
    @objc public weak var countryPickerDelegate: CountryPickerDelegate?
    @objc public var showPhoneNumbers: Bool = false
    open var theme: CountryViewTheme?
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    /// init
    ///
    /// - Parameter frame: initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    /// Setup country code picker
    func setup() {
        super.dataSource = self
        super.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(pickerTapped(tapRecognizer:)))
        tap.cancelsTouchesInView = false
        tap.delegate = self
        self.addGestureRecognizer(tap)
    }
    
    // MARK: - Country Methods
    
    /// setCountry
    ///
    /// - Parameter code: selected country
    public func setCountry(_ code: String) {
        let row = countries.firstIndex(where: {$0.code == code}) ?? 0
        
        self.selectRow(row, inComponent: 0, animated: true)
        let country = countries[row]
        currentCountry = country
        if let countryPickerDelegate = countryPickerDelegate {
            countryPickerDelegate.countryPhoneCodePicker(self, didSelectCountryWithName: country.name!, countryCode: country.code!, phoneCode: country.phoneCode!, flag: country.flagName!)
        }
    }
    
    /// setCountryByPhoneCode
    /// Init with phone code
    /// - Parameter phoneCode: String
    public func setCountryByPhoneCode(_ phoneCode: String) {
        let row = countries.firstIndex(where: {$0.phoneCode == phoneCode}) ?? 0
        
        self.selectRow(row, inComponent: 0, animated: true)
        let country = countries[row]
        currentCountry = country
        if let countryPickerDelegate = countryPickerDelegate {
            countryPickerDelegate.countryPhoneCodePicker(self, didSelectCountryWithName: country.name!, countryCode: country.code!, phoneCode: country.phoneCode!, flag: country.flagName!)
        }
    }
    
    public static func flag(from country: String) -> String {
        let base: UInt32 = 127397
        var s = ""
        for v in country.uppercased().unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return s
    }
    
    // Populates the metadata from the included json file resource
    
    /// sorted array with data
    ///
    /// - Returns: sorted array with all information phone, flag, name
    private static func countryNamesByCode() -> [Country] {
        let countries = NSLocale.isoCountryCodes.map({ (countryCode) -> Country in
            let name = Locale(identifier: "en_US").localizedString(forRegionCode: countryCode.uppercased())!
            let phoneCode = CountryCallingCodes.phonceCode(countryCode: countryCode)
            let flagName = flag(from: countryCode)
            return Country(code: countryCode, name: name, phoneCode: phoneCode, flagName: flagName)
        }).filter({$0.phoneCode != ""})
        return countries
    }
    
    // MARK: - Picker Methods
    
    open func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    /// pickerView
    ///
    /// - Parameters:
    ///   - pickerView: CountryPicker
    ///   - component: Int
    /// - Returns: counts of array's elements
    open func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
    }
    
    /// PickerView
    /// Initialization of Country pockerView
    /// - Parameters:
    ///   - pickerView: UIPickerView
    ///   - row: row
    ///   - component: count of countries
    ///   - view: UIView
    /// - Returns: UIView
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var resultView: CountryView
        
        if view == nil {
            if let theme = self.theme {
                resultView = CountryView(theme: theme)
            } else {
                resultView = CountryView()
            }
        } else {
            resultView = view as! CountryView
        }
        
        resultView.setup(countries[row])
        if !showPhoneNumbers {
            resultView.countryCodeLabel.isHidden = true
        }
        return resultView
    }
    
    /// Function for handing data from UIPickerView
    ///
    /// - Parameters:
    ///   - pickerView: CountryPickerView
    ///   - row: selectedRow
    ///   - component: description
    @objc open func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let country = countries[row]
        currentCountry = country
        if let countryPickerDelegate = countryPickerDelegate {
            countryPickerDelegate.countryPhoneCodePicker(self, didSelectCountryWithName: country.name!, countryCode: country.code!, phoneCode: country.phoneCode!, flag: country.flagName!)
        }
    }
    
    @objc
    func pickerTapped(tapRecognizer: UITapGestureRecognizer) {
        if tapRecognizer.state == .ended {
            let rowHeight: CGFloat = self.rowSize(forComponent: 0).height
            let selectedRowFrame: CGRect = self.bounds.insetBy(dx: 0, dy: (self.frame.height - rowHeight) / 2.0)
            let userTappedOnSelectedRow = selectedRowFrame.contains(tapRecognizer.location(in: self))
            if userTappedOnSelectedRow {
                _ = self.pickerView(self, didSelectRow: self.selectedRow(inComponent: 0), inComponent: 0)
            }
        }
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}
