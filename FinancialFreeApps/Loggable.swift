//
//  Loggable.swift
//  FinancialFreeApps
//
//  Created by Samuel Kim on 2018. 1. 24..
//  Copyright © 2018년 Samuel Kim. All rights reserved.
//

import Foundation

protocol Loggable {
    func loge(errorMessage: String?)
    func logw(warningMessage: String?)
    func logi(infoMessage: String?)
    func logd(debugMessage: String?)
    func logv(verboseMessage: String?)
}

enum LogLevel: String {
    case error = "Error"
    case warning = "Warning"
    case info = "Info"
    case verbose = "Verbose"
    case debug = "Debug"
}

extension Loggable {
    private func log(level: LogLevel, message: String?) {
        #if DEBUG
            if let message = message {
                NSLog("[\(level.rawValue)] \(type(of: self)) - \(message)")
            } else {
                NSLog("[\(level.rawValue)] \(type(of: self)) - nil")
            }
        #endif
    }
    
    func loge(errorMessage: String?) {
        log(level: .error, message: errorMessage)
    }
    
    func logw(warningMessage: String?) {
        log(level: .warning, message: warningMessage)
    }
    
    func logi(infoMessage: String?) {
        log(level: .info, message: infoMessage)
    }
    
    func logv(verboseMessage: String?) {
        log(level: .verbose, message: verboseMessage)
    }
    
    func logd(debugMessage: String?) {
        log(level: .debug, message: debugMessage)
    }
}
