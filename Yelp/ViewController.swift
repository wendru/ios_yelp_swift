//
//  ViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 9/19/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, FilterViewDelegate {
    var client:     YelpClient!
    var businesses = NSArray()
    var searchBar = UISearchBar()
    var searchKeyword = "Sushi"
    var HUD = JGProgressHUD(style: JGProgressHUDStyle.Dark)
    var fvc = FilterView()
    var filters = NSMutableDictionary()
    
    @IBOutlet weak var table: UITableView!
    
    // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
    let yelpConsumerKey = "vxKwwcR_NMQ7WaEiQBK_CA"
    let yelpConsumerSecret = "33QCvh5bIF5jIHR5klQr7RtBDhQ"
    let yelpToken = "uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV"
    let yelpTokenSecret = "mqtKIxMIR4iBtBPZCmCLEb-Dz3Y"
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setUp()
        loadData()
    }
    
    func setUp() {
        table.delegate = self
        table.dataSource = self
        table.rowHeight = UITableViewAutomaticDimension
        table.estimatedRowHeight = 90
        table.separatorInset = UIEdgeInsetsZero
        table.layoutMargins = UIEdgeInsetsZero
        
        navigationItem.titleView = searchBar
        searchBar.delegate = self
        
        fvc.delegate = self
    }
    
    func loadData() {
        HUD.showInView(self.view)
        
        client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        
        client.searchWithTerm(filters, term: searchKeyword, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
//            println(response)
            var businessDictionaries = response["businesses"] as NSArray
            self.businesses = Business.businessesWithDictionaries(businessDictionaries)
            self.table.reloadData()
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error)
        }
        
        HUD.dismissAfterDelay(0.5, animated: true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businesses.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell") as BusinessCell
        cell.populateFields(businesses[indexPath.row] as Business)
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero

        return cell
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        searchKeyword = searchText
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
        loadData()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func filterView(filterView: FilterView, didChangeFilters filters: NSMutableSet) {
        var categories = NSMutableArray()
        for filter in filters {
            categories.addObject(filter["value"] as String)
        }
        
        self.filters["category_filter"] = categories.componentsJoinedByString(",")
        loadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var vc = segue.destinationViewController as FilterView
        vc.delegate = self
        
        super.prepareForSegue(segue, sender: sender)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

