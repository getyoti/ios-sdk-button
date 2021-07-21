//
// Copyright © 2018 Yoti Limited. All rights reserved.
//

import Foundation

@objc(YTBBackendDelegate)
public protocol BackendDelegate {
    func backendDidFinish(with data: Data?, error: Error?)
}
