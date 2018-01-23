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
    
    static func asyncDataTask(with urlString: String, completionHandler:@escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url, completionHandler: completionHandler).resume()
        }
    }
}
