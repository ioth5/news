//
//  NetworkTool.swift
//  news
//
//  Created by secoo on 2019/5/22.
//  Copyright © 2019 lxd. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol NetworkToolProtocol {
    // -------------------- 我的界面 mine --------------------
    // 我的界面 cell 数据
    static func loadMyCellData(completionHandler: @escaping (_ sections: [[MyCellModel]]) ->())
    // MARK: 我的关注数据
    static func loadMyConcern(completionHandler: @escaping (_ concerns: [MyConcern]) -> ())
    
}

extension NetworkToolProtocol {
    // -------------------- 我的界面 mine --------------------
    // 我的界面 cell 数据
    static func loadMyCellData(completionHandler: @escaping (_ sections: [[MyCellModel]]) ->()) {
        let url = BASE_URL + "/user/tab/tabs/?"
        let params = ["device_id": device_id]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else {
                // 网络错误提示信息
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                
                guard json["message"] == "success" else {
                    return
                }
                if let data = json["data"].dictionary {
                    if let sections = data["sections"]?.array {
                        var sectionArray = [[MyCellModel]]()
                        for item in sections {
                            var rows = [MyCellModel]()
                            for row in item.arrayObject! {
                                let myCellModel = MyCellModel.deserialize(from: row as? NSDictionary)
                                rows.append(myCellModel!)
                            }
                            sectionArray.append(rows)
                        }
                        completionHandler(sectionArray)
                    }
                }
            }
       }
    }
        
    /// 我的关注数据
    /// - parameter completionHandler: 返回我的关注数据
    /// - parameter concerns: 我的界面我的关注数组
    static func loadMyConcern(completionHandler: @escaping (_ concerns: [MyConcern]) -> ()) {
        
        let url = BASE_URL + "/concern/v2/follow/my_follow/?"
        let params = ["device_id": device_id]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else {
                // 网络错误提示信息
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                
                guard json["message"] == "success" else {
                    return
                }
                if let datas = json["data"].arrayObject {
                    var concerns = [MyConcern]()
                    for data in datas {
                        let myCellModel = MyConcern.deserialize(from: data as? NSDictionary)
                        concerns.append(myCellModel!)
                    }
                    completionHandler(concerns)
                }
            }
        }
    }
}

struct NetworkTool: NetworkToolProtocol {
    
}
