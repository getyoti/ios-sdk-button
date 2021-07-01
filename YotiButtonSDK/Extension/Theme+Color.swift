//
// Copyright © 2021 Yoti Ltd. All rights reserved.
//

import UIKit

extension Theme {
    func colors(for state: UIControl.State) -> InnerButton.Colors  {
        switch self {
            case .yoti, .yotiUK: return yotiColors(for: state)
            case .easyID: return easyIDColors(for: state)
            case .partnership: return partnershipColors(for: state)
        }
    }

    func yotiColors(for state: UIControl.State) -> InnerButton.Colors {
        switch state {
            case .normal: return ButtonColor.Yoti.normal
            case .highlighted, .selected: return ButtonColor.Yoti.selected
            default: return ButtonColor.Yoti.disabled
        }
    }

    func easyIDColors(for state: UIControl.State) -> InnerButton.Colors {
        switch state {
            case .normal: return ButtonColor.EasyID.normal
            case .highlighted, .selected: return ButtonColor.EasyID.selected
            default: return ButtonColor.EasyID.disabled
        }
    }

    func partnershipColors(for state: UIControl.State) -> InnerButton.Colors {
        switch state {
            case .normal: return ButtonColor.Partnership.normal
            case .highlighted, .selected: return ButtonColor.Partnership.selected
            default: return ButtonColor.Partnership.disabled
        }
    }

    struct ButtonColor {
        struct Yoti {
            static let normal = InnerButton.Colors(background: Resource.color(named: "yoti_background"),
                                              foreground: Resource.color(named: "yoti_foreground"),
                                              border: Resource.color(named: "yoti_border"))
            static let selected = InnerButton.Colors(background: Resource.color(named: "yoti_backgroundSelected"),
                                                foreground: Resource.color(named: "yoti_foregroundSelected"),
                                                border: Resource.color(named: "yoti_borderSelected"))
            static let disabled = InnerButton.Colors(background: Resource.color(named: "yoti_backgroundDisabled"),
                                                foreground: Resource.color(named: "yoti_foregroundDisabled"),
                                                border: Resource.color(named: "yoti_borderDisabled"))
        }
        struct EasyID {
            static let normal = InnerButton.Colors(background: Resource.color(named: "easyid_background"),
                                              foreground: Resource.color(named: "easyid_foreground"),
                                              border: Resource.color(named: "easyid_border"))
            static let selected = InnerButton.Colors(background: Resource.color(named: "easyid_backgroundSelected"),
                                                foreground: Resource.color(named: "easyid_foregroundSelected"),
                                                border: Resource.color(named: "easyid_borderSelected"))
            static let disabled = InnerButton.Colors(background: Resource.color(named: "easyid_backgroundDisabled"),
                                                foreground: Resource.color(named: "easyid_foregroundDisabled"),
                                                border: Resource.color(named: "easyid_borderDisabled"))
        }
        struct Partnership {
            static let normal = InnerButton.Colors(background: Resource.color(named: "partner_background"),
                                              foreground: Resource.color(named: "partner_foreground"),
                                              border: Resource.color(named: "partner_border"))
            static let selected = InnerButton.Colors(background: Resource.color(named: "partner_backgroundSelected"),
                                                foreground: Resource.color(named: "partner_foregroundSelected"),
                                                border: Resource.color(named: "partner_borderSelected"))
            static let disabled = InnerButton.Colors(background: Resource.color(named: "partner_backgroundDisabled"),
                                                foreground: Resource.color(named: "partner_foregroundDisabled"),
                                                border: Resource.color(named: "partner_borderDisabled"))
        }
    }
}
