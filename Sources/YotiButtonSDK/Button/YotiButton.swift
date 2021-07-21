//
// Copyright © 2017 Yoti Limited. All rights reserved.
//

import Foundation
import UIKit

/// A button which can be used to begin the action of requesting attributes from the Digital ID applications.
///
/// The button must be customized with at least a ``useCaseID`` and ``action`` closure/block.
@IBDesignable public class YotiButton: UIView {
    public typealias TouchedUpInside = (YotiButton) -> Void

    public static let defaultFrame = CGRect(x: 0, y: 0, width: 300, height: 44)
    private var button = InnerButton(frame: YotiButton.defaultFrame)
    private var heightConstraint: NSLayoutConstraint?
    private var buttonConstraints: [NSLayoutConstraint] = []
    private var supportConstraints: [NSLayoutConstraint] = []
    private lazy var supportView = SupportView(frame: .zero)

    /// Set this to a value that will allow us to identify the button.
    @IBInspectable public var useCaseID: String?

    /// Set this closure/block to handle the button touch event.
    @objc public var action: TouchedUpInside?

    /// The theme may be used to target a specific app or and may insert a supplementary view underneath it.
    @objc public var theme = Theme.default {
        didSet {
            button.apply(theme: theme)
            button.resetCopy()
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

    /// Default is set according to the ``theme`` and is assumed to be single line.
    /// - Parameters:
    ///   - title: Text which will be set on the button.
    ///   - state: UIControl.State which the text will apply to.
    @objc public func setTitle(_ title: String?, for state: UIControl.State) {
        button.setTitle(title, for: state)
    }

    /// Default is opaque white.
    /// - Parameters:
    ///   - color: Color to set on the title.
    ///   - state: UIControl.State which the color will apply to.
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
