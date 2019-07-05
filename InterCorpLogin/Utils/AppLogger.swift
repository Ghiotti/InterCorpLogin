//
//  AppLogger.swift
//  InterCorpLogin
//
//  Created by Franco Ghiotti on 05/07/2019.
//  Copyright © 2019 Franco Ghiotti. All rights reserved.
//

import Foundation

class AppLogger {
    
    enum LogLevel: Int {
        
        case DEBUG = 5001
        case INFO = 5002
        case WARN = 5003
        case ERROR = 5004
    }
    
    static func d(_ tag: String, _ message: String) {
        log(logLevel: LogLevel.DEBUG, tag: tag, message: message, error: nil)
    }
    
    static func d(_ tag: String, _ message: String, _ error: Error) {
        log(logLevel: LogLevel.DEBUG, tag: tag, message: message, error: error)
    }
    
    static func i(_ tag: String, _ message: String) {
        log(logLevel: LogLevel.INFO, tag: tag, message: message, error: nil)
    }
    
    static func i(_ tag: String, _ message: String, _ error: Error) {
        log(logLevel: LogLevel.INFO, tag: tag, message: message, error: error)
    }
    
    static func w(_ tag: String, _ message: String) {
        log(logLevel: LogLevel.WARN, tag: tag, message: message, error: nil)
    }
    
    static func w(_ tag: String, _ message: String, _ error: Error) {
        log(logLevel: LogLevel.WARN, tag: tag, message: message, error: error)
    }
    
    static func e(_ tag: String, _ message: String) {
        log(logLevel: LogLevel.ERROR, tag: tag, message: message, error: nil)
    }
    
    static func e(_ tag: String, _ message: String, _ error: Error) {
        log(logLevel: LogLevel.ERROR, tag: tag, message: message, error: error)
    }
    
    private static func log(logLevel: LogLevel, tag: String, message: String, error: Error?) {
        print("\(tag) - \(message) - \(error?.localizedDescription ?? String())")
    }
}
