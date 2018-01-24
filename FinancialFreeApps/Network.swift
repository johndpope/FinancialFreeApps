//
//  Network.swift
//  FinancialFreeApps
//
//  Created by Samuel Kim on 2018. 1. 23..
//  Copyright © 2018년 Samuel Kim. All rights reserved.
//

import Foundation

struct Network {
    private init() {}
    
    static func asyncDataTask(with url: URL, completionHandler:((_ data: Data?, _ error: Error?) -> Void)?) {
        DispatchQueue.global().async {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                completionHandler?(data, error)
            }).resume()
        }
    }
}
