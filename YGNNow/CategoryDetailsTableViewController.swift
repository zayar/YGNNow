//
//  CategoryDetailsTableViewController.swift
//  YGNNow
//
//  Created by zayar min on 12/11/16.
//  Copyright © 2016 zayarmin. All rights reserved.
//

import UIKit
import Firebase

class CategoryDetailsTableViewController: UITableViewController {

    var ref = FIRDatabaseReference.init()
    var categoryDetailArray = [CategoryDetails]()
    var categoryReference: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.2)
        tableView.separatorColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.8)
        navigationController?.hidesBarsOnSwipe = true
        title = "Street"
        ref = FIRDatabase.database().reference()
        
        ref.child("Stores").queryOrdered(byChild: "Category").queryEqual(toValue: categoryReference).observe(.childAdded, with: { (snapshot) in
     // ref.child("Stores").queryEqual(toValue: "Events", childKey: "Category").observe(.childAdded, with: { (snapshot) in
            var categoryItemName : String?
            var categoryItemImage : String?
            var categoryItemAddress : String?
            var categoryItemType : String?
            
            categoryItemName = (snapshot.value as? NSDictionary)? ["Name"] as? String
            categoryItemImage = (snapshot.value as? NSDictionary)? ["CellImage"] as? String
            categoryItemAddress = (snapshot.value as? NSDictionary)? ["Address"] as? String
            categoryItemType = (snapshot.value as? NSDictionary)? ["Type"] as? String
            
            let categoryModel = CategoryDetails(categoryItemName: categoryItemName, categoryItemImage: categoryItemImage,categoryItemAddress:categoryItemAddress,categoryItemType: categoryItemType)
            
            self.categoryDetailArray.append(categoryModel)
            self.tableView.reloadData()
        })
  
    }
    
    var parallaxOffSetSpeed: CGFloat = 30
    var cellHeight: CGFloat = 250
    
    var parallaxImageHeight: CGFloat {
        let maxOffset = (sqrt(pow(cellHeight, 2) + 4 * parallaxOffSetSpeed * self.tableView.frame.height) - cellHeight) / 2
        
        return maxOffset + self.cellHeight
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
        return categoryDetailArray.count
    }
    
   /* override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return cellHeight
    }*/
    
  

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "categoryDetailsCell") as! CategoryDetailsViewCell!
       // var cell = tableView.dequeueReusableCell(withIdentifier: "categoryDetailsCell", for: indexPath) as! CategoryDetailsViewCell

        if(cell == nil) {cell = CategoryDetailsViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")}
        cell?.categoryDetalNameLabel.text = categoryDetailArray[(indexPath as NSIndexPath).row].categoryItemName
        cell?.categoryDetailAddressLabel.text = categoryDetailArray[(indexPath as NSIndexPath).row].categoryItemAddress
           cell?.cagegoryDetailType.text = categoryDetailArray[(indexPath as NSIndexPath).row].categoryItemType
        
        if let sendUrl = categoryDetailArray[(indexPath as NSIndexPath).row].categoryItemImage{
            if(sendUrl != ""){
                cell?.categoryDetailsImage.loadUsingCache(sendUrl)
                cell?.parallaxImageHeight.constant = self.parallaxImageHeight
                cell?.parallaxImageTop.constant = parallaxOffset(newOffsetY: tableView.contentOffset.y, cell: cell!)
                
            }else{cell?.categoryDetailsImage.image = UIImage(named:"noImages")}
        }else{
            cell?.categoryDetailsImage.image = UIImage(named: "noImages")
        }

        return cell!
    }
    
    func parallaxOffset(newOffsetY:CGFloat, cell:UITableViewCell) -> CGFloat{
        return (newOffsetY - cell.frame.origin.y) / parallaxImageHeight * parallaxOffSetSpeed
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = tableView.contentOffset.y
        for cell in tableView.visibleCells as! [CategoryDetailsViewCell]{
            cell.parallaxImageTop.constant = parallaxOffset(newOffsetY: offsetY, cell: cell)
            
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
