//
//  YotiButton.swift
//  YotiButtonSDK
//
//  Created by Casper Lee on 21/07/2017.
//  Copyright © 2017 Yoti Limited. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
public class YotiButton: UIButton {

    @IBInspectable public var useCaseID: String?
    var messageWidthConstraint: NSLayoutConstraint?

    lazy var brandLogoView: UIImageView = {
        let bundle = Bundle(for: type(of: self))
        let image = UIImage(named: "BrandLogo", in: bundle, compatibleWith: nil)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.sizeToFit()
        return imageView
    }()

    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Use Yoti"
        label.textAlignment = .center
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.bodyFont()
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
        styleSubviews()
    }

    public override func setTitle(_ title: String?, for state: UIControlState) {
        messageLabel.text = title
        messageLabel.sizeToFit()
        messageWidthConstraint?.constant = messageLabel.frame.width

    }

    public override func setTitleColor(_ color: UIColor?, for state: UIControlState) {
        if let color = color {
            messageLabel.textColor = color
        }
    }

    func addSubviews() {
        addSubview(brandLogoView)
        addSubview(messageLabel)
    }

    func styleSubviews() {
        // Button Styles
        backgroundColor = backgroundColor ?? .brandBlue
        layer.cornerRadius = 4
        layoutMargins = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        widthAnchor.constraint(equalTo: heightAnchor, multiplier: 230/48).isActive = true

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
}
