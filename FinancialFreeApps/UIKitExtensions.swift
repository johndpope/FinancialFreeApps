//
//  UIKitExtensions.swift
//  FinancialFreeApps
//
//  Created by Samuel Kim on 2018. 1. 24..
//  Copyright © 2018년 Samuel Kim. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

extension UIImageView {
    func setImage(from url:String, placeHolder:String) {
        
        self.image = UIImage(named: "AppIconPlaceHolder")
        
        Network.asyncDataTask(with: url, completionHandler: { [weak self] (data, error) in
            if let _ = error {
                return
            }
            guard let data = data else {
                return
            }
            DispatchQueue.main.async {
                self?.image = UIImage(data: data)
            }
        })
    }
}
