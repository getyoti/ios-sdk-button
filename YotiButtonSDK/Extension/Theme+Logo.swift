//
// Copyright © 2021 Yoti Ltd. All rights reserved.
//

import UIKit

extension Theme {
    var logo: UIImage? {
        switch self {
            case .yotiUK, .easyID: return Resource.loadImage(name: "id_brand")
            case .partnership: return Resource.loadImage(name: "id_brand_charcoal")
            default: return Resource.loadImage(name: "yoti_brand")
        }
    }
}
