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
    init(items: [ItemModel])
    var didModelUpdated: (() -> ())? { get set }
    func item(forRow: Int) -> ItemModel?
    func numberOfItems() -> Int?
}

class ChartViewModel: ListViewModel, Loggable {
    var items: [AppModel]? {
        didSet {
            logd(debugMessage: "apps didSet")
            self.didModelUpdated?()
        }
    }

    var didModelUpdated: (() -> ())?
    
    required init(items: [AppModel]) {
        defer { self.items = items }
        logd(debugMessage: "ChartViewModel init ends")
    }
    
    func item(forRow index: Int) -> AppModel? {
        return items?[index]
    }
    
    func numberOfItems() -> Int? {
        return items?.count
    }
}
