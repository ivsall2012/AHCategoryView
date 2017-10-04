//
//  ViewController.swift
//  AHCategoryView
//
//  Created by ivsall2012 on 07/14/2017.
//  Copyright (c) 2017 ivsall2012. All rights reserved.
//

import UIKit
import AHCategoryView

private let ScreenSize = UIScreen.main.bounds.size

class ViewController: UIViewController {
    let categoryTitles = ["Featured", "Charts","Charts","Charts","Charts"]
    fileprivate weak var categoryView: AHCategoryView!
    var childVCs = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let searchBtn = UIButton(type: .custom)
        let searchImg = UIImage(named: "search-magnifier")
        searchBtn.setImage(searchImg, for: .normal)
        searchBtn.sizeToFit()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBtn)
        
        
        var meItem = AHCategoryItem()
        meItem.normalImage = UIImage(named: "me-normal")
        meItem.selectedImage = UIImage(named: "me-selected")
        
        
        var featureItem = AHCategoryItem()
        featureItem.title = "Feature"
        var chartItem = AHCategoryItem()
        chartItem.title = "Categories"
        var radioItem = AHCategoryItem()
        radioItem.title = "Radio"
        var liveItem = AHCategoryItem()
        liveItem.title = "Live"
        
        
        let items = [meItem, featureItem, chartItem, radioItem, liveItem]
        
        
        for _ in 0..<5 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.red
            childVCs.append(vc)
        }
        
        let frame = CGRect(x: 0, y: 64.0, width: ScreenSize.width, height: ScreenSize.height - 64.0)
        var style = AHCategoryNavBarStyle()
        //        style.offsetX = -16.0
        style.interItemSpace = 5.0
        style.itemPadding = 8.0
        style.isScrollabel = false
        style.layoutAlignment = .left
        style.isEmbedded = false
        style.showBottomSeparator = false
        style.indicatorColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1.0)
        style.normalColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        style.selectedColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1.0)
        self.view.backgroundColor = UIColor.white
        
        let categoryView = AHCategoryView(frame: frame, categories: items, childVCs: childVCs, parentVC: self, barStyle: style)
        self.view.addSubview(categoryView)
        self.categoryView = categoryView
        categoryView.navBar.frame = CGRect(x: 0, y: 0, width: 359.0, height: 44.0)
        categoryView.select(at: 1)
        self.navigationItem.titleView = categoryView.navBar
        self.navigationController?.navigationBar.barTintColor = UIColor.white
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        // test set categoryItem
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
//            var meItem = AHCategoryItem()
//            meItem.normalImage = UIImage(named: "me-normal")
//            meItem.selectedImage = UIImage(named: "me-msg")
//            self.categoryView.set(item: meItem, at: 0)
//            print("set meItem")
//        }
        
        
//        // test select categoryItem
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
//            self.categoryView.select(at: 3)
//        }

    }

}
extension UIColor {
    class func random() -> UIColor {
        let red = CGFloat(arc4random_uniform(256)) / 255.0
        let green = CGFloat(arc4random_uniform(256)) / 255.0
        let blue = CGFloat(arc4random_uniform(256)) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
