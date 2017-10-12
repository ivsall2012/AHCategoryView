# AHCategoryView
AHCategoryView acts like a flexible UITabBarController, but upside down, for categorizing different pages of controllers in your app.

The following demo gif is a Pinterest style category navigation bar.
![](https://github.com/ivsall2012/AHCategoryView/blob/master/Pinterst_style.gif)

The following demo gif shows that the AHCategoryView's navBar is embedded into a native UINavigatonBar.
![](https://github.com/ivsall2012/AHCategoryView/blob/master/fixed_embedded.gif) | 

## usage
There are only 5 steps to use it:
1. Adding AHCategoryItem(s) into an array. Each AHCategoryItem describes how a category tab looks like.
2. Adding VCs into an array.
3. Configuring AHCategoryView's naBar barStyle.
4. Create a AHCategoryView instance with the item array and VC array then add it into a view. 
5. Optionally, when there's a related remote notification coming into your app for a specific category, you can use categoryView.setBadge to set badge number. See the second example code in the followings.

You will be spending most of the time creating those AHCategoryItem(s) and configuring a AHCategoryNavBarStyle.
AHCategoryNavBarStyle is pretty self-explanatory. Read the comments in the source file if you get confused, or just try it out.

### Example Code: Pinterest Style
```Swift
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
        ///NOTE: You can have more items than VCs. In this case the searchItem is extra, so you won't be able to scroll VCs to the searchItem and you can only tap to it.
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
        style.isScrollable = true
        style.layoutAlignment = .left
        /// The view here is referred to categoryView. So if isEmbeddedToView is true, it means the navBar(categoryView's) is attached with categoryView as a whole, instead of being used separately which is the case in the following example code.
        style.isEmbeddedToView = true
        style.showBottomSeparator = true
        style.showIndicator = false
        /// NOTE: The following two colors have to be created in RBG form in order to do a color transition when scrolling VCs.
        style.normalColor = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1.0)
        style.selectedColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).withAlphaComponent(0.7)
        style.showBgMaskView = true
        style.bgMaskViewColor = UIColor.lightGray
        
//######### 4. Adding categoryView to view
        let frame = CGRect(x: 0, y: 64.0, width: ScreenSize.width, height: ScreenSize.height - 64.0)
        let categoryView = AHCategoryView(frame: frame, categories: items, childVCs: childVCs, parentVC: self, barStyle: style)
        categoryView.interControllerSpacing = 0.0
        self.view.addSubview(categoryView)
        self.categoryView = categoryView
```

### Example Code: Embed AHCategoryView's navBar into a navigationItem.titleView

```Swift
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
        style.isScrollable = false
        style.layoutAlignment = .left
        
        ///NOTE: If you want to embed categoryView.navBar into a navigationItem.titleView or some other view, you have to set style.isEmbeddedToView = false.
        /// The view here is referred to categoryView.
        style.isEmbeddedToView = false
        style.showBottomSeparator = false
        style.indicatorColor = UIColor(red: 244.0/255.0, green: 173.0/255.0, blue: 98.0/255.0, alpha: 1.0)
        style.normalColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        style.selectedColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1.0)
        
        //######### 4. Attaching categoryView to navigationItem.titleView
        let frame = CGRect(x: 0, y: 64.0, width: ScreenSize.width, height: ScreenSize.height - 64.0)
        let categoryView = AHCategoryView(frame: frame, categories: items, childVCs: childVCs, parentVC: self, barStyle: style)
        self.view.addSubview(categoryView)
        self.categoryView = categoryView
        categoryView.navBar.frame = CGRect(x: 0, y: 0, width: 359.0, height: 44.0)
        categoryView.navBar.backgroundColor = UIColor.clear
        categoryView.select(at: 1)
        categoryView.setBadge(atIndex: 0, badgeNumber: 10)
        categoryView.setBadge(atIndex: 2, badgeNumber: 3)
        /// Embed navBar to navigationItem.titleView
        self.navigationItem.titleView = categoryView.navBar
        self.navigationController?.navigationBar.barTintColor = UIColor.white
```

## Example


To run the example project, clone the repo, and run `pod install` from the Example directory first.



## Requirements
iOS 8.0+
## Installation

AHCategoryView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "AHCategoryView"
```

## Author

Anyd Tong, ivsall2012@gmail.com

## License

AHCategoryView is available under the MIT license. See the LICENSE file for more info.
