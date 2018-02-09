//
//  CustomCertificate.swift
//  YotiButtonSDK
//
//  Created by Casper Lee on 20/07/2017.
//  Copyright © 2017 Yoti Limited. All rights reserved.
//

import Foundation

@objc (YTBCustomCertificate)
public class CustomCertificate: NSObject {
    
    var resourcePath: String
    
    @objc (initWithPath:)
    public init(resourcePath: String) {
        self.resourcePath = resourcePath
    }
    
}
