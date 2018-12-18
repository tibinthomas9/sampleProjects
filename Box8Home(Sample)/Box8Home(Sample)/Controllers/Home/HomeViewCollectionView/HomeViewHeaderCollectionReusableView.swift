//
//  HomeViewHeaderCollectionReusableView.swift
//  Box8Home(Sample)
//
//  Created by tibin thomas on 05/10/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class HomeViewHeaderCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var scrollView: UIScrollView!
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        initActions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initActions()
    }
    func initActions(){
        
    }
}
