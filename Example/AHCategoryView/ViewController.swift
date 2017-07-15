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
    let categories = ["Me","Featured", "Charts", "Live", "Radio"]
    override func viewDidLoad() {
        super.viewDidLoad()
        var childVCs = [UIViewController]()
        for _ in 0..<categories.count {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.random()
            childVCs.append(vc)
        }
        
        var style = AHCategoryNavBarStyle()
        style.isScrollabel = false
        style.showIndicator = true
        style.normalColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        style.selectedColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        style.showbgMasView = true
        style.showTransitionAnimation = true
        let frame = CGRect(x: 0, y: 64, width: view.bounds.width, height: view.bounds.height - 64)
        let categoryView = AHCategoryView(frame: frame, categories: categories, childVCs: childVCs, parentVC: self, barStyle: style)
        
        view.addSubview(categoryView)
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
