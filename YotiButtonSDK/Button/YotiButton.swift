//
// Copyright © 2017 Yoti Limited. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
public class YotiButton: UIView {
    private static let defaultFrame = CGRect(x: 0, y: 0, width: 300, height: 44)
    @IBInspectable public var useCaseID: String?
    public var theme = Theme.yoti {
        didSet {
            button.apply(theme: theme)
            addSupportViewIfNecessary()
            adjustConstraints()
        }
    }
    var button = InnerButton(frame: YotiButton.defaultFrame)
    var heightConstraint: NSLayoutConstraint?
    var buttonBottomConstraint: NSLayoutConstraint?
    lazy var supportView = SupportView(frame: .zero)

    public convenience init() {
        self.init(frame: YotiButton.defaultFrame)
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        initalize()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initalize()
    }

    func initalize() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
    }

    public func setTitle(_ title: String?, for state: UIControl.State) {
        button.setTitle(title, for: state)
    }

    public func setTitleColor(_ color: UIColor?, for state: UIControl.State) {
        button.setTitleColor(color, for: state)
    }

    func adjustConstraints() {
        if let heightConstraint = heightConstraint {
            removeConstraint(heightConstraint)
        }
        switch theme {
            case .partnership:
                heightConstraint = heightAnchor.constraint(equalToConstant: YotiButton.defaultFrame.height + 28)
            default:
                heightConstraint = heightAnchor.constraint(equalToConstant: YotiButton.defaultFrame.height)

        }
        heightConstraint!.isActive = true
        constrainButtonToEdges()
    }

    func constrainButtonToEdges() {
        button.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        button.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        button.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        if theme != .partnership {
            buttonBottomConstraint = button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
            buttonBottomConstraint?.isActive = true
        }
    }

    func addSupportViewIfNecessary() {
        switch theme {
            case .partnership: addSupportView()
            default: supportView.removeFromSuperview()
        }
    }

    func addSupportView() {
        if let buttonBottomConstraint = buttonBottomConstraint {
            removeConstraint(buttonBottomConstraint)
        }
        addSubview(supportView)
        supportView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        supportView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        supportView.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 8).isActive = true
        supportView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
}
