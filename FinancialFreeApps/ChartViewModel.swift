//
//  ChartViewModel.swift
//  FinancialFreeApps
//
//  Created by Samuel Kim on 2018. 1. 24..
//  Copyright © 2018년 Samuel Kim. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol ListViewModel {
    associatedtype ItemModel
    var items: [ItemModel]? { get }
    init(model: JSON)
    var didModelUpdated: (() -> ())? { get set }
    func parseModel()
    func item(forRow: Int) -> ItemModel?
    func numberOfItems() -> Int?
}

class ChartViewModel: ListViewModel, Loggable {
    var json: JSON!
    var items: [AppViewModel]? {
        didSet {
            self.didModelUpdated?()
            logd(debugMessage: "apps didSet")
        }
    }

    var didModelUpdated: (() -> ())?
    
    required init(model: JSON) {
        defer { self.json = model }
        logd(debugMessage: "ChartViewModel init ends")
    }
    
    func parseModel() {
        items = AppViewModel.itemViewModels(from: json)
    }
    
    func item(forRow index: Int) -> AppViewModel? {
        return items?[index]
    }
    
    func numberOfItems() -> Int? {
        return items?.count
    }
    
}
