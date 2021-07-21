//
// Copyright © 2017 Yoti Limited. All rights reserved.
//

import Foundation
import UIKit

class InnerButton: UIButton {
    struct Colors {
        let background: UIColor
        let foreground: UIColor
        let border: UIColor
    }

    private var currentTheme: Theme = .yoti
    private var messageWidthConstraint: NSLayoutConstraint?

    private lazy var brandLogoView: UIImageView = {
        let image = currentTheme.logo
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.sizeToFit()
        return imageView
    }()

    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Use Yoti"
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.baselineAdjustment = .alignCenters
        label.sizeToFit()
        return label
    }()

    convenience init() {
        self.init(frame: YotiButton.defaultFrame)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }

    func setUpView() {
        addSubviews()
    }

    override func layoutSubviews() {
        setUpSubviews()
        apply(theme: currentTheme)
    }

    override func setTitle(_ title: String?, for state: UIControl.State) {
        messageLabel.text = title
        messageLabel.sizeToFit()
        messageWidthConstraint?.constant = messageLabel.frame.width
    }

    override func setTitleColor(_ color: UIColor?, for state: UIControl.State) {
        if let color = color {
            messageLabel.textColor = color
        }
    }

    func apply(theme: Theme) {
        currentTheme = theme
        backgroundColor = theme.colors(for: state).background
        layer.borderColor = theme.colors(for: state).border.cgColor
        messageLabel.textColor = theme.colors(for: state).foreground
        messageLabel.font = theme.font
        messageLabel.text = theme.stockCopyKey.stringValue.localization(stockValue: theme.stockCopyValue)
        brandLogoView.image = theme.logo
    }
}

private extension InnerButton {
    func addSubviews() {
        addSubview(brandLogoView)
        addSubview(messageLabel)
    }

    func setUpSubviews() {
        layer.cornerRadius = 8
        layer.borderWidth = 2.0
        layoutMargins = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)

        translatesAutoresizingMaskIntoConstraints = false
        brandLogoView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false

        brandLogoView.widthAnchor.constraint(equalTo: brandLogoView.heightAnchor).isActive = true
        brandLogoView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        brandLogoView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        brandLogoView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor).isActive = true
        brandLogoView.topAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.topAnchor).isActive = true
        brandLogoView.bottomAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.bottomAnchor).isActive = true
        brandLogoView.trailingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -16).isActive = true

        messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor).isActive = true

        messageWidthConstraint = messageLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: messageLabel.frame.width)
        messageWidthConstraint?.isActive = true
    }
}
