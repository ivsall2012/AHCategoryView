//
//  AHStackButton.swift
//  AHStackButtonTest
//
//  Created by Andy Tong on 6/2/17.
//  Copyright © 2017 Andy Tong. All rights reserved.
//

import UIKit

public class AHVerticalButton: UIButton {
    public var isTitleOnTop = false {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    func setup() {
        titleLabel?.textAlignment  = .center
    }

    
    public override func setTitle(_ title: String?, for state: UIControlState) {
        super.setTitle(title, for: state)
        self.setNeedsLayout()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let imageView = self.imageView, let titleLabel = self.titleLabel, let currentImage = self.currentImage else {
            return
        }

        imageView.frame.size.width = currentImage.size.width
        imageView.frame.size.height = currentImage.size.height
        
        if isTitleOnTop {
            titleLabel.center.x = self.bounds.width * 0.5
            titleLabel.frame.origin.y = self.bounds.height * 0.5 - titleLabel.frame.size.height
            
            
            let imageHeight = self.bounds.height - titleLabel.frame.size.height
            let imageY = self.bounds.height * 0.5
            let imageWidth = self.bounds.width
            
            imageView.center.x = titleLabel.center.x
            imageView.frame.origin.y = imageY
            imageView.frame.size = CGSize(width: imageWidth, height: imageHeight)
        }else{
            imageView.center.x = self.bounds.width * 0.5
            imageView.frame.origin.y = self.bounds.height * 0.5 - imageView.frame.size.height
            
            
            let labelHeight = self.bounds.height - imageView.frame.size.height
            let labelY = self.bounds.height * 0.5
            let labelWidth = self.bounds.width
            
            titleLabel.center.x = imageView.center.x
            titleLabel.frame.origin.y = labelY
            titleLabel.frame.size = CGSize(width: labelWidth, height: labelHeight)
        }
        
        
        titleLabel.sizeToFit()
    }
}
