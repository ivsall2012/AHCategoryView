//
//  ViewController.swift
//  AHCategoryView
//
//  Created by ivsall2012 on 07/14/2017.
//  Copyright (c) 2017 ivsall2012. All rights reserved.
//

import UIKit
import AHCategoryView
class ViewController: UIViewController {
    let categoryTitles = ["Featured", "Charts"]
    var categoryView: AHCategoryView!
    override func viewDidLoad() {
        super.viewDidLoad()
        var childVCs = [UIViewController]()
        // the extra 1 is for the first meItem
        for _ in 0..<(categoryTitles.count) {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.random()
            childVCs.append(vc)
        }
        
        var style = AHCategoryNavBarStyle()
        style.isScrollabel = false
        style.showIndicator = true
        style.normalColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        style.selectedColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        style.showBgMaskView = false
        
        // test custom maskView
//        let customeMask = UIView()
//        customeMask.backgroundColor = UIColor.yellow
//        style.bgMaskView = customeMask
        
        
        style.showTransitionAnimation = true
        let frame = CGRect(x: 0, y: 64, width: view.bounds.width, height: view.bounds.height - 64)
        
        
        var categoryItems = [AHCategoryItem]()
        var meItem = AHCategoryItem()
        meItem.normalImage = UIImage(named: "me-normal")
        meItem.selectedImage = UIImage(named: "me-selected")
//        categoryItems.append(meItem)
        categoryTitles.forEach { (titel) in
            var item = AHCategoryItem()
            item.title = titel
            categoryItems.append(item)
        }
        categoryView = AHCategoryView(frame: frame, categories: categoryItems, childVCs: childVCs, parentVC: self, barStyle: style)
        
        view.addSubview(categoryView)
        
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
