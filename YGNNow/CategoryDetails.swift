//
//  CategoryDetails.swift
//  YGNNow
//
//  Created by zayar min on 12/11/16.
//  Copyright © 2016 zayarmin. All rights reserved.
//

import Foundation
import UIKit

class CategoryDetails {
    
    var categoryItemName : String?
    var categoryItemImage : String?
    var categoryItemAddress : String?
    var categoryItemType : String?
    
    init(categoryItemName: String?, categoryItemImage: String?, categoryItemAddress: String?, categoryItemType: String?)
    {
        self.categoryItemName = categoryItemName
        self.categoryItemImage = categoryItemImage
        self.categoryItemAddress = categoryItemAddress
        self.categoryItemType = categoryItemType
    }
}
