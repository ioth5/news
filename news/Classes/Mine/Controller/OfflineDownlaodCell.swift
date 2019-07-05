//
//  OfflineDownlaodCell.swift
//  news
//
//  Created by secoo on 2019/7/4.
//  Copyright © 2019 lxd. All rights reserved.
//

import UIKit

class OfflineDownlaodCell: UITableViewCell, RegisterCellFromNib {

    /// 标题
    @IBOutlet weak var titleLabel: UILabel!
    /// 勾选图片
    @IBOutlet weak var rightImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        theme_backgroundColor = "colors.cellBackgroundColor"
        titleLabel.theme_textColor = "colors.black"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
