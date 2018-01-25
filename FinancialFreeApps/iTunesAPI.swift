//
//  iTunesAPI.swift
//  FinancialFreeApps
//
//  Created by Samuel Kim on 2018. 1. 24..
//  Copyright © 2018년 Samuel Kim. All rights reserved.
//

import Foundation
import RxSwift

enum iTunesAPI: String, Loggable {
    case topFreeFinanceApps = "https://itunes.apple.com/kr/rss/topfreeapplications/limit=50/genre=6015/json"
    case appDetails = "https://itunes.apple.com/lookup?id={id}&country=kr"
    
    func request(params:[String:String]?, completionHandler: ((Data) -> Void)?) {
        var urlString = self.rawValue
        if let params = params {
            for key in params.keys {
                urlString = urlString.replacingOccurrences(of: "{\(key)}", with: params[key]!)
            }
        }
        if let url = URL(string: urlString) {
            Network.asyncDataTask(with: url, completionHandler: { (data, error) in
                if let error = error {
                    self.loge(errorMessage: error.localizedDescription)
                    return
                }
                guard let data = data else {
                    return
                }
                completionHandler?(data)
            })
        }
    }
}
