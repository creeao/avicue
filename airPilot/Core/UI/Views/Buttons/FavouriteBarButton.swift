//
//  FavouriteBarButton.swift
//  airPilot
//
//  Created by Eryk Chrustek on 18/08/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

protocol FavouriteBarButtonDelegate: AnyObject {
    func setFavourite()
    func setUnfavourite()
}

class FavouriteBarButton: UIBarButtonItem {
    // MARK: External properties
    weak var delegate: FavouriteBarButtonDelegate?
    
    // MARK: Private properties
    private var isFavourite: Bool = false
}

// MARK: External methods
extension FavouriteBarButton {
    func setupView() {
        image = Image.heartBordered
        action = #selector(changeFavouriteState)
    }
    
    func checkState() -> Bool {
        return isFavourite
    }
    
    func setFavourite() {
        isFavourite = true
        image = Image.heartActive
        delegate?.setFavourite()
    }
    
    func setUnfavourite() {
        isFavourite = false
        image = Image.heartBordered
        delegate?.setUnfavourite()
    }
}

// MARK: Events
private extension FavouriteBarButton {
    @objc func changeFavouriteState() {
        isFavourite ? setUnfavourite() : setFavourite()
    }
}
