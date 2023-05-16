//
//  TextView.swift
//  airPilot
//
//  Created by Eryk Chrustek on 22/11/2022.
//

import UIKit

final class TextView: UITextView {
    // MARK: Life cycle
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
}

// MARK: Private methods
private extension TextView {
    func setupView() {
        layer.borderColor = Color.gray.withThinAlpha.cgColor
        layer.cornerRadius = Constants.cornerRadius
        layer.borderWidth = Constants.borderWidth
        backgroundColor = Color.transparent
        textColor = Color.black
        font = Font.largeRegular
        
        contentInsetAdjustmentBehavior = .automatic
        showsVerticalScrollIndicator = false
        textContainerInset = Insets.setup(margin: Margin.medium.space)
    }
}
