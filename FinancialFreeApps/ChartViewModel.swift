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
    init()
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
    
    required init() {
        iTunesAPI.topFreeFinanceApps.request(params: nil) { [weak self] (data) in
            guard let json = try? JSON(data: data) else {
                return
            }
            self?.apps = AppModel.models(from: json)
        }
        logd(debugMessage: "AppModelList init ends")
    }
    
    func app(forRow index: Int) -> AppModel? {
        return apps?[index]
    }
    
    func numberOfApps() -> Int? {
        return apps?.count
    }
}
