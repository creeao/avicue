//
//  TextField.swift
//  airPilot
//
//  Created by Eryk Chrustek on 29/06/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

final class TextField: UITextField {
    // MARK: External properties
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: .longAnimationTime) { [weak self] in
                self?.layer.borderColor = (self?.isHighlighted).isTrue ? Color.gray.cgColor : Color.gray.withThinAlpha.cgColor
            }
        }
    }
    
    // MARK: Private properties
    private var maxChars: Int = 10000
    
    // MARK: Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
}

// MARK: External methods
extension TextField {
    func setupPlaceholder(_ text: String, aligment: NSTextAlignment = .center, height: CGFloat = 50) {
        textAlignment = aligment
        attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [
                NSAttributedString.Key.foregroundColor: Color.gray.withLightAlpha
            ]
        )
        
        set(height: height)
    }
    
    func setupMaxChars(_ chars: Int) {
        maxChars = chars
        autocapitalizationType = .allCharacters
        addTarget(self, action: #selector(editingChanged(sender:)), for: .editingChanged)
    }
}

// MARK: Private methods
private extension TextField {
    func setupView() {
        layer.borderColor = Color.gray.withThinAlpha.cgColor
        layer.cornerRadius = Constants.cornerRadius
        layer.borderWidth = Constants.borderWidth
        
        textAlignment = .center
        textColor = Color.black
        font = Font.bigSemiBold
        
        let frame = CGRect(x: 0, y: 0, width: Margin.normal.space, height: frame.size.height)
        leftView = UIView(frame: frame)
        leftViewMode = .always
        
        rightView = UIView(frame: frame)
        rightViewMode = .always
        
        attributedPlaceholder = NSAttributedString(
            string: String.empty,
            attributes: [
                NSAttributedString.Key.foregroundColor: Color.gray.withThinAlpha
            ]
        )
    }
    
    @objc private func editingChanged(sender: UITextField) {
        if let text = sender.text, text.count >= maxChars {
            sender.text = String(text.dropLast(text.count - maxChars))
            return
        }
    }
}
