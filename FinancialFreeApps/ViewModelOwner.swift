//
//  ViewModelOwner.swift
//  FinancialFreeApps
//
//  Created by Samuel Kim on 2018. 1. 25..
//  Copyright © 2018년 Samuel Kim. All rights reserved.
//

import Foundation
import RxSwift

public protocol NonReusableViewModelOwner: class {
    associatedtype ViewModelProtocol
    var viewModel: ViewModelProtocol { get set }
    
    func didSetViewModel(viewModel: ViewModelProtocol, disposeBag: DisposeBag)
}

public protocol ReusableViewModelOwner: class {
    associatedtype ViewModelProtocol
    var viewModel: ViewModelProtocol? { get set }
    
    func didSetViewModel(viewModel: ViewModelProtocol?, disposeBag: DisposeBag)
}

class ViewModelOwnerKeys {
    static var reuseBag = "reuseBag"
    static var viewModel = "viewModel"
}

private func viewModelDisposeBag(fromObject owner: NSObject) -> DisposeBag {
    let bag: DisposeBag = {
        let currentBag: DisposeBag? = objc_getAssociatedObject(owner, &ViewModelOwnerKeys.reuseBag) as? DisposeBag
        return currentBag ?? DisposeBag()
    }()
    
    objc_setAssociatedObject(owner, &ViewModelOwnerKeys.reuseBag, bag, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    return bag
}

extension NonReusableViewModelOwner where Self: NSObject {
    public var viewModel: ViewModelProtocol {
        set {
            let previousVM: ViewModelProtocol? = objc_getAssociatedObject(self, &ViewModelOwnerKeys.viewModel) as? ViewModelProtocol
            
            assert(previousVM == nil, "\(type(of: self)) doesn't support reusable viewModel. Use ReusableViewModelOwner instead.")
            
            objc_setAssociatedObject(self, &ViewModelOwnerKeys.viewModel, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            
            let bag = viewModelDisposeBag(fromObject: self)
            didSetViewModel(viewModel: newValue, disposeBag: bag)
        }
        
        get {
            return objc_getAssociatedObject(self, &ViewModelOwnerKeys.viewModel) as! ViewModelProtocol
        }
    }
}

extension ReusableViewModelOwner where Self: NSObject {
    public var viewModel: ViewModelProtocol? {
        set {
            if let _ = objc_getAssociatedObject(self, &ViewModelOwnerKeys.viewModel) as? ViewModelProtocol {
                objc_setAssociatedObject(self, &ViewModelOwnerKeys.viewModel, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
            objc_setAssociatedObject(self, &ViewModelOwnerKeys.viewModel, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            
            let bag = viewModelDisposeBag(fromObject: self)
            didSetViewModel(viewModel: newValue, disposeBag: bag)
        }
        
        get {
            return objc_getAssociatedObject(self, &ViewModelOwnerKeys.viewModel) as? ViewModelProtocol
        }
    }
}
