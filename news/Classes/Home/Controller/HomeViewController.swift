//
//  HomeViewController.swift
//  news
//
//  Created by secoo on 2019/2/19.
//  Copyright © 2019 lxd. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    // 标题数据表
    fileprivate let newsTitleTable = NewsTitleTable()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        NetworkTool.loadHomeNewsTitleData { (titles) in
           // 像数据库中插入数据
            self.newsTitleTable.insert(titles)
        }
    }
}
