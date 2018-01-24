//
//  ChartViewModel.swift
//  FinancialFreeApps
//
//  Created by Samuel Kim on 2018. 1. 24..
//  Copyright © 2018년 Samuel Kim. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol ChartViewModel {
    var apps: [AppModel]? { get }
    init(apps: [AppModel])
    var didModelUpdated: (() -> ())? { get set }
    func app(forRow: Int) -> AppModel?
    func numberOfApps() -> Int?
}

class AppModelList: ChartViewModel, Loggable {
    var apps: [AppModel]? {
        didSet {
            logd(debugMessage: "apps didSet")
            self.didModelUpdated?()
        }
    }

    var didModelUpdated: (() -> ())?
    
    required init(apps: [AppModel]) {
        defer { self.apps = apps }
        logd(debugMessage: "AppModelList init ends")
    }
    
    func app(forRow index: Int) -> AppModel? {
        return apps?[index]
    }
    
    func numberOfApps() -> Int? {
        return apps?.count
    }
}
