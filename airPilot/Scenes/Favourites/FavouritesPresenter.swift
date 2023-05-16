//
//  FavouritesPresenter.swift
//  airPilot
//
//  Created by Eryk Chrustek on 27/07/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

protocol FavouritesPresentable {
    func presentContent(_ response: Favourites.Content.Response)
}

struct FavouritesPresenter {
    // MARK: External properties
    var viewController: FavouritesDisplayable?
}

// MARK: FavouritesPresentable
extension FavouritesPresenter: FavouritesPresentable {
    func presentContent(_ response: Favourites.Content.Response) {
        let viewModel = Favourites.Content.ViewModel(
            shopOffers: response.shopOffers)
        viewController?.displayContent(viewModel)
    }
}
