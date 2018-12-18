//
//  HomeViewController.swift
//  Box8Home(Sample)
//
//  Created by tibin thomas on 05/10/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,ContentDynamicLayoutDelegate {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var sideMenuButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    var categoryData:[CategoryData]?
    var contentFlowLayout: ContentDynamicLayout = FlickrStyleFlowLayout()
    var i = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDataModel()
        collectionView.delegate = self
        collectionView.dataSource = self
        contentFlowLayout.delegate = self
        self.navigationController?.isNavigationBarHidden = true
        contentFlowLayout.contentPadding = ItemsPadding(horizontal: 10, vertical: 10)
        contentFlowLayout.cellsPadding = ItemsPadding(horizontal: 8, vertical: 8)
        contentFlowLayout.contentAlign = .left
        collectionView.collectionViewLayout = contentFlowLayout
        collectionView.reloadData()
        sideMenuButton.imageView?.tintColor = .white
        //no longer used
//        if let layout = collectionView?.collectionViewLayout as? BoxCollectionViewLayout {
//            layout.delegate = self
//        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.isNavigationBarHidden = true
    }
    func initDataModel(){
        categoryData = []
        categoryData?.append(CategoryData(id: 0, name: "Fusion Box", products: [CategoryProduct(id: 0, name: "Dal Makhni Rice Box"),
                                                                                CategoryProduct(id: 1, name: "Chole Chawal Box"),
                                                                                CategoryProduct(id: 2, name: "Rajma Chawal Box"),
                                                                                CategoryProduct(id: 3, name: "Grilled Tikki Box"),
                                                                                CategoryProduct(id: 4, name: "Paneer Masala Box")
            ]))
        categoryData?.append(CategoryData(id: 1, name: "Curries", products: [CategoryProduct(id: 0, name: " Basmati Rice"),
                                                                             CategoryProduct(id: 1, name: "Tawa Paratha"),
                                                                             CategoryProduct(id: 2, name: "Kadhai Paneer"),
                                                                             CategoryProduct(id: 3, name: "Raita"),
                                                                             CategoryProduct(id: 4, name: "Butter Chicken")
            ]))
        categoryData?.append(CategoryData(id: 2, name: "Biryani", products: [CategoryProduct(id: 0, name: "Sahi Panner Biryani"),
                                                                             CategoryProduct(id: 1, name: "Firangi Subz Biryani"),
                                                                             CategoryProduct(id: 2, name: "Chicken Tikka Biryani"),
                                                                             CategoryProduct(id: 3, name: "Murg Dum Biryani")
            
            ]))
        categoryData?.append(CategoryData(id: 3, name: "Wraps", products: [CategoryProduct(id: 0, name: "Paneer Wrap"),
                                                                           CategoryProduct(id: 1, name: "Chicken Wrap"),
                                                                           CategoryProduct(id: 2, name: " Mayo Wrap"),
                                                                           CategoryProduct(id: 3, name: "Tikki Wrap"),
                                                                           CategoryProduct(id: 4, name: "Patty Wrap")
            ]))
        categoryData?.append(CategoryData(id: 4, name: "Ice Cream", products: [CategoryProduct(id: 0, name: "Tender CocoNut"),
                                                                               CategoryProduct(id: 1, name: "Sheer Khurma")
            
            ]))
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    //to determine size of collection view cells
    //not used
    func cellSize(indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: collectionView.frame.width , height:  collectionView.frame.width)
        }
        else {
            if indexPath.row  == 0{
                i = 0
            }
            if (i == 1 || i % 3 == 0){
                i = i + 1
                return CGSize(width: collectionView.frame.width - 10, height: collectionView.frame.width/2 - 10)
            }
            else{
                i = i + 1
                return CGSize(width: collectionView.frame.width/2 - 10, height: collectionView.frame.width/2 - 10)
            }
        }
    }
}
extension HomeViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else{
            return categoryData?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //first section is used as header
        if indexPath.section == 0 {
            let headerView = collectionView.dequeueReusableCell(withReuseIdentifier: "homeViewHeaderCell", for: indexPath) as! HomeViewHeaderCollectionViewCell
            headerView.scrollView.auk.removeAll()
            headerView.scrollView.auk.show(url: "https://via.placeholder.com/480x450")
            headerView.scrollView.auk.show(url: "https://via.placeholder.com/480x150")
            headerView.scrollView.auk.show(url: "https://via.placeholder.com/420x120")
            headerView.scrollView.auk.startAutoScroll(delaySeconds: 2)
            return headerView
        }
            //second section is used for category data
        else{
            let homeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeViewCell", for: indexPath) as! HomeViewCollectionViewCell
            homeCell.imageView.moa.url = "https://via.placeholder.com/38\(indexPath.row)x150"
            homeCell.nameLabel.text = categoryData?[indexPath.row].name ?? ""
            return homeCell
        }
    }
    //no longer used
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,withReuseIdentifier: "homeHeaderCell", for: indexPath) as! HomeViewHeaderCollectionReusableView
            headerView.scrollView.auk.removeAll()
            headerView.scrollView.auk.show(url: "https://bit.ly/auk_image")
            headerView.scrollView.auk.show(url: "https://via.placeholder.com/380x150")
            headerView.scrollView.auk.startAutoScroll(delaySeconds: 2)
            return headerView
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
}
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let VC = storyboard.instantiateViewController(withIdentifier: "categoryDataMenu") as! CategoryDataMenuViewController
            VC.categoryData = self.categoryData
            VC.selectedIndex = indexPath.row
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
}
    //no longer used
//extension HomeViewController: UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        switch indexPath.section {
//
//        default:
//            if indexPath.row  == 0{
//                i = 0
//            }
//            if (i == 2){
//                i = 0
//                return CGSize(width: collectionView.frame.width - 10, height: collectionView.frame.width/2 - 10)
//            }
//            else{
//                i = i + 1
//                return CGSize(width: collectionView.frame.width/2 - 10, height: collectionView.frame.width/2 - 10)
//            }
//        }
//
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 5,left: 5,bottom: 5,right: 5)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: collectionView.frame.width - 10, height: 160)
//    }
//
//
//}

    //no longer used
    //to determine size of cells
//extension HomeViewController: BoxLayoutDelegate {
//    func collectionView(_ collectionView: UICollectionView,
//                        heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
//        if indexPath.row  == 0{
//            i = 0
//        }
//        if (i == 1 || i % 3 == 0){
//            i = i + 1
//            return  (collectionView.frame.width/2 - 10) * 2 + 10
//        }
//        else{
//            i = i + 1
//            return collectionView.frame.width/2 - 10
//
//        }
//    }
//}
