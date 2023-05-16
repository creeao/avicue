//
//  LoaderView.swift
//  airPilot
//
//  Created by Eryk Chrustek on 11/09/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

final class LoaderView: UIControl {
    let leftSmallDot = UIImageView()
    let centerSmallDot = UIImageView()
    let rightSmallDot = UIImageView()
    
    let leftBigDot = UIImageView()
    let centerBigDot = UIImageView()
    let rightBigDot = UIImageView()
    
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

// MARK: Private methods
private extension LoaderView {
    func setupView() {
        accessibilityIdentifier = "Loader"
        
        setupLeftSmallDot()
        setupCenterSmallDot()
        setupRightSmallDot()
        
        setupLeftBigDot()
        setupCenterBigDot()
        setupRightBigDot()
        
        animate()
    }
    
    func setupLeftSmallDot() {
        addSubview(leftSmallDot)
        leftSmallDot.translatesAutoresizingMaskIntoConstraints = false
        leftSmallDot.image = Image.loaderSmallDot
        leftSmallDot.set(width: 6, height: 6)
        leftSmallDot.backgroundColor = Color.dark
        
        NSLayoutConstraint.activate([
            leftSmallDot.topAnchor.constraint(equalTo: topAnchor, constant: Margin.mini.top),
            leftSmallDot.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin.mini.leading),
            leftSmallDot.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Margin.tiny.bottom)
        ])
    }
    
    func setupCenterSmallDot() {
        addSubview(centerSmallDot)
        centerSmallDot.translatesAutoresizingMaskIntoConstraints = false
        centerSmallDot.image = Image.loaderSmallDot
        centerSmallDot.set(width: 6, height: 6)
        
        NSLayoutConstraint.activate([
            centerSmallDot.topAnchor.constraint(equalTo: topAnchor, constant: Margin.mini.top),
            centerSmallDot.leadingAnchor.constraint(equalTo: leftSmallDot.trailingAnchor, constant: Margin.small.leading),
            centerSmallDot.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Margin.tiny.bottom)
        ])
    }
    
    func setupRightSmallDot() {
        addSubview(rightSmallDot)
        rightSmallDot.translatesAutoresizingMaskIntoConstraints = false
        rightSmallDot.image = Image.loaderSmallDot
        rightSmallDot.set(width: 6, height: 6)
        
        NSLayoutConstraint.activate([
            rightSmallDot.topAnchor.constraint(equalTo: topAnchor, constant: Margin.mini.top),
            rightSmallDot.leadingAnchor.constraint(equalTo: centerSmallDot.trailingAnchor, constant: Margin.small.leading),
            rightSmallDot.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Margin.tiny.trailing),
            rightSmallDot.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Margin.tiny.bottom)
        ])
    }
    
    func setupLeftBigDot() {
        addSubview(leftBigDot)
        leftBigDot.translatesAutoresizingMaskIntoConstraints = false
        leftBigDot.alpha = Constants.Alpha.zero
        leftBigDot.image = Image.loaderBigDot
        leftBigDot.set(width: 10, height: 10)
        
        NSLayoutConstraint.activate([
            leftBigDot.topAnchor.constraint(equalTo: topAnchor, constant: Margin.tiny.top),
            leftBigDot.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin.tiny.leading),
            leftBigDot.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupCenterBigDot() {
        addSubview(centerBigDot)
        centerBigDot.translatesAutoresizingMaskIntoConstraints = false
        centerBigDot.alpha = Constants.Alpha.zero
        centerBigDot.image = Image.loaderBigDot
        centerBigDot.set(width: 10, height: 10)
        
        NSLayoutConstraint.activate([
            centerBigDot.topAnchor.constraint(equalTo: topAnchor, constant: Margin.tiny.top),
            centerBigDot.leadingAnchor.constraint(equalTo: leftBigDot.trailingAnchor, constant: Margin.mini.leading),
            centerBigDot.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupRightBigDot() {
        addSubview(rightBigDot)
        rightBigDot.translatesAutoresizingMaskIntoConstraints = false
        rightBigDot.alpha = Constants.Alpha.zero
        rightBigDot.image = Image.loaderBigDot
        rightBigDot.set(width: 10, height: 10)
        rightBigDot.backgroundColor = Color.dark
        
        NSLayoutConstraint.activate([
            rightBigDot.topAnchor.constraint(equalTo: topAnchor, constant: Margin.tiny.top),
            rightBigDot.leadingAnchor.constraint(equalTo: centerBigDot.trailingAnchor, constant: Margin.mini.leading),
            rightBigDot.trailingAnchor.constraint(equalTo: trailingAnchor),
            rightBigDot.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupLeftDot(isBigger: Bool) {
        self.leftSmallDot.alpha = isBigger ? Constants.Alpha.zero : Constants.Alpha.full
        self.leftBigDot.alpha = isBigger ? Constants.Alpha.full : Constants.Alpha.zero
    }
    
    func setupCenterDot(isBigger: Bool) {
        self.centerSmallDot.alpha = isBigger ? Constants.Alpha.zero : Constants.Alpha.full
        self.centerBigDot.alpha = isBigger ? Constants.Alpha.full : Constants.Alpha.zero
    }
    
    func setupRightDot(isBigger: Bool) {
        self.rightSmallDot.alpha = isBigger ? Constants.Alpha.zero : Constants.Alpha.full
        self.rightBigDot.alpha = isBigger ? Constants.Alpha.full : Constants.Alpha.zero
    }

    func animate() {
//        UIView.animate(withDuration: 0.2, delay: 0.1, options: .preferredFramesPerSecond60, animations: {
//            self.setupRightDot(isBigger: false)
//            self.setupLeftDot(isBigger: true)
//        }, completion: { _ in
//            UIView.animate(withDuration: 0.2, delay: 0.1, options: .preferredFramesPerSecond60, animations: {
//                self.setupLeftDot(isBigger: false)
//                self.setupCenterDot(isBigger: true)
//            }, completion: { _ in
//                UIView.animate(withDuration: 0.2, delay: 0.1, options: .preferredFramesPerSecond60, animations: {
//                    self.setupCenterDot(isBigger: false)
//                    self.setupRightDot(isBigger: true)
//                }, completion: { _ in
//                    self.animate()
//                })
//            })
//        })
    }
}
