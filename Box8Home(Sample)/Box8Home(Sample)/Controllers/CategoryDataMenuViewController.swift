//
//  CategoryDataMenuViewController.swift
//  Box8Home(Sample)
//
//  Created by mac on 06/10/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import Parchment
class CategoryDataMenuViewController: UIViewController,PagingViewControllerDataSource {
    
    
    var categoryData:[CategoryData]?
    var selectedIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        let pagingViewController = PagingViewController<PagingIndexItem>()
        pagingViewController.dataSource = self
        addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
        pagingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pagingViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pagingViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pagingViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pagingViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
            ])

        pagingViewController.select(index: selectedIndex, animated: true)

        // Do any additional setup after loading the view.
    }
    func numberOfViewControllers<T>(in pagingViewController: PagingViewController<T>) -> Int where T : PagingItem, T : Comparable, T : Hashable {
        return categoryData?.count ?? 0
    }
    
    func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, viewControllerForIndex index: Int) -> UIViewController where T : PagingItem, T : Comparable, T : Hashable {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let VC = storyboard.instantiateViewController(withIdentifier: "ProductTableView") as! ProductTableViewController
        VC.productData = categoryData![index]
        return VC
        
    }
    
    func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, pagingItemForIndex index: Int) -> T where T : PagingItem, T : Comparable, T : Hashable {
        let products = categoryData
        return PagingIndexItem(index: index, title: products![index].name!) as! T
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
