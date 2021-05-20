//
// Copyright © 2017 Yoti Limited. All rights reserved.
//

import Foundation

public enum GenericError: Error {
    case nilValue(String)
    case malformedValue(String)
    case unknown(String)
}
