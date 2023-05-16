//
//  CustomTableViewCell.swift
//  airPilot
//
//  Created by Eryk Chrustek on 18/06/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

extension UIView {
    func setupDashedBorder(color: UIColor = Color.dashedBorder) {
        let shapeLayer = CAShapeLayer()
        let frameSize = frame.size
        let shapeRect = CGRect(x: 1, y: 0, width: frameSize.width - 5, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.name = "DashBorder"
        shapeLayer.position = CGPoint(x: (frameSize.width / 2) + 1, y: frameSize.height / 2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 1.5
        shapeLayer.lineJoin = .round
        shapeLayer.lineDashPattern = [4, 4]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 10).cgPath
        
        layer.masksToBounds = false
        layer.addSublayer(shapeLayer)
    }
}

class CustomTableViewCell: UITableViewCell {
    var id: Int = 0
    var identifier: String = ""
    let containerView = UIView()
    let borderLayer = CAShapeLayer()

//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupDashedBorder()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        setupDashedBorder()
//    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        containerView.setCellDeshBorder()
//    }
    
//    override func layoutSublayers(of layer: CALayer) {
//        super.layoutSublayers(of: layer)
//        containerView.setCellDeshBorder()
//        borderLayer.frame = .init(x: 0, y: 0, width: containerView.bounds.width - 20, height: containerView.bounds.height)
//
//        borderLayer.path = UIBezierPath(
//            roundedRect: .init(x: 0, y: 0, width: containerView.bounds.width - 20, height: containerView.bounds.height),
//            cornerRadius: Constants.cornerRadius).cgPath
//    }
//
//    func setupDashedBorder() {
//        borderLayer.strokeColor = Color.gray.withLightAlpha.cgColor
//        borderLayer.lineDashPattern = [2, 4]
//        borderLayer.fillColor = nil
//
//        containerView.layer.cornerRadius = Constants.cornerRadius
////        containerView.layer.masksToBounds = true
//        containerView.layer.addSublayer(borderLayer)
//    }
    
    func setupContainerView(verticalMargin: Margin = .small, horiztonalMargin: Margin = .normal) {
        selectionStyle = .none
        backgroundColor = Color.transparent
        
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: verticalMargin.top),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horiztonalMargin.leading),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: horiztonalMargin.trailing),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: verticalMargin.bottom)
        ])
    }
    
    func setupClearView() {
        selectionStyle = .none
        backgroundColor = Color.transparent
        
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Margin.small.top),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margin.normal.leading),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Margin.normal.trailing),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
