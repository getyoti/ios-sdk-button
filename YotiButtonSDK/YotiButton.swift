//
// Copyright © 2017 Yoti Limited. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
public class YotiButton: UIButton {
    struct Colors {
        let background: UIColor
        let foreground: UIColor
        let border: UIColor
    }

    @IBInspectable public var useCaseID: String?
    public var theme = Theme.yoti
    var messageWidthConstraint: NSLayoutConstraint?

    lazy var brandLogoView: UIImageView = {
        let image = theme.logo
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.sizeToFit()
        return imageView
    }()

    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Use Yoti"
        label.textAlignment = .center
        label.textColor = theme.colors(for: state).foreground
        label.adjustsFontSizeToFitWidth = true
        label.font = theme.font
        label.baselineAdjustment = .alignCenters
        label.sizeToFit()
        return label
    }()

    public convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 230, height: 48))
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
        addSubviews()
    }

    public override func layoutSubviews() {
        setupSubviews()
        applyTheme()
    }

    public override func setTitle(_ title: String?, for state: UIControl.State) {
        messageLabel.text = title
        messageLabel.sizeToFit()
        messageWidthConstraint?.constant = messageLabel.frame.width
    }

    public override func setTitleColor(_ color: UIColor?, for state: UIControl.State) {
        if let color = color {
            messageLabel.textColor = color
        }
    }

    func addSubviews() {
        addSubview(brandLogoView)
        addSubview(messageLabel)
    }

    func setupSubviews() {
        // Button Styles
        layer.cornerRadius = 8
        layer.borderWidth = 2.0
        layoutMargins = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 12)
        widthAnchor.constraint(equalTo: heightAnchor, multiplier: 300/44).isActive = true

        brandLogoView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false

        brandLogoView.widthAnchor.constraint(equalTo: brandLogoView.heightAnchor).isActive = true
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

    func applyTheme() {
        backgroundColor = theme.colors(for: state).background
        layer.borderColor = theme.colors(for: state).border.cgColor
        messageLabel.textColor = theme.colors(for: state).foreground
        messageLabel.font = theme.font
        messageLabel.text = theme.stockCopy
        brandLogoView.image = theme.logo
    }
}
