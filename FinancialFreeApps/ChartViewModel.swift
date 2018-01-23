//
//  ChartViewModel.swift
//  FinancialFreeApps
//
//  Created by Samuel Kim on 2018. 1. 24..
//  Copyright © 2018년 Samuel Kim. All rights reserved.
//

import Foundation

protocol ChartViewModel {
    init(apps: [AppModel])
    func app(forRow: Int) -> AppModel
    func numberOfApps() -> Int
}

class AppModelList: ChartViewModel {
    var apps: [AppModel]!

    required init(apps: [AppModel]) {
        self.apps = apps
    }
    
    func app(forRow index: Int) -> AppModel {
        return apps[index]
    }
    
    func numberOfApps() -> Int {
        return apps.count
    }
}
