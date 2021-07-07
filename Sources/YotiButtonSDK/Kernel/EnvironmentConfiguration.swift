//
// Copyright © 2017 Yoti Limited. All rights reserved.
//

struct EnvironmentConfiguration {
    struct Transport {
        static let key = "transport"
        static let uri = "URI"
    }

    struct URL {
        static let host       = "connect.public.stg1.dmz.yoti.com"
        static let port       = 443

        static let scheme = "https"
        static let endpoint = "/api/v1/sessions/apps/%@/scenarios/%@"
    }

    struct YotiApp {
        static let bundleID = "com.yoti.mobile.ios.staging"
    }
}
