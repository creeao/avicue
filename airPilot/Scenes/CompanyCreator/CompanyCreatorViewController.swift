//
//  CompanyCreatorViewController.swift
//  airPilot
//
//  Created by Eryk Chrustek on 28/12/2022.
//  Copyright © 2022 ACC. All rights reserved.
//

import UIKit

protocol CompanyCreatorDisplayable {
    func displayContent(_ viewModel: CompanyCreator.Content.ViewModel)
    func displayResult(_ response: CompanyCreator.Result.ViewModel)
}

final class CompanyCreatorViewController: ViewController {
    // MARK: External properties
    var interactor: CompanyCreatorLogic?
    
    // MARK: Private properties
    private let imagePicker = UIImagePickerController()
    private var pickerType: CompanyCreator.PickerType = .avatar
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getContent()
    }
    
    override func setupActionButton() {
        createCompany()
    }
}

// MARK: CompanyCreatorDisplayable
extension CompanyCreatorViewController: CompanyCreatorDisplayable {
    func displayContent(_ viewModel: CompanyCreator.Content.ViewModel) {
        hideLoader(reloadData: true)
    }
    
    func displayResult(_ response: CompanyCreator.Result.ViewModel) {
        let input = ResultScreen.Input(result: response.result)
        let result = ResultScreen.createScene(input)
        push(result)
        
        result.backCompletion = { [weak self] in
            (self?.getViewController(type: MenuViewController.self) as? MenuViewController)?.getContent()
            self?.pop(to: MenuViewController.self)
        }
    }
}

// MARK: AvatarBackgroundPickerCellDelegate
extension CompanyCreatorViewController: AvatarBackgroundPickerCellDelegate {
    func addAvatar() {
        pickerType = .avatar
        present(imagePicker, animated: true)
    }
    
    func addBackground() {
        pickerType = .background
        present(imagePicker, animated: true)
    }
}

// MARK: UIImagePickerControllerDelegate
extension CompanyCreatorViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true)
        imagePicker.allowsEditing = false
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        imagePicker.dismiss(animated: true)
        
        switch pickerType {
        case .avatar:
            if let image = info[.editedImage] as? UIImage {
                let cell = getCell(Tag.avatarBackgroundPickerCell) as? AvatarBackgroundPickerCell
                cell?.setAvatar(image: image)
//                interactor?.changeAvatar(.init(image: image))
            }
        case .background:
            if let image = info[.editedImage] as? UIImage {
                let cell = getCell(Tag.avatarBackgroundPickerCell) as? AvatarBackgroundPickerCell
                cell?.setBackground(image: image)
//                interactor?.changeBackground(.init(image: image))
            }
        }
    }
}

// MARK: External methods
extension CompanyCreatorViewController {
    func getContent() {
        displayLoader()
        interactor?.getContent(.init())
    }
    
    func createCompany() {
        let nameCell = getCell(Tag.nameCell) as? TextFieldTitleCell
        let headlineCell = getCell(Tag.headlineCell) as? TextFieldTitleCell
        let websiteCell = getCell(Tag.websiteCell) as? TextFieldTitleCell
        
        interactor?.createCompany(.init(
            name: (nameCell?.getText()).orEmpty,
            headline: headlineCell?.getText(),
            website: websiteCell?.getText()))
    }
}

// MARK: Private methods
private extension CompanyCreatorViewController {
    func setupView() {
        setupBackButton()
        setupTableView(for: self)
        setupTitleCell()
        setupAvatarBackgroundPickerCell()
        setupNameCell()
        setupHeadlineCell()
        setupWebsiteCell()
        setupImagePicker()
        setupButton("Create company")
    }
    
    func setupTitleCell() {
        let cell = LargeTitleCell()
        cell.setup(with: "Create company", toLeft: true)
        appendCell(cell)
    }
    
    func setupAvatarBackgroundPickerCell() {
        let cell = AvatarBackgroundPickerCell()
        cell.identifier = Tag.avatarBackgroundPickerCell
        cell.delegate = self
        appendCell(cell)
    }
    
    func setupNameCell() {
        let cell = TextFieldTitleCell()
        cell.setup(with: "Name", and: "e.g. Lufthansa")
        cell.identifier = Tag.nameCell
        appendCell(cell)
    }
    
    func setupHeadlineCell() {
        let cell = TextFieldTitleCell()
        cell.setup(with: "Headline", and: "e.g. Airlines and aviation")
        cell.identifier = Tag.headlineCell
        appendCell(cell)
    }
    
    func setupWebsiteCell() {
        let cell = TextFieldTitleCell()
        cell.setup(with: "Website", and: "e.g. https://www.lufthansa.com/ ")
        cell.identifier = Tag.websiteCell
        appendCell(cell)
    }
    
    func setupImagePicker() {
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
    }
}

// MARK: Tags
private enum Tag {
    static let avatarBackgroundPickerCell = "avatarBackgroundPickerCell"
    static let nameCell = "nameCell"
    static let headlineCell = "headlineCell"
    static let websiteCell = "websiteCell"
    static let companyCategoryCell = "companyCategoryCell"
    static let sizeOfOrganizationCell = "sizeOfOrganizationCell"
}
