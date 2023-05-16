//
//  TabItem.swift
//  airPilot
//
//  Created by Eryk Chrustek on 19/06/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

enum TabItem: Int, CaseIterable {
    case home
    case jobOffers
    case aviationOffers
    case shopOffers
    case discountsOffers
    
//    case messages
//    case search
//    case profile
}

extension TabItem {
    func getViewController() -> UIViewController {
        switch self {
        case .home:
            return Home.createScene()
        case .jobOffers:
            return JobOffers.createScene()
        case .aviationOffers:
            return AviationOffers.createScene()
        case .shopOffers:
            return ShopOffers.createScene()
        case .discountsOffers:
            return DiscountOffers.createScene()
        }
    }
    
    func getImage(isActive: Bool) -> UIImage? {
        switch self {
        case .home:
            return isActive ? Image.TabBar.homeActive : Image.TabBar.homeInactive
        case .jobOffers:
            return isActive ? Image.TabBar.jobOffersActive : Image.TabBar.jobOffersInactive
        case .aviationOffers:
            return isActive ? Image.TabBar.aviationActive : Image.TabBar.aviationInactive
        case .shopOffers:
            return isActive ? Image.TabBar.shopActive : Image.TabBar.shopInactive
        case .discountsOffers:
            return isActive ? Image.TabBar.discountsActive : Image.TabBar.discountsInactive
        }
    }
}
