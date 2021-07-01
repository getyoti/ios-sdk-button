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
        case yoti = "YotiButton_yoti_button_message"
        case easyID = "YotiButton_easyid_button_message"
        case partnership = "YotiButton_partner_button_message"
    }
}
