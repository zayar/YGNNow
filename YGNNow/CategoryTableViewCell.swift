//
//  CategoryTableViewCell.swift
//  YGNNow
//
//  Created by zayar min on 11/11/16.
//  Copyright © 2016 zayarmin. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet var categoryLabel : UILabel!
    @IBOutlet var categoryImageView : UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
