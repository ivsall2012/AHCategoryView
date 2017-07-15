//
//  AHCategoryNavBar.swift
//  AHCategoryVC
//
//  Created by Andy Tong on 5/29/17.
//  Copyright © 2017 Andy Tong. All rights reserved.
//

import UIKit

private let edgeMargin:CGFloat = 6.0

open class AHCategoryNavBar: UIView {
    public weak var delegate: AHCategoryNavBarDelegate?
    
    fileprivate var barStyle: AHCategoryNavBarStyle
    
    fileprivate var categories: [AHCategoryItem]
    
    fileprivate lazy var buttons = [UIButton]()
    
    fileprivate lazy var scrollView: UIScrollView = UIScrollView(frame: self.bounds)
    
    fileprivate var currentButtonTag: Int = 0
    
    fileprivate lazy var buttonHeight: CGFloat = self.bounds.height
    
    fileprivate lazy var buttonFont: UIFont = UIFont.systemFont(ofSize: self.barStyle.fontSize)
    
    fileprivate lazy var indicator: UIView = {
        let view = UIView()
        view.frame.size.height = self.barStyle.indicatorHeight
        view.frame.origin.y = self.bounds.height - self.barStyle.indicatorHeight
        view.backgroundColor = self.barStyle.indicatorColor
        self.scrollView.addSubview(view)
        return view
    }()
    
    
    fileprivate lazy var bgMaskView: UIView = {
        let maskView = UIView()
        maskView.backgroundColor = UIColor.darkGray
        maskView.frame.size.height = self.bounds.height
        maskView.layer.masksToBounds = true
        maskView.layer.cornerRadius = (self.barStyle.fontSize + edgeMargin) * 0.5
        self.scrollView.insertSubview(maskView, at: 0)
        return maskView
    }()
    
    
    public init(frame: CGRect, categories: [AHCategoryItem], barStyle: AHCategoryNavBarStyle) {
        self.categories = categories
        self.barStyle = barStyle
    
        super.init(frame: frame)
        setupUI()
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK:- Setups
private extension AHCategoryNavBar {
    func setupUI() {
        setupScrollView()
        addButtons()
        setupIndicator()
        setupBgMaskView()

    }
    
    func setupScrollView(){
        scrollView.showsHorizontalScrollIndicator = false
        if !barStyle.isScrollabel {
            scrollView.isScrollEnabled = false
        }
        addSubview(scrollView)
    }
    
    
    func addButtons() {
        for i in 0..<categories.count {
            let btn = UIButton()
            let item = categories[i]
            if let itemTitle = item.title {
                btn.setTitle(itemTitle, for: .normal)
                let titleColor = (i == barStyle.defaultCategoryIndex) ? barStyle.selectedColor : barStyle.normalColor
                btn.setTitleColor(titleColor, for: .normal)
                btn.titleLabel?.textAlignment = .center
                btn.titleLabel?.font = buttonFont
            }
            
            btn.tag = i
            btn.isHighlighted = false
            
            var x: CGFloat = 0.0
            let y: CGFloat = 0.0
            var width: CGFloat = 0.0
            let height = self.buttonHeight
//            let textWidth: CGFloat = getTextWidth(for: label)
            let textWidth: CGFloat = btn.intrinsicContentSize.width
            
            
            if barStyle.isScrollabel {
                // scrollabel, each label has its own width according to its text
                width = textWidth
                if i > 0 {
                    let previousBtn = buttons[i - 1]
                    x = previousBtn.frame.maxX + barStyle.interItemSpace
                }
            }else{
                // not scrollabel, then divide width equally for all labels
                width = self.bounds.width / CGFloat(categories.count)
                
                if i > 0 {
                    x = width * CGFloat(i)
                }
            }
            
            // special adjustment for the default button
            if i == barStyle.defaultCategoryIndex {
                x = barStyle.interItemSpace * 0.5
            }
            
            
            
            btn.frame = CGRect(x: x, y: y, width: width, height: height)
            btn.addTarget(self, action: #selector(titleBtnTapped(_:)), for: .touchUpInside)
            buttons.append(btn)
            
            scrollView.addSubview(btn)

            let contentWidth:CGFloat = buttons.last!.frame.maxX + barStyle.interItemSpace * 0.5
            let contentHeight:CGFloat = self.bounds.height
            scrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
            
        }
    }
    
    func setupIndicator() {
        guard barStyle.showIndicator else {
            return
        }
        let defaultBtn = buttons[0]
        let width: CGFloat = defaultBtn.intrinsicContentSize.width
        indicator.frame.size.width = width
        indicator.center.x = defaultBtn.center.x
    }
    
    func setupBgMaskView() {
        guard barStyle.showbgMasView else {
            return
        }
        let defaultBtn = buttons[0]
        let width: CGFloat = defaultBtn.intrinsicContentSize.width
        
        bgMaskView.frame.size.width = width + 2 * edgeMargin
        bgMaskView.frame.size.height = barStyle.fontSize + 2 * edgeMargin
        bgMaskView.center.x = defaultBtn.center.x
        bgMaskView.frame.origin.y = (self.bounds.height - bgMaskView.frame.size.height) * 0.5 + 1.0 // the 1.0 is just a little adjustment
    }
    
    
    
    func getTextWidth(for label: UILabel) -> CGFloat {
        
        let font = UIFont.systemFont(ofSize: barStyle.fontSize)
        let height: CGFloat = self.bounds.height // certain
        let boundSize = CGSize(width: CGFloat(Float.greatestFiniteMagnitude), height: height)
        let textWidth = (label.text! as NSString).boundingRect(with: boundSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil).width
        
        return textWidth
    }
    
}


//MARK:- Event Handling
private extension AHCategoryNavBar {
    @objc func titleBtnTapped(_ btn: UIButton) {
        guard btn.tag != currentButtonTag else {
            return
        }
        delegate?.categoryNavBar(self, willSwitchIndexFrom: currentButtonTag, to: btn.tag)
        
        handleBtnSwitching(currentBtn: btn)
        handleIndicator(currentBtn: btn)
        handleBgMaskView(currentBtn: btn)
        delegate?.categoryNavBar(self, didSwitchIndexTo: btn.tag)
    }
    
    func handleBtnSwitching(currentBtn: UIButton) {
        
        let previousBtn = buttons[currentButtonTag]
        
        previousBtn.setTitleColor(barStyle.normalColor, for: .normal)
        currentBtn.setTitleColor(barStyle.selectedColor, for: .normal)
        currentButtonTag = currentBtn.tag
        
        if barStyle.isScrollabel {
            scrollToCenter(currentBtn: currentBtn)
        }
        
    }
    
    func handleIndicator(currentBtn: UIButton) {
        guard barStyle.showIndicator else {
            return
        }
        
        let width = currentBtn.intrinsicContentSize.width
        if barStyle.showBarSelectionAnimation {
            UIView.animate(withDuration: 0.25) {
                self.indicator.frame.size.width = width
                self.indicator.center.x = currentBtn.center.x
            }
        }else{
            self.indicator.frame.size.width = width
            self.indicator.center.x = currentBtn.center.x
        }
        
    }
    
    func handleBgMaskView(currentBtn: UIButton) {
        guard barStyle.showbgMasView else {
            return
        }
        let width = currentBtn.intrinsicContentSize.width
        if barStyle.showBarSelectionAnimation {
            UIView.animate(withDuration: 0.25) {
                self.bgMaskView.frame.size.width = width + 2 * edgeMargin
                self.bgMaskView.center.x = currentBtn.center.x
            }
        }else{
            self.bgMaskView.frame.size.width = width + 2 * edgeMargin
            self.bgMaskView.center.x = currentBtn.center.x
        }
        
    }
    
    func scrollToCenter(currentBtn: UIButton) {
        guard barStyle.isScrollabel else {
            return
        }
        
        var centerX = currentBtn.center.x - scrollView.bounds.width * 0.5
        if centerX < 0.0 {
            // for labels positioned on the left side of scrollView.bounds.width * 0.5
            centerX = 0.0
            
        }
        
        // the x position for the last screen of the scroll
        let maxLeftEdge = scrollView.contentSize.width - bounds.width
        if centerX > maxLeftEdge{
            centerX = maxLeftEdge
        }
        
        scrollView.setContentOffset(CGPoint(x: centerX, y: 0.0), animated: true)
        
    }
}


extension AHCategoryNavBar: AHCategoryContainerDelegate {
    public func categoryContainer(_ container: UIView, didSwitchIndexTo toIndex: Int) {
        guard toIndex < buttons.count else {
            return
        }

        let currentBtn = buttons[toIndex]
        handleBtnSwitching(currentBtn: currentBtn)
        handleIndicator(currentBtn: currentBtn)
        handleBgMaskView(currentBtn: currentBtn)
    }
    
     public func categoryContainer(_ container: UIView, transitioningFromIndex fromIndex:Int, toIndex:Int, progress: CGFloat) {
        guard barStyle.showTransitionAnimation else {
            return
        }
        guard fromIndex >= 0, fromIndex < buttons.count else {
            return
        }
        guard toIndex >= 0, toIndex < buttons.count else {
            return
        }
        
        makeColorTransition(fromIndex: fromIndex, toIndex: toIndex, progress: progress)
        makeIndicatorTransition(fromIndex: fromIndex, toIndex: toIndex, progress: progress)
        makeBgMaskViewTransition(fromIndex: fromIndex, toIndex: toIndex, progress: progress)
    }
    
    func makeIndicatorTransition(fromIndex: Int, toIndex: Int, progress: CGFloat) {
        guard barStyle.showIndicator else {
            return
        }
        
        let fromBtn = buttons[fromIndex]
        let toBtn = buttons[toIndex]
        
        let fromWidth = fromBtn.intrinsicContentSize.width
        let toWidth = toBtn.intrinsicContentSize.width
        
        let deltaX = (toBtn.center.x - fromBtn.center.x) * progress
        let deltaWidth = toWidth - fromWidth
        
        indicator.center.x = fromBtn.center.x + deltaX
        indicator.frame.size.width = fromWidth + deltaWidth * progress
        
    }
    
    func makeColorTransition(fromIndex: Int, toIndex: Int, progress: CGFloat){
        let fromBtn = buttons[fromIndex]
        let toBtn = buttons[toIndex]
        
        let colorDifferences = UIColor.getRGBDelta(first: barStyle.selectedColor, second: barStyle.normalColor)
        
        let redDiff = colorDifferences.0 * progress
        let greenDiff = colorDifferences.1 * progress
        let blueDiff = colorDifferences.2 * progress
        
        let fromRed = barStyle.selectedColor.getRGBComponents().0 - redDiff
        let fromGreen = barStyle.selectedColor.getRGBComponents().1 - greenDiff
        let fromBlue = barStyle.selectedColor.getRGBComponents().2 - blueDiff
        let fromColor = UIColor(red: fromRed, green: fromGreen, blue: fromBlue, alpha: 1.0)
        
        let toRed = barStyle.normalColor.getRGBComponents().0 + redDiff
        let toGreen = barStyle.normalColor.getRGBComponents().1 + greenDiff
        let toBlue = barStyle.normalColor.getRGBComponents().2 + blueDiff
        let toColor = UIColor(red: toRed, green: toGreen, blue: toBlue, alpha: 1.0)
        
        fromBtn.setTitleColor(fromColor, for: .normal)
        toBtn.setTitleColor(toColor, for: .normal)
    }
    
    func makeBgMaskViewTransition(fromIndex: Int, toIndex: Int, progress: CGFloat) {
        guard barStyle.showbgMasView else {
            return
        }
        let fromBtn = buttons[fromIndex]
        let toBtn = buttons[toIndex]
        let fromWidth = fromBtn.intrinsicContentSize.width
        let toWidth = toBtn.intrinsicContentSize.width
        
        let deltaWidth = (toWidth - fromWidth) * progress
        let deltaX = (toBtn.center.x - fromBtn.center.x) * progress

        let width = fromWidth + deltaWidth + 2 * edgeMargin
        let x = fromBtn.center.x + deltaX
       
        self.bgMaskView.frame.size.width = width
        self.bgMaskView.center.x = x
        
    }
}







