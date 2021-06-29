//
// Copyright © 2021 Yoti Ltd. All rights reserved.
//

import UIKit

extension Theme {
    var font: UIFont {
        switch self {
            case .easyID: return Theme.easyIDFont()
            default: return Theme.yotiFont()
        }
    }

    static func yotiFont(ofSize fontSize: CGFloat = 15) -> UIFont {
        UIFont.register(font: "GT-Eesti-Display-Bold", type: "ttf")
        return UIFont(name: "GTEestiDisplay-Bold", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }

    static func easyIDFont(ofSize fontSize: CGFloat = 15) -> UIFont {
        UIFont.register(font: "NunitoSans-Bold", type: "ttf")
        return UIFont(name: "NunitoSans-Bold", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }
}
