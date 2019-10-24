//
//  UserDetailViewController.swift
//  news
//
//  Created by secoo on 2019/9/23.
//  Copyright © 2019 lxd. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet var bottomViewHeight: NSLayoutConstraint!
    @IBOutlet var bottomViewBottom: NSLayoutConstraint!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        scrollView.addSubview(headerView)
        scrollView.contentSize = CGSize(width: screenWidth, height: 1000)
        // 设置约束，避免 bottomView 顶到边界
        bottomViewBottom.constant = isIPhoneX ? 34 : 0
        view.layoutIfNeeded()
    }
    
    /// 懒加载
    fileprivate lazy var headerView: UserDetailHeaderView = {
        let headerView = UserDetailHeaderView.headerView()
        return headerView
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
