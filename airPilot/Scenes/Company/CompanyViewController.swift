//
//  CompanyViewController.swift
//  airPilot
//
//  Created by Eryk Chrustek on 25/08/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

protocol CompanyDisplayable {
    func displayContent(_ viewModel: Company.Content.ViewModel)
}

final class CompanyViewController: ViewController {
    // MARK: External properties
    var interactor: CompanyLogic?
    
    // MARK: Private properties
    private var posts: [PostModel] = []
    private var jobOffers: [JobOfferModel] = []
    private var shopOffers: [ShopOfferModel] = []
    private var aboutUsDescription: String = String.empty
    private var lastCategory: String = String.empty
    private var companyId: Int = .zero
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getContent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showNavigationBar()
    }
    
    override func tapRightButton() {
        editCompanyProfile()
    }
}

// MARK: CompanyDisplayable
extension CompanyViewController: CompanyDisplayable {
    func displayContent(_ viewModel: Company.Content.ViewModel) {
        removeCells()
        companyId = viewModel.profile.company.id
        jobOffers = viewModel.profile.jobOffers ?? []
        shopOffers = viewModel.profile.shopOffers ?? []
        aboutUsDescription = viewModel.profile.description.orEmpty
        
        setupCell(with: viewModel.profile)
        setupCategoriesCell()
        hideLoader(reloadData: true)
    }
}

// MARK: JobOfferCellDelegate
extension CompanyViewController: JobOfferCellDelegate {
    func tapJobOfferCell(id: Int) {
        let input = JobOffer.Input(id: id)
        let jobOffer = JobOffer.createScene(input)
        push(jobOffer)
    }
}

// MARK: ShopOfferCellDelegate
extension CompanyViewController: ShopOfferCellDelegate {
    func tapFavouriteButton(offerId: Int, isFavourite: Bool) {
        interactor?.tapFavouriteButton(.init(offerId: offerId, isFavourite: isFavourite))
    }
    
    func tapShopOfferCell(id: Int) {
        let input = ShopOffer.Input(id: id)
        let shopOffer = ShopOffer.createScene(input)
        push(shopOffer)
    }
}

// MARK: CompanyProfileCellDelegate
extension CompanyViewController: CompanyProfileCellDelegate {
    func tapActionOnCompanyButton(actionOnCompany: ActionOnCompanyType) {
        interactor?.actionOnCompany(.init(actionOnCompany: actionOnCompany))
    }
    
    func tapWebsiteButton(url: String) {
        if let url = URL(string: url) {
            UIApplication.shared.open(url)
        }
    }
}

// MARK: CategoriesSliderCellDelegate
extension CompanyViewController: CategoriesSliderCellDelegate {
    func tapCategory(_ id: String) {
        switch lastCategory {
        case Company.Categories.posts.rawValue:
            removeCells(with: ActivityCell.self)
        case Company.Categories.jobOffers.rawValue:
            removeCells(with: JobOfferCell.self)
        case Company.Categories.shopOffers.rawValue:
            removeCells(with: ShopOfferCell.self)
        case Company.Categories.services.rawValue:
            break
        case Company.Categories.gallery.rawValue:
            break
        case Company.Categories.aboutUs.rawValue:
            removeCells(with: DescriptionCell.self)
        default:
            break
        }
        
        switch id {
        case Company.Categories.posts.rawValue:
            posts.forEach {
                let cell = ActivityCell()
                cell.setup(with: .init(id: $0.id, type: .post, post: $0))
//                cell.delegate = self
                appendCell(cell)
            }
        case Company.Categories.jobOffers.rawValue:
            setupCells(with: jobOffers)
        case Company.Categories.shopOffers.rawValue:
            setupCells(with: shopOffers)
        case Company.Categories.services.rawValue:
            break
        case Company.Categories.gallery.rawValue:
            break
        case Company.Categories.aboutUs.rawValue:
            setupCell(with: aboutUsDescription)
        default:
            break
        }
        
        lastCategory = id
        hideLoader(reloadData: true)
    }
}

// MARK: External methods
extension CompanyViewController {
    func getContent() {
        displayLoader()
        interactor?.getContent(.init())
    }
    
    func editCompanyProfile() {
        let input = EditCompanyProfile.Input(companyId: companyId)
        let editCompanyProfile = EditCompanyProfile.createScene(input)
        push(editCompanyProfile)
    }
}

// MARK: Private methods
private extension CompanyViewController {
    func setupView() {
        setupBackButton()
        setupRightButton(image: Image.editButton)
        setupTableView(for: self)
    }
    
    func setupCell(with company: CompanyProfileModel) {
        let cell = CompanyProfileCell()
        cell.setup(with: company)
        cell.delegate = self
        appendCell(cell)
    }
    
    func setupCategoriesCell() {
        let categories: [CategoryViewModel] = Company.Categories.allCases.map {
            return .init(id: $0.rawValue, name: $0.getName())
        }
        
        let cell = CategoriesSliderCell()
        cell.delegate = self
        cell.setup(categories)
        appendCell(cell)
    }
    
    func setupCell(with details: [InformationModel]) {
        let cell = InformationsCell()
        cell.setup(with: details)
        appendCell(cell)
    }
    
    func setupCell(with description: String?) {
        if let description, description.isNotEmpty {
            let cell = DescriptionCell()
            cell.setup(with: description)
            appendCell(cell)
        }
    }
    
    func setupCells(with jobOffers: [JobOfferModel]) {
        jobOffers.forEach {
            let cell = JobOfferCell()
            cell.setup(with: $0, inCompany: true)
            cell.delegate = self
            appendCell(cell)
        }
    }
    
    func setupCells(with shopOffers: [ShopOfferModel]) {
        shopOffers.forEach {
            let cell = ShopOfferCell()
            cell.setup(with: $0, inCompany: true)
            cell.delegate = self
            appendCell(cell)
        }
    }
}
