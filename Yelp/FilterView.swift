//
//  FilterView.swift
//  Yelp
//
//  Created by Andrew Wen on 2/14/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

protocol FilterViewDelegate: class {
    func filterView(filterView: FilterView, didChangeFilters filters: NSMutableSet)
}

class FilterView: UIViewController, SwitchCellDelegate, UITableViewDelegate, UITableViewDataSource {
    
    weak var delegate: FilterViewDelegate?
    var filters = NSDictionary()
    var categories = NSArray()
    var selectedCategories = NSMutableSet()
    
    @IBOutlet weak var settingsTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUp()
        initCategories()
    }
    
    func setUp() {
        settingsTable.delegate = self
        settingsTable.dataSource = self
        settingsTable.tableFooterView = UIView()
        
        settingsTable.registerNib(UINib(nibName: "SwitchCell", bundle: nil), forCellReuseIdentifier: "SwitchCell")

        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Apply", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("applyFilter"))
        
//        UIBarButtonItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Normal)
//        UIBarButtonItem.appearance().tintColor = UIColor.whiteColor()
//        
//        navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()

    }

    func initCategories() {
        categories = YelpFilters().filters["categories"]!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func applyFilter() {
        delegate?.filterView(self, didChangeFilters: selectedCategories)
        
        navigationController?.popViewControllerAnimated(false)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = settingsTable.dequeueReusableCellWithIdentifier("SwitchCell") as SwitchCell
        let category = categories[indexPath.row] as NSDictionary
        
        cell.setOn(selectedCategories.containsObject(category))
        cell.delegate = self
        cell.name.text = category["label"] as? String
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Categories"
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }

    
    func switchCell(switchCell: SwitchCell, didChangeValue value: Bool) {
        var indexPath = settingsTable.indexPathForCell(switchCell) as NSIndexPath!
        
        if(value) {
            selectedCategories.addObject(categories[indexPath.row])
        } else {
            selectedCategories.removeObject(categories[indexPath.row])
        }
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
