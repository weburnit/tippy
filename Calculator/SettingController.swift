//
//  SettingController.swift
//  Calculator
//
//  Created by Paul Aan on 2/5/16.
//  Copyright © 2016 Paul Aan. All rights reserved.
//

import UIKit

class SettingController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    var pickerDataSource = [SettingCell.CURRENCY_USD, SettingCell.CURRENCY_VND]
    
    var setting: SettingCell = SettingCell(name: "", info:"", value: "")
    
    func setSetting(setting: SettingCell){
        self.setting = setting
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let viewFactory = SettingFactory(delegate: self, setting: self.setting)
        let uiView:UIView = viewFactory.getView()
        if uiView is UIPickerView{
            let uiView = uiView as! UIPickerView
            uiView.dataSource = self;
            let selectedValue = loadValue()
            if !selectedValue.isEmpty {
                var index:Int = 0
                for currency in pickerDataSource {
                    if currency == selectedValue {
                        break
                    } else {
                        index++
                    }
                }
                uiView.selectRow(index, inComponent: 0, animated: true)
            }
        } else {
            let uiView = uiView as! UITextField
            uiView.addTarget(self, action: "updateValue:", forControlEvents: UIControlEvents.EditingChanged)
        }
    
        self.view.frame = CGRectMake(0, 0, 100, 40);
        self.view.addSubview(uiView)

        // Do any additional setup after loading the view.
    }
    
    func updateValue(textField: UITextField){
        if textField.text != ""{
            self.saveValue(textField.text!)
        }
    }
    
    private func saveValue(value: String){
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(value, forKey: self.setting.name)
        defaults.synchronize()
    }
    
    func loadValue() -> String{
        let defaults = NSUserDefaults.standardUserDefaults()
        if let storedValue = defaults.objectForKey(self.setting.name) as? String{
            return storedValue
        }
        return ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.saveValue(self.pickerDataSource[row])
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
