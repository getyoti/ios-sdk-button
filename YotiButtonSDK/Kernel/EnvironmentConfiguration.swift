//
//  EnvironmentConfiguration.swift
//  YotiButtonSDK
//
//  Created by Casper Lee on 20/07/2017.
//  Copyright © 2017 Yoti Limited. All rights reserved.
//

import Foundation

struct EnvironmentConfiguation {
    
    struct Transport {
        static let key = "transport"
        static let uri = "URI"
    }
    
    struct URL {
        static let host       = "api.yoti.com"
        static let port       = 443

        static let scheme = "https"
        static let endpoint = "/api/v1/sessions/apps/%@/scenarios/%@"
    }
    
    
    struct YotiApp {
        static let bundleID = "com.yoti.mobile.ios.live"
    }
}
