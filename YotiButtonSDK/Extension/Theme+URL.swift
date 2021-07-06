//
// Copyright © 2021 Yoti Ltd. All rights reserved.
//

import Foundation

extension Theme {
    var appStoreURL: URL {
        switch self {
            case .easyID: return URL(string: "itms-apps://itunes.apple.com/app/id1552010191")!
            case .yoti, .yotiUK: return URL(string: "itms-apps://itunes.apple.com/app/id983980808")!
            case .partnership: return URL(string: "https://code.yoti.com")!
        }
    }
}

extension Theme {
    var scheme: String {
        switch self {
            case .easyID: return "easyid"
            default: return "https"
        }
    }
}
