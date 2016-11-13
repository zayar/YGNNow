//
//  CategoryDetailsViewCell.swift
//  YGNNow
//
//  Created by zayar min on 12/11/16.
//  Copyright © 2016 zayarmin. All rights reserved.
//

import UIKit

class CategoryDetailsViewCell: UITableViewCell {

    @IBOutlet var categoryDetalNameLabel : UILabel!
    @IBOutlet var categoryDetailAddressLabel : UILabel!
    @IBOutlet var cagegoryDetailType : UILabel!
    @IBOutlet var categoryDetailsImage : UIImageView!
    
    @IBOutlet weak var parallaxImageHeight: NSLayoutConstraint!
  
    @IBOutlet weak var parallaxImageTop: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryDetailsImage.clipsToBounds = true
  
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
