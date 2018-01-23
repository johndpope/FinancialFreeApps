//
//  AppModel.swift
//  FinancialFreeApps
//
//  Created by Samuel Kim on 2018. 1. 23..
//  Copyright © 2018년 Samuel Kim. All rights reserved.
//

import Foundation
import SwiftyJSON

struct AppModel {
    let name: String
    let iconUrl: String
    let link: String
    
    static func models(from json: JSON) -> [AppModel] {
        var apps: [AppModel] = []
        for item in json["feed"]["entry"].arrayValue {
            let name = item["im:name"]["label"].string!
            let iconUrl = item["im:image"].arrayValue[2]["label"].string!
            let link = item["link"]["attributes"]["href"].string!
            apps.append(AppModel(name: name, iconUrl: iconUrl, link: link))
        }
        return apps
    }
}
