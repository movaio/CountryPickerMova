# CountryPickerMova
[![CI Status](https://img.shields.io/travis/valic/CountryPickerMova.svg?style=flat)](https://travis-ci.org/valic/CountryPickerMova)
[![Version](https://img.shields.io/cocoapods/v/CountryPickerMova.svg?style=flat)](https://cocoapods.org/pods/CountryPickerMova)
[![License](https://img.shields.io/cocoapods/l/CountryPickerMova.svg?style=flat)](https://cocoapods.org/pods/CountryPickerMova)
[![Platform](https://img.shields.io/cocoapods/p/CountryPickerMova.svg?style=flat)](https://cocoapods.org/pods/CountryPickerMova)

![Demo](https://github.com/valic/CountryPickerMova/blob/master/CountryPickerMova.PNG)

## Example

```ruby
    let countryPicker = CountryPicker()
    countryPicker.setCountry("en_US")
    countryPicker.backgroundColor = .white
    let theme = CountryViewTheme(countryCodeTextColor: Asset.slateGrey.color,
                                 countryNameTextColor: Asset.slateGrey.color,
                                 rowBackgroundColor: .white,
                                 showFlagsBorder: false)
    countryPicker.theme = theme
    countryPicker.showPhoneNumbers = false
    countryPicker.countryPickerDelegate = self
    
    textField.inputView = countryPicker
    textField.tintColor = .clear
```


## Installation

CountryPickerMova is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CountryPickerMova'
```

## Author

valic, valic.my@gmail.com

## License

CountryPickerMova is available under the MIT license. See the LICENSE file for more info.
