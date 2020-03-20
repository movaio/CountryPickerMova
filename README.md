# CountryPickerMova

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
