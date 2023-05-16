//
//  ShopOfferCreatorViewController.swift
//  airPilot
//
//  Created by Eryk Chrustek on 17/11/2022.
//  Copyright © 2022 ACC. All rights reserved.
//

import UIKit
import PhotosUI

protocol ShopOfferCreatorDisplayable {
    func displayContent(_ viewModel: ShopOfferCreator.Content.ViewModel)
    func displayResult(_ response: ShopOfferCreator.Result.ViewModel)
}

final class ShopOfferCreatorViewController: ViewController {
    // MARK: External properties
    var interactor: ShopOfferCreatorLogic?
    
    // MARK: Private properties
    private var imagesPickerConfiguration: PHPickerConfiguration?
    private var imagesPicker: PHPickerViewController?
    
    private let pickerView = UIPickerView()
    private var offerType: ShopOfferType = .sale
    
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
    
    override func setupActionButton() {
        createOffer()
    }
}

// MARK: ShopOfferCreatorDisplayable
extension ShopOfferCreatorViewController: ShopOfferCreatorDisplayable {
    func displayContent(_ viewModel: ShopOfferCreator.Content.ViewModel) {
        hideLoader(reloadData: true)
    }
    
    func displayResult(_ response: ShopOfferCreator.Result.ViewModel) {
        let input = ResultScreen.Input(result: response.result)
        let result = ResultScreen.createScene(input)
        push(result)
        
        result.backCompletion = { [weak self] in
            (self?.getViewControllerFromTabBar(type: ShopOffersViewController.self) as? ShopOffersViewController)?.getContent()
            self?.pop(to: TabBarController.self)
        }
    }
}

// MARK: TextFieldTitleLogoButtonCellDelegate
extension ShopOfferCreatorViewController: TextFieldTitleLogoButtonCellDelegate {
    func tapView() {
        let companies = Companies.createScene()
        push(companies)
    }
}

// MARK: TextFieldTitleButtonCellDelegate
extension ShopOfferCreatorViewController: TextFieldTitleButtonCellDelegate {
    func tapTextFieldTitleButtonCell() {
        let categories = SelectCategory.createScene(.init(type: .shop, category: nil))
        push(categories)
    }
}

// MARK: PriceCellDelegate
extension ShopOfferCreatorViewController: PriceTypeCellDelegate {
    func tapCurrencyView() {
        let currencyList = CurrencyList.createScene()
        push(currencyList)
    }
    
    func tapTypeButton() {
        pickerView.isHidden = false
        
        UIView.animate(withDuration: .shortAnimationTime) { [weak self] in
            self?.pickerView.alpha = Constants.Alpha.full
        }
    }
}

// MARK: PriceCellDelegate
extension ShopOfferCreatorViewController: ImagesPickerCellDelegate {
    func addPhotos() {
        showPicker()
    }
}

// MARK: UIImagePickerControllerDelegate
extension ShopOfferCreatorViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        imagesPicker?.dismiss(animated: true)
        
        results.forEach { result in
            if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                result.itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                    DispatchQueue.main.async { [weak self] in
                        if let image = image as? UIImage {
                            let cell = self?.getCell(Tag.imagesPickerCell) as? ImagesPickerCell
                            cell?.appendPhotos([image])
                        }
                    }
                }
            }
        }
    }
}

// MARK: UIPickerViewDelegate, UIPickerViewDataSource
extension ShopOfferCreatorViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ShopOfferType.allCases.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ShopOfferType.allCases[row].title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        offerType = ShopOfferType.allCases[row]
        let priceTypeCell = getCell(Tag.priceTypeCell) as? PriceTypeCell
        priceTypeCell?.select(offerType)
        
        UIView.animate(withDuration: .shortAnimationTime) { [weak self] in
            self?.pickerView.alpha = Constants.Alpha.zero
        } completion: { [weak self] _ in
            self?.pickerView.isHidden = true
        }
    }
}

// MARK: External methods
extension ShopOfferCreatorViewController {
    func getContent() {
        displayLoader()
        interactor?.getContent(.init())
    }
    
    func selectCompany(_ model: CompanyModel) {
        let companyCell = getCell(Tag.companyCell) as? TextFieldTitleLogoButtonCell
        companyCell?.select(with: model)
    }
    
    func selectCategory(_ model: Category) {
        let categoryCell = getCell(Tag.categoryCell) as? TextFieldTitleButtonCell
        categoryCell?.select(with: model)
    }
    
