//
//  CategoryData.swift
//  Box8Home(Sample)
//
//  Created by mac on 06/10/18.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation

class CategoryData {
    
    var id: Int?
    var name: String?
    var products: [CategoryProduct]?

    init(id: Int?,name: String?,products:  [CategoryProduct]?){
        self.id = id
        self.name = name
        self.products = products
    }
}
class CategoryProduct{
    var id: Int?
    var name: String?
    
    init(id: Int?,name: String?){
        self.id = id
        self.name = name
    }
}

