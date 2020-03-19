//
//  CountryViewTheme.swift
//  CountryPickerSwift
//
//  Created by Valentyn Mialin on 16.01.2020.
//  Copyright © 2020 Mialin. All rights reserved.

import UIKit

public struct CountryViewTheme {
    
    public let countryCodeTextColor: UIColor
    public let countryNameTextColor: UIColor
    public let rowBackgroundColor: UIColor
    public let showFlagsBorder: Bool
    
    public init(countryCodeTextColor: UIColor = UIColor.gray,
                countryNameTextColor: UIColor = UIColor.darkGray,
                rowBackgroundColor: UIColor = UIColor.white,
                showFlagsBorder: Bool = true) {
        self.countryCodeTextColor = countryCodeTextColor
        self.countryNameTextColor = countryNameTextColor
        self.rowBackgroundColor = rowBackgroundColor
        self.showFlagsBorder = showFlagsBorder
    }
}
