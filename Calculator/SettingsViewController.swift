//
//  SettingsViewController.swift
//  Calculator
//
//  Created by Paul Aan on 2/5/16.
//  Copyright © 2016 Paul Aan. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {

    var CURRENCIES = [:]
    var settingCells = [SettingCell]()

    @IBOutlet var settings: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingCells = [
            SettingCell(name: SettingCell.SETTING_TIPS, info: "Set default value for tip", value: "10"),
            SettingCell(name: SettingCell.SETTING_CURRENCY, info: "Default currency", value: SettingCell.CURRENCY_VND)
        ];
        CURRENCIES = [
            SettingCell.CURRENCY_VND: "VND",
            SettingCell.CURRENCY_USD: "USD"
        ]
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let setting: SettingCell
                setting = settingCells[indexPath.row]
                let controller = (segue.destinationViewController as! SettingController)
                controller.setting = setting
            }
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let setting : SettingCell
        setting = settingCells[indexPath.row]
        cell.textLabel?.text = setting.name
        cell.detailTextLabel?.text = setting.info
        return cell
    }
    
    // MARK: - Table View
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingCells.count
    }
    
    @IBAction func indexChanged(sender:UISegmentedControl)
    {
    }
}
