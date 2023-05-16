//
//  SpaceView.swift
//  airPilot
//
//  Created by Eryk Chrustek on 02/07/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

class SpaceView: UIView {
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
private extension SpaceView {
    func setupView() {
        set(height: 0)
    }
}
