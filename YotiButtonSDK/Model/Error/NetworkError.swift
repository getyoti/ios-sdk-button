//
// Copyright © 2017 Yoti Limited. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case httpError(Int)
    case networkError
}
