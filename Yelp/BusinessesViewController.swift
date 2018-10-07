//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate {
    
   
    var searchBar = UISearchBar()
    @IBOutlet weak var tableView: UITableView!
    var businesses: [Business]!
    
    var filteredDict = NSDictionary()
    var filteredData : [Business]!
    var otherBusiness: [Business]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 121
        automaticallyAdjustsScrollViewInsets = false
        self.extendedLayoutIncludesOpaqueBars = true
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        
        Business.searchWithTerm(term: "Thai", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
                self.businesses = businesses
                self.tableView.reloadData()
                if let businesses = businesses {
                    for business in businesses {
                        print(business.name!)
                        print(business.address!)
                    }
                }
            
            }
        )
        
        /* Example of Yelp search with more search options specified
         Business.searchWithTerm(term: "Restaurants", sort: .distance, categories: ["asianfusion", "burgers"]) { (businesses, error) in
                self.businesses = businesses
                 for business in self.businesses {
                     print(business.name!)
                     print(business.address!)
                 }
         }
         */
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            Business.searchWithTerm(term: "Restaurants", completion: { (businesses: [Business]?, error: Error?) -> Void in
                self.businesses = businesses
                self.otherBusiness = businesses
                self.tableView.reloadData()
            })
            searchBar.endEditing(false)
        } else {
            
            searchReload()
            self.tableView.reloadData()
        }
    }
    
    func searchReload(){
        let searchTerm = searchBar.text!
        Business.searchWithTerm(term: searchTerm, completion: { (businesses: [Business]?, error: Error?) -> Void in
            self.businesses = businesses
            self.tableView.reloadData()
            if let businesses = businesses {
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                }
            }
        }
        )
        
        self.businesses = otherBusiness
        self.tableView.reloadData()
    
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if businesses != nil {
            return businesses!.count
        } else{
            return 0
        }
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        cell.business = businesses [indexPath.row]
        
        return cell
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
