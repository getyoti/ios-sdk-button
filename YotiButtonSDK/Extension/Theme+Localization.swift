//
// Copyright © 2021 Yoti Ltd. All rights reserved.
//

import UIKit

extension Theme {
    var stockCopy: String {
        switch self {
            case .yoti, .yotiUK: return "CONTINUE WITH YOTI"
            case .easyID: return "Continue with Post Office EasyID"
            case .partnership: return "Continue with your Digital ID"
        }
    }
}
