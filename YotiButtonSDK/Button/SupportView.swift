//
// Copyright © 2021 Yoti Ltd. All rights reserved.
//

import UIKit

class SupportView: UIView {
    static let height: CGFloat = 28
    private var supportText = UILabel(frame: CGRect.zero)
    private var supportImage = UIImageView(image: Resource.loadImage(named: "support_image"))
    private var stackView: UIStackView!

    convenience init() {
        self.init(frame: CGRect.zero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }
}

private extension SupportView {
    func setUpView() {
        addSubviews()
        addContent()
    }

    func addSubviews() {
        stackView = UIStackView(arrangedSubviews: [supportText, supportImage])
        addSubview(stackView)
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        translatesAutoresizingMaskIntoConstraints = false
    }

    func addContent() {
        supportText.font = Theme.yotiFont(ofSize: 12)
        supportText.text = LocalizationKey.support.stringValue.localization(stockValue: "Works with:")
        supportText.textColor = Resource.color(named: "support_text")
    }
}

private extension SupportView {
    enum LocalizationKey: String, CodingKey {
        case support = "yoti.sdk.support_info.text"
    }
}
