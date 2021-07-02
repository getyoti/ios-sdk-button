//
// Copyright © 2021 Yoti Ltd. All rights reserved.
//

import UIKit

extension Theme {
    var stockCopyValue: String {
        switch self {
            case .yoti, .yotiUK: return "CONTINUE WITH YOTI"
            case .easyID: return "Continue with Post Office EasyID"
            case .partnership: return "Continue with your Digital ID"
        }
    }

    var stockCopyKey: LocalizationKey {
        switch self {
            case .yoti, .yotiUK: return .yoti
            case .easyID: return .easyID
            case .partnership: return .partnership
        }
    }

    enum LocalizationKey: String, CodingKey {
        case yoti = "yoti.sdk.yoti.button.label"
        case easyID = "yoti.sdk.easyid.button.label"
        case partnership = "yoti.sdk.partnership.button.label"
    }
}
