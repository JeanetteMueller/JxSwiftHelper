//
//  Logging.swift
//  Podcat 2
//
//  Created by Jeanette Müller on 11.12.18.
//  Copyright © 2018 Jeanette Müller. All rights reserved.
//

import Foundation

public func log(_ items: Any...) {
    #if DEBUG
    print(items)
    #endif
}
public func log(_ items: Any..., terminator: String) {
    #if DEBUG
    print(items, terminator: terminator)
    #endif
}
public func log(_ items: Any..., separator: String, terminator: String) {
    #if DEBUG
    print(items, separator: separator, terminator: terminator)
    #endif
}

