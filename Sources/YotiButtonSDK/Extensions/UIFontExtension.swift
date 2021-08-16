//
// Copyright © 2017 Yoti Limited. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    static func register(font: String, type: String?) {
        guard let data = Resource.fontData(named: font, ofType: type),
              let provider = CGDataProvider(data: data as CFData)
        else {
            return
        }

        var error: Unmanaged<CFError>?
        guard let font = CGFont(provider) else { return }

        CTFontManagerRegisterGraphicsFont(font, &error)
    }
}
