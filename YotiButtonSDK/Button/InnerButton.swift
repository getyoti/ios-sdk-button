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

    private static let margins = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
    private static let brandLogoWidth: CGFloat = 20
    private var currentTheme: Theme = .default
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
        self.init(frame: CGRect(x: 0, y: 0, width: 300, height: 44))
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
        setupSubviews()
        apply(theme: currentTheme)
    }

    override func setTitle(_ title: String?, for state: UIControl.State) {
        let padding = InnerButton.margins.left + InnerButton.margins.right + InnerButton.brandLogoWidth
        messageLabel.text = title
        messageLabel.preferredMaxLayoutWidth = frame.offsetBy(dx: -padding, dy: 0).width
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

    func setupSubviews() {
        layer.cornerRadius = 8
        layer.borderWidth = 2.0
        layoutMargins = InnerButton.margins

        brandLogoView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false

        brandLogoView.widthAnchor.constraint(equalTo: brandLogoView.heightAnchor).isActive = true
        brandLogoView.heightAnchor.constraint(equalToConstant: InnerButton.brandLogoWidth).isActive = true
        brandLogoView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        brandLogoView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor).isActive = true
        brandLogoView.trailingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -16).isActive = true

        messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor).isActive = true

        messageWidthConstraint = messageLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: messageLabel.frame.width)
        messageWidthConstraint?.isActive = true
    }
}
