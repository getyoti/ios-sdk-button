//
//  GenericError.swift
//  YotiButtonSDK
//
//  Created by Casper Lee on 20/07/2017.
//  Copyright © 2017 Yoti Limited. All rights reserved.
//

import Foundation

public enum GenericError: Error {
    case nilValue(String)
    case malformedValue(String)
    case unknown(String)
}
