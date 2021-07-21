//
// Copyright © 2017 Yoti Limited. All rights reserved.
//

import Foundation
import UIKit

/// A button which can be used to begin the action of requesting attributes from the Digital ID applications
///
/// The button must be customized with at least a ``useCaseID`` to allow the SDK to identify this particular button
@IBDesignable public class YotiButton: UIView {
    public typealias TouchedUpInside = (YotiButton) -> Void

    public static let defaultFrame = CGRect(x: 0, y: 0, width: 300, height: 44)
    private var button = InnerButton(frame: YotiButton.defaultFrame)
    private var heightConstraint: NSLayoutConstraint?
    private var buttonConstraints: [NSLayoutConstraint] = []
    private var supportConstraints: [NSLayoutConstraint] = []
    private lazy var supportView = SupportView(frame: .zero)

    @IBInspectable public var useCaseID: String?
    @objc public var action: TouchedUpInside?

    @objc public var theme = Theme.default {
        didSet {
            button.apply(theme: theme)
            removeConstraints()
            addSupportViewIfNecessary()
            addConstraints()
        }
    }

    public convenience init() {
        self.init(frame: YotiButton.defaultFrame)
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }

    @objc public func setTitle(_ title: String?, for state: UIControl.State) {
        button.setTitle(title, for: state)
    }

    @objc public func setTitleColor(_ color: UIColor?, for state: UIControl.State) {
        button.setTitleColor(color, for: state)
    }
}

private extension YotiButton {
    func setUpView() {
        button.addTarget(self, action: #selector(buttonTouchedUpInside), for: UIControl.Event.touchUpInside)
        addSubview(button)
        addSupportViewIfNecessary()
        button.translatesAutoresizingMaskIntoConstraints = false
        translatesAutoresizingMaskIntoConstraints = false
        addConstraints()
    }

    @objc func buttonTouchedUpInside() {
        action?(self)
    }

    func addSupportViewIfNecessary() {
        switch theme {
            case .partnership: addSubview(supportView)
            default: supportView.removeFromSuperview()
        }
    }

    func removeConstraints() {
        NSLayoutConstraint.deactivate(supportConstraints + buttonConstraints)
        if let heightConstraint = heightConstraint {
            removeConstraint(heightConstraint)
        }
    }

    func addConstraints() {
        switch theme {
            case .partnership:
                heightConstraint = heightAnchor.constraint(equalToConstant: YotiButton.defaultFrame.height + SupportView.height)
            default:
                heightConstraint = heightAnchor.constraint(greaterThanOrEqualToConstant: YotiButton.defaultFrame.height)

        }
        heightConstraint?.isActive = true
        constrainButtonToEdges()
        constrainSupportView()
    }

    func constrainButtonToEdges() {
        buttonConstraints = [button.topAnchor.constraint(equalTo: topAnchor),
                             button.leftAnchor.constraint(equalTo: leftAnchor),
                             button.rightAnchor.constraint(equalTo: rightAnchor),
                             button.heightAnchor.constraint(greaterThanOrEqualToConstant: YotiButton.defaultFrame.height),
        ]
        if theme != .partnership {
            buttonConstraints += [button.bottomAnchor.constraint(equalTo: bottomAnchor)]
        }
        NSLayoutConstraint.activate(buttonConstraints)

    }

    func constrainSupportView() {
        guard supportView.superview != nil else { return }
        supportConstraints = [supportView.leftAnchor.constraint(equalTo: leftAnchor),
                              supportView.rightAnchor.constraint(equalTo: rightAnchor),
                              supportView.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 8),
                              supportView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ]
        NSLayoutConstraint.activate(supportConstraints)
    }
}
