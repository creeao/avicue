//
//  Button.swift
//  airPilot
//
//  Created by Eryk Chrustek on 02/07/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

enum ButtonStyle {
    case enable
    case disable
    case bordered
    case dashed
    case borderedImage
    case filledImage
    case selector
    case image
    case whiteImage
}

class Button: UIButton {
    // MARK: External properties
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: .longAnimationTime) {
                switch self.style {
                case .enable:
                    self.backgroundColor = self.isHighlighted ? Color.salmon.withHardAlpha : Color.salmon
                case .disable:
                    self.backgroundColor = self.isHighlighted ? Color.gray : Color.gray.withLightAlpha
                case .bordered:
                    self.layer.borderColor = self.isHighlighted ? Color.gray.cgColor : Color.gray.withLightAlpha.cgColor
                case .dashed:
                    self.backgroundColor = self.isHighlighted ? Color.gray.withThinAlpha : Color.transparent
                case .borderedImage:
                    self.layer.borderColor = self.isHighlighted ? Color.gray.cgColor : Color.gray.withLightAlpha.cgColor
                case .filledImage:
                    self.backgroundColor = self.isHighlighted ? Color.gray.withRegularAlpha : Color.gray.withFrailAlpha
                case .whiteImage:
                    self.backgroundColor = self.isHighlighted ? Color.white.withLightAlpha : Color.white.withHardAlpha
                case .selector:
                    self.backgroundColor = self.isHighlighted ? Color.gray.withRegularAlpha : Color.gray.withFrailAlpha
                case .image:
                    self.backgroundColor = Color.transparent
                }
            }
        }
    }
    
    // MARK: Private properties
    private var style: ButtonStyle = .enable
    private var image: UIImage?
    private var border: (() -> Void)?
    
    // MARK: Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        border?()
    }
}

// MARK: External methods
extension Button {
    func setup(for buttonStyle: ButtonStyle, with title: String = "", and logo: UIImage? = nil) {
        setTitle(title, for: .normal)
        style = buttonStyle
        image = logo
        
        switch buttonStyle {
        case .enable:
            setupEnableStyle()
        case .disable:
            setupDisableStyle()
        case .bordered:
            setupBorderedStyle()
        case .dashed:
            setupDashedStyle()
        case .borderedImage:
            setupBorderedImageStyle()
        case .filledImage:
            setupFilledImageStyle()
        case .whiteImage:
            setupWhiteImageStyle()
        case .selector:
            setupSelectorStyle()
        case .image:
            setupImageStyle()
        }
    }
}

// MARK: Private methods
private extension Button {
    func setupView() {
        titleLabel?.font = Font.bigSemiBold
        set(height: 50)
    }
    
    func setupEnableStyle() {
        setTitleColor(Color.white, for: .normal)
        backgroundColor = Color.salmon
        layer.cornerRadius = Constants.cornerRadius
        addShadow()
    }
    
    func setupBorderedStyle() {
        setTitleColor(Color.gray, for: .normal)
        backgroundColor = Color.background
        
        layer.borderColor = Color.gray.withLightAlpha.cgColor
        layer.cornerRadius = Constants.cornerRadius
        layer.borderWidth = Constants.borderWidth
    }
    
    func setupDisableStyle() {
        setTitleColor(Color.white, for: .normal)
        backgroundColor = Color.gray
        layer.cornerRadius = Constants.cornerRadius
        layer.shadowColor = Color.shadow.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = .zero
        layer.shadowRadius = 20
    }
    
    func setupDashedStyle() {
        border = { [weak self] in
            self?.setupDashedBorder()
        }
//        layer.borderColor = Color.gray.withLightAlpha.cgColor
//        layer.borderWidth = Constants.borderWidth
        
        setTitleColor(Color.black, for: .normal)
        backgroundColor = Color.transparent
        layer.cornerRadius = Constants.cornerRadius
//        layer.borderColor = Color.transparent.cgColor
        
        let shapeLayer = CAShapeLayer()
        let shapeRect = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = Color.gray.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [2, 2]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: Constants.cornerRadius).cgPath
        layer.addSublayer(shapeLayer)
    }
    
    func setupBorderedImageStyle() {
        layer.borderColor = Color.gray.withLightAlpha.cgColor
        layer.cornerRadius = Constants.cornerRadius
        layer.borderWidth = Constants.borderWidth

        let imageView = UIImageView(image: image)
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.set(width: 25, height: 25)
        imageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: Margin.regular.top),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Margin.regular.bottom)
        ])
    }
    
    func setupFilledImageStyle() {
        backgroundColor = Color.gray.withFrailAlpha
        layer.cornerRadius = Constants.cornerRadius

        let imageView = UIImageView(image: image)
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: Margin.regular.top),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin.regular.leading),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Margin.regular.trailing),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Margin.regular.bottom)
        ])
    }
    
    func setupWhiteImageStyle() {
        backgroundColor = Color.white.withHardAlpha
        layer.cornerRadius = Constants.cornerRadius

        let imageView = UIImageView(image: image)
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: Margin.regular.top),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin.regular.leading),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Margin.regular.trailing),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Margin.regular.bottom)
        ])
    }
    
    func setupSelectorStyle() {
        setTitleColor(Color.gray, for: .normal)
        backgroundColor = Color.gray.withFrailAlpha
        layer.cornerRadius = Constants.cornerRadius
        addShadow()
    }
    
    func setupImageStyle() {
        backgroundColor = Color.transparent

        let imageView = UIImageView(image: image)
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        set(width: 20, height: 20)
    }
}

extension UIButton {
    func set(title: String) {
        setTitle(title, for: .normal)
    }
}

extension UIView {
    func addDashedBorder() {
        let color = UIColor.black.cgColor
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [6,3]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 4).cgPath
        
        layer.addSublayer(shapeLayer)
    }
}
