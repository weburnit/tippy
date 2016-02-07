//
//  ViewController.swift
//  Calculator
//
//  Created by Paul Aan on 2/5/16.
//  Copyright © 2016 Paul Aan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    
    @IBOutlet weak var tipValue: UILabel!
    
    @IBOutlet weak var totalBill: UILabel!
    
    @IBOutlet weak var settings: UIBarButtonItem!
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        billField.addTarget(self, action: "updateBill:", forControlEvents: UIControlEvents.EditingChanged)
        let tips = !SettingFactory.getTips().isEmpty ? SettingFactory.getTips() : "10"
        self.tipValue.text = String(format: "%@%%", tips)
        // Do any additional setup after loading the view, typically from a nib.
//            [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action: @selector(onSettingsButton)];
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        if !SettingFactory.getTips().isEmpty{
            self.tipValue.text = String(format: "%@%%", SettingFactory.getTips())
        }
        self.updateBill(self.billField)
    }
    
    func updateBill(text: UITextField){
        if(!text.text!.isEmpty){
            let tip = ((Int(text.text!)! * Int(self.getTips())!)/100)
            let totalBill = tip + Int(billField.text!)!
            self.totalBill.text = String(format: "%@%d", SettingFactory.getCurrencySymbol(), totalBill)
        }
    }
    
    private func getTips() -> String{
        let tips = self.tipValue.text?.stringByReplacingOccurrencesOfString(String(format:"%%"), withString: "")
        return tips!
    }
    
    @IBAction func onChange(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.tipValue.text = String(format:"10%%")
        case 1:
            self.tipValue.text = String(format:"20%%")
        default:
            self.tipValue.text = String(format:"30%%")
        }
        self.updateBill(self.billField)
    }
}

