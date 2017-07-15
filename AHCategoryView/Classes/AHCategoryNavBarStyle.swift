//
//  AHCategoryNavBarStyle.swift
//  AHCategoryVC
//
//  Created by Andy Tong on 5/31/17.
//  Copyright © 2017 Andy Tong. All rights reserved.
//

import UIKit

public struct AHCategoryNavBarStyle {
    public var height: CGFloat = 44.0
    
    /// if set to true, all items will have equal spacing.
    public var isScrollabel = false
    public var fontSize: CGFloat = 15.0
    public var selectedFontSize: CGFloat = 17.0
    public var showTransitionAnimation = true
    public var showBarSelectionAnimation = true
    public var defaultCategoryIndex: Int = 0
    /// use RGB channels!!!
    public var normalColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
    /// use RGB channels!!!
    public var selectedColor = UIColor(red: 244.0/255.0, green: 173.0/255.0, blue: 98.0/255.0, alpha: 1.0)
    
    /// works only when isScrollabel is true
    public var interItemSpace: CGFloat = 20.0
    
    public var showIndicator = true
    public var indicatorHeight:CGFloat = 2.0
    public var indicatorColor:UIColor = UIColor(red: 244.0/255.0, green: 173.0/255.0, blue: 98.0/255.0, alpha: 1.0)
    
    public var showbgMasView = false
    /// use RGB channels!!!
    public var bgMaskColor: UIColor = UIColor(red: 85.0/255.0, green: 85.0/255.0, blue: 85.0/255.0, alpha: 1.0)
    /// Position the navBar on top or bottom
    public var positionOnTop = true
    
    public init() {}
    
}


public struct AHCategoryItem {
    public var title: String?
    public var normalImage: UIImage?
    public var selectedImage: UIImage?
    public init() {}
}











