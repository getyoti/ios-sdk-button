//
// Copyright © 2021 Yoti Ltd. All rights reserved.
//

import UIKit

class SupportView: UIView {
    private var supportText = UILabel(frame: CGRect.zero)
    private var supportImage = UIImageView(image: Resource.loadImage(named: "support_image"))
    private var stackView: UIStackView!

    convenience init() {
        self.init(frame: CGRect.zero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initalize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initalize()
    }
}

private extension SupportView {
    func initalize() {
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

    func addContent(){
        supportText.font = Theme.yotiFont(ofSize: 12)
        supportText.text = "Works with:"
        supportText.textColor = Resource.color(named: "support_text")
    }
}
