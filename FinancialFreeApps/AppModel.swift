//
//  AppModel.swift
//  FinancialFreeApps
//
//  Created by Samuel Kim on 2018. 1. 23..
//  Copyright © 2018년 Samuel Kim. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol ItemViewModel {
}

struct AppModel: ItemViewModel {
    let id: Int
    let name: String
    let iconUrl: URL
    let link: URL
    
    static func models(from json: JSON) -> [AppModel] {
        var apps: [AppModel] = []
        for item in json["feed"]["entry"].arrayValue {
            let id = Int(item["id"]["attributes"]["im:id"].string!)!
            let name = item["im:name"]["label"].string!
            let iconUrl = URL(string: item["im:image"].arrayValue[2]["label"].string!)!
            let link = URL(string: item["link"]["attributes"]["href"].string!)!
            apps.append(AppModel(id: id, name: name, iconUrl: iconUrl, link: link))
        }
        return apps
    }
}

typealias AppDetailModel = JSON
