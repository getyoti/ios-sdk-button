//
//  NetworkError.swift
//  YotiButtonSDK
//
//  Created by Casper Lee on 20/07/2017.
//  Copyright © 2017 Yoti Limited. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case httpError(Int)
    case networkError
}
