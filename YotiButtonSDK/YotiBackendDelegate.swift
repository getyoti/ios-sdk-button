//
//  YotiBackendDelegate.swift
//  YotiButtonSDK
//
//  Created by Charles Vu on 15/08/2018.
//  Copyright © 2018 Yoti Limited. All rights reserved.
//

import Foundation

@objc(YTBBackendDelegate)
public protocol BackendDelegate {
    func backendDidFinish(with data: Data?, error: Error?)
}
