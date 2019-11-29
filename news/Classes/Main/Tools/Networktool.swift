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
    // MARK: - --------------------------------- 首页 home  ---------------------------------
    // MARK: 首页顶部新闻标题的数据
    static func loadHomeNewsTitleData(completionHandler: @escaping (_ newsTitles: [HomeNewsTitle]) -> ())
    // -------------------- 我的界面 mine --------------------
    // 我的界面 cell 数据
    static func loadMyCellData(completionHandler: @escaping (_ sections: [[MyCellModel]]) ->())
    // MARK: 我的关注数据
    static func loadMyConcern(completionHandler: @escaping (_ concerns: [MyConcern]) -> ())
    
   static func loadUserDetail(userId: Int, completionHandler: @escaping (_ userDetail: UserDetail) -> ())
    
}

extension NetworkToolProtocol {
    // MARK: - --------------------------------- 首页 home  ---------------------------------
    /// 首页顶部新闻标题的数据
    /// - parameter completionHandler: 返回标题数据
    /// - parameter newsTitles: 首页标题数组
    static func loadHomeNewsTitleData(completionHandler: @escaping (_ newsTitles: [HomeNewsTitle]) -> ()) {
        let url = BASE_URL + "/article/category/get_subscribed/v1/?"
        let params = ["device_id": device_id,
                      "iid": iid]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            // 网络错误的提示信息
            guard response.result.isSuccess else { return }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else { return }
                if let dataDict = json["data"].dictionary {
                    if let datas = dataDict["data"]?.arrayObject {
                        var titles = [HomeNewsTitle]()
                        titles.append(HomeNewsTitle.deserialize(from: "{\"category\": \"\", \"name\": \"推荐\"}")!)
                        titles += datas.compactMap({ HomeNewsTitle.deserialize(from: $0 as? Dictionary) })
                        completionHandler(titles)
                    }
                }
            }
        }
    }
    
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
    
    /// 获取用户详情数据
    /// - parameter userId: 用户id
    /// - parameter completionHandler: 返回用户详情数据
    /// - parameter userDetail:  用户详情数据
    static func loadUserDetail(userId: Int, completionHandler: @escaping (_ userDetail: UserDetail) -> ()) {
        
        let url = BASE_URL + "/user/profile/homepage/v4/?"
        let params = ["user_id": userId,
                      "device_id": device_id,
                      "iid": iid]
        
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            // 网络错误的提示信息
            guard response.result.isSuccess else { return }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else { return }
                completionHandler(UserDetail.deserialize(from: json["data"].dictionaryObject)!)
            }
        }
    }
}

struct NetworkTool: NetworkToolProtocol {
    
}
