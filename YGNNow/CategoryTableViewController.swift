//
//  RestaurantTableViewController.swift
//  YGNNow
//
//  Created by zayar min on 12/11/16.
//  Copyright © 2016 zayarmin. All rights reserved.
//

import UIKit
import Firebase

class CategoryTableViewController: UITableViewController {

    var ref = FIRDatabaseReference.init()
    var categoryArray = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.hidesBarsOnSwipe = true
        
        ref = FIRDatabase.database().reference()
        //ref.child("Categories").queryOrdered(byChild: "Category").observe(.childAdded, with: { (snapshot) in
             ref.child("Categories").queryOrdered(byChild: "Id").observe(.childAdded, with: { (snapshot) in
            var categoryName : String?
            var categoryImage : String?
            
            categoryName = (snapshot.value as? NSDictionary)? ["Name"] as? String
            categoryImage = (snapshot.value as? NSDictionary)? ["Image"] as? String
            
            let modelInstance = Category(categoryName: categoryName, categoryImage: categoryImage)
            self.categoryArray.append(modelInstance)
            self.tableView.reloadData()
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categoryArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CategoryTableViewCell!
        
        if(cell == nil) {cell = CategoryTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")}
        cell?.categoryLabel.text = categoryArray[(indexPath as NSIndexPath).row].categoryName
        if let sendUrl = categoryArray[(indexPath as NSIndexPath).row].categoryImage{
            if(sendUrl != ""){cell?.categoryImageView.loadUsingCache(sendUrl)}else{cell?.categoryImageView.image = UIImage(named:"noImages")}
        }else{
            cell?.categoryImageView.image = UIImage(named: "noImages")
        }
        
        return cell!

    
    }
    //showCategoryDetails



    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showCategoryDetails"){
            let destinationController = segue.destination as! CategoryDetailsTableViewController
            if let indexPath = self.tableView.indexPathForSelectedRow{
                destinationController.categoryReference = categoryArray[(indexPath as NSIndexPath).row].categoryName
            }
        }
    }
    

}