    func selectCurrency(_ currency: Currency) {
        let priceCell = getCell(Tag.priceTypeCell) as? PriceTypeCell
        priceCell?.select(currency)
    }
    
    func createOffer() {
        let nameCell = getCell(Tag.nameCell) as? TextFieldTitleCell
        let companyCell = getCell(Tag.companyCell) as? TextFieldTitleLogoButtonCell
        let categoryCell = getCell(Tag.categoryCell) as? TextFieldTitleButtonCell
        let priceTypeCell = getCell(Tag.priceTypeCell) as? PriceTypeCell
        let descriptionCell = getCell(Tag.descriptionCell) as? TextViewTitleCell
        let imagesCell = getCell(Tag.imagesPickerCell) as? ImagesPickerCell
       
        interactor?.createOffer(.init(
            name: nameCell?.getText(),
            category: (categoryCell?.id).orZero,
            type: offerType,
            price: priceTypeCell?.getPrice(),
            currency: priceTypeCell?.getCurrency(),
            text: (descriptionCell?.getText()).orEmpty,
            assignedTo: companyCell?.id,
            images: imagesCell?.getImages()))
    }
}

// MARK: Private methods
private extension ShopOfferCreatorViewController {
    func setupView() {
        setupBackButton()
        setupTableView(for: self)
        
        setupImagesPickerCell()
        setupNameCell()
        setupCompanyCell()
        setupCategoryCell()
        setupPriceTypeCell()
        setupDescriptionCell()
        setupButton("Create offer")
        setupPickerView()
    }
 
    func setupImagesPickerCell() {
        let cell = ImagesPickerCell()
        cell.identifier = Tag.imagesPickerCell
        cell.delegate = self
        appendCell(cell)
    }
    
    func setupNameCell() {
        let cell = TextFieldTitleCell()
        cell.setup(with: "Name", and: "e.g. Cesna 172-D4")
        cell.identifier = Tag.nameCell
        appendCell(cell)
    }
    
    func setupCompanyCell() {
        let cell = TextFieldTitleLogoButtonCell()
        cell.setup(with: "Category", and: "Select company")
        cell.identifier = Tag.companyCell
        cell.delegate = self
        appendCell(cell)
    }
    
    func setupCategoryCell() {
        let cell = TextFieldTitleButtonCell()
        cell.setup(with: "Category", and: "Select product category", withGesture: true)
        cell.identifier = Tag.categoryCell
        cell.delegate = self
        appendCell(cell)
    }
    
//    func setupTypeCell() {
//        let cell = TextFieldTitleButtonCell()
//        cell.setup(with: "Type", and: "Select product type")
//        cell.identifier = Tag.typeCell
//        cell.delegate = self
//        appendCell(cell)
//    }
    
    func setupPriceTypeCell() {
        let cell = PriceTypeCell()
        cell.setup(with: "Price and type", and: .usd)
        cell.identifier = Tag.priceTypeCell
        cell.delegate = self
        appendCell(cell)
    }
    
    func setupDescriptionCell() {
        let cell = TextViewTitleCell()
        cell.identifier = Tag.descriptionCell
        cell.setup(with: "Description")
        appendCell(cell)
    }
    
    func setupPickerView() {
        view.addSubview(pickerView)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = Color.white
        pickerView.addShadow()
        pickerView.layer.cornerRadius = Constants.cornerRadius
        pickerView.isHidden = true
        pickerView.alpha = Constants.Alpha.zero
                
        NSLayoutConstraint.activate([
            pickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.normal.leading),
            pickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Margin.normal.trailing),
            pickerView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: Margin.small.bottom),
            pickerView.heightAnchor.constraint(equalToConstant: 140)
        ])
    }
    
    func showPicker() {
        imagesPickerConfiguration = PHPickerConfiguration()
        imagesPickerConfiguration?.filter = .images
        imagesPickerConfiguration?.selectionLimit = 8
        
        guard let imagesPickerConfiguration else { return }
        imagesPicker = PHPickerViewController(configuration: imagesPickerConfiguration)
        imagesPicker?.delegate = self
        
        guard let imagesPicker else { return }
        present(imagesPicker, animated: true)
    }
}

// MARK: Tags
private enum Tag {
    static let imagesPickerCell = "imagesPickerCell"
    static let nameCell = "nameCell"
    static let companyCell = "companyCell"
    static let categoryCell = "categoryCell"
    static let typeCell = "categoryCell"
    static let priceTypeCell = "priceTypeCell"
    static let descriptionCell = "descriptionCell"
}
