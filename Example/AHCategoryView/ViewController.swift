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
//        embeddedIntoTheNavigationBar()
        pinterest()
    }

    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }

}


//MARK:- Pinterest NavBar Style
extension ViewController {
    func pinterest() {
        ///######## 1. Adding items
        var featureItem = AHCategoryItem()
        featureItem.title = "Feature"
        var chartItem = AHCategoryItem()
        chartItem.title = "Categories"
        var radioItem = AHCategoryItem()
        radioItem.title = "Radio"
        var liveItem = AHCategoryItem()
        liveItem.title = "Live"
        var searchItem = AHCategoryItem()
        searchItem.normalImage = UIImage(named: "search-magnifier")
        searchItem.selectedImage = UIImage(named: "search-magnifier")
        
        let items = [featureItem, chartItem, radioItem, liveItem, featureItem, chartItem, radioItem, liveItem, searchItem]
        
        ///######## 2. Adding VCs
        for _ in 0..<8 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.random()
            childVCs.append(vc)
        }
        
        ///######## 3. Configuring barStyle
        var style = AHCategoryNavBarStyle()
//        style.contentInset.left = 100.0
//        style.contentInset.right = 100.0
        style.height = 44.0
        style.fontSize = 20.0
        style.selectedFontSize = 22.0
        style.interItemSpace = 5.0
        style.itemPadding = 8.0
        style.isScrollabel = true
        style.layoutAlignment = .left
        style.isEmbeddedToView = true
        style.showBottomSeparator = true
        style.showIndicator = false
        style.normalColor = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1.0)
        style.selectedColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).withAlphaComponent(0.7)
        style.showBgMaskView = true
        style.bgMaskViewColor = UIColor.lightGray
        
        
        //######### 4. Setting up categoryView
        let frame = CGRect(x: 0, y: 64.0, width: ScreenSize.width, height: ScreenSize.height - 64.0)
        let categoryView = AHCategoryView(frame: frame, categories: items, childVCs: childVCs, parentVC: self, barStyle: style)
        categoryView.interControllerSpacing = 0.0
        self.view.addSubview(categoryView)
        self.categoryView = categoryView
    }
}


//MARK: - Embeded the navBar into a UINavigationBar
extension ViewController {
    func embeddedIntoTheNavigationBar() {
        // adding a separate button to the right of the navBar, for fun.
        let searchBtn = UIButton(type: .custom)
        let searchImg = UIImage(named: "search-magnifier")
        searchBtn.setImage(searchImg, for: .normal)
        searchBtn.sizeToFit()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBtn)
        
        ///######## 1. Adding items
        var meItem = AHCategoryItem()
        meItem.normalImage = UIImage(named: "me-normal")
        meItem.selectedImage = UIImage(named: "me-selected")
        
        
        var featureItem = AHCategoryItem()
        featureItem.title = "Feature"
        var chartItem = AHCategoryItem()
        chartItem.title = "Charts"
        var categoryItem = AHCategoryItem()
        categoryItem.title = "Categories"
        var radioItem = AHCategoryItem()
        radioItem.title = "Radio"
        var liveItem = AHCategoryItem()
        liveItem.title = "Live"
        
        
        let items = [meItem, featureItem, chartItem, categoryItem, radioItem, liveItem]
        
        ///######## 2. Adding VCs
        for _ in 0..<5 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.random()
            childVCs.append(vc)
        }
        
        
        ///######## 3. Configuring barStyle
        
        var style = AHCategoryNavBarStyle()
//        style.contentInset = .zero
        style.interItemSpace = 8.0
        style.itemPadding = 8.0
        style.isScrollabel = false
        style.layoutAlignment = .left
        style.isEmbeddedToView = false
        style.showBottomSeparator = false
        style.indicatorColor = UIColor(red: 244.0/255.0, green: 173.0/255.0, blue: 98.0/255.0, alpha: 1.0)
        style.normalColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        style.selectedColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1.0)
        
        //######### 4. Setting up categoryView
        let frame = CGRect(x: 0, y: 64.0, width: ScreenSize.width, height: ScreenSize.height - 64.0)
        let categoryView = AHCategoryView(frame: frame, categories: items, childVCs: childVCs, parentVC: self, barStyle: style)
        self.view.addSubview(categoryView)
        self.categoryView = categoryView
        categoryView.navBar.frame = CGRect(x: 0, y: 0, width: 359.0, height: 44.0)
        categoryView.navBar.backgroundColor = UIColor.clear
        categoryView.select(at: 1)
        categoryView.setBadge(atIndex: 0, badgeNumber: 10)
        categoryView.setBadge(atIndex: 2, badgeNumber: 3)
        self.navigationItem.titleView = categoryView.navBar
        self.navigationController?.navigationBar.barTintColor = UIColor.white
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
