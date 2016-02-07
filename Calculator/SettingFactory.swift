//
//  SettingFactory.swift
//  Calculator
//
//  Created by Paul Aan on 2/6/16.
//  Copyright © 2016 Paul Aan. All rights reserved.
//
import UIKit
import Foundation

public class SettingFactory {
    
    private var delegate: UIViewController
    private var setting: SettingCell
    
    init(delegate: UIViewController, setting: SettingCell){
        self.delegate = delegate
        self.setting = setting
    }
    
    func getView() -> UIView {
        if setting.name == SettingCell.SETTING_TIPS {
            return self.getTipView(setting)
        }
        else{
            return self.getCurrencyView(setting)
        }
    }
    
    func getCurrencyView(setting: SettingCell) -> UIView {
        var selector: UIPickerView
        selector = UIPickerView()
        
        selector.delegate = self.delegate as? UIPickerViewDelegate
        return selector
    }
    
    func getTipView(setting: SettingCell) -> UIView{
        let textField = UITextField(frame: CGRectMake(20, 100, 300, 40))
        textField.placeholder = setting.info
        textField.font = UIFont.systemFontOfSize(15)
        textField.borderStyle = UITextBorderStyle.RoundedRect
        textField.autocorrectionType = UITextAutocorrectionType.No
        textField.keyboardType = UIKeyboardType.Default
        textField.returnKeyType = UIReturnKeyType.Done
        textField.clearButtonMode = UITextFieldViewMode.WhileEditing;
        textField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        textField.delegate = self.delegate as? UITextFieldDelegate
        let exist = self.loadValue()
        if exist.isEmpty{
            textField.text = setting.value
        }
        else {
            textField.text = exist
        }
        textField.keyboardType = UIKeyboardType.DecimalPad
        
        return textField
    }
    
    private func loadValue() -> String{
        return SettingFactory.readValue(self.setting.name)
    }
    
    private static func readValue(key: String) -> String{
        let defaults = NSUserDefaults.standardUserDefaults()
        if let storedValue = defaults.objectForKey(key) as? String{
            return String(storedValue)
        }
        return ""
    }
    
    static func getCurrencySymbol() -> String{
        var symbol = "$"
        let currency = SettingFactory.readValue(SettingCell.SETTING_CURRENCY)
        if currency == SettingCell.CURRENCY_VND {
            symbol = "đ"
        }
        return symbol
    }
    
    static func getTips() -> String{
        let tips = String(SettingFactory.readValue(SettingCell.SETTING_TIPS))
        return tips
    }
}