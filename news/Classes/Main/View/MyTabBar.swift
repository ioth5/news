//
//  MyTabBar.swift
//  news
//
//  Created by secoo on 2019/2/19.
//  Copyright © 2019 lxd. All rights reserved.
//

import UIKit

class MyTabBar: UITabBar {
    override init(frame: CGRect) {
        super.init(frame: frame)
        theme_tintColor = "colors.tabbarTintColor"
        theme_barTintColor = "colors.cellBackgroundColor"
        addSubview(publishButton)
    }
    // private 绝对私有，除了在当前类中可以访问之外，其他任何类或者该类的扩展都不能访问
    // filePrivate 文件私有，可以在当前文件中访问，其他文件不能访问
    // open 在任何类文件中都能访问
    // interal 默认，可以不写
    private lazy var publishButton: UIButton = {
        let publishButton = UIButton(type: .custom)
        publishButton.setBackgroundImage(UIImage(named: "feed_publish_44x44_"), for: .normal)
        publishButton.setBackgroundImage(UIImage(named: "feed_publish_press_44x44_"), for: .selected)
        publishButton.theme_setBackgroundImage("images.publishButtonBackgroundImage", forState: .normal)
        publishButton.theme_setBackgroundImage("images.publishButtonBackgroundSelectedImage", forState: .selected)
        publishButton.sizeToFit()
        return publishButton
    }()
    required init?(coder aDecoder: NSCoder) {
        fatalError("has been")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 当前tabbar 的宽度和高度
        let width = frame.width
        let height: CGFloat = 49
        
        publishButton.center = CGPoint(x: width * 0.5, y: height * 0.5 - 7)
        //设置其他按钮的 frame
        let buttonW: CGFloat = width * 0.2
        let buttonH: CGFloat = height
        let buttonY: CGFloat = 0
        
        var index = 0
        for button in subviews {
            if !button.isKind(of: NSClassFromString("UITabBarButton")!) { continue }
            let buttonX = buttonW * (index > 1 ? CGFloat(index + 1) : CGFloat(index))
            button.frame = CGRect(x: buttonX, y: buttonY, width: buttonW, height: buttonH)
            index += 1
        }
    }
}
