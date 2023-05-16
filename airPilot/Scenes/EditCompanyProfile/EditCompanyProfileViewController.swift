//
//  EditCompanyProfileViewController.swift
//  airPilot
//
//  Created by Eryk Chrustek on 13/02/2023.
//  Copyright © 2023 ACC. All rights reserved.
//

import UIKit

protocol EditCompanyProfileDisplayable {
    func displayContent(_ viewModel: EditCompanyProfile.Content.ViewModel)
    func displayResult(_ response: EditCompanyProfile.Result.ViewModel)
}

final class EditCompanyProfileViewController: ViewController {
    // MARK: External properties
    var interactor: EditCompanyProfileLogic?
    private let imagePicker = UIImagePickerController()
    private var pickerType: EditCompanyProfile.PickerType = .avatar
    
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
        saveChanges()
    }
}

// MARK: EditCompanyProfileDisplayable
extension EditCompanyProfileViewController: EditCompanyProfileDisplayable {
    func displayContent(_ viewModel: EditCompanyProfile.Content.ViewModel) {
        setupCells(with: viewModel)
        hideLoader(reloadData: true)
    }
    
    func displayResult(_ response: EditCompanyProfile.Result.ViewModel) {
        let input = ResultScreen.Input(result: response.result)
        let result = ResultScreen.createScene(input)
        push(result)
        
        result.backCompletion = { [weak self] in
            (self?.getViewController(type: CompanyViewController.self) as? CompanyViewController)?.getContent()
            self?.pop(to: CompanyViewController.self)
        }
    }
}

// MARK: AvatarBackgroundPickerCellDelegate
extension EditCompanyProfileViewController: AvatarBackgroundPickerCellDelegate {
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
extension EditCompanyProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
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
                interactor?.changeLogo(.init(image: image))
            }
        case .background:
            if let image = info[.editedImage] as? UIImage {
                let cell = getCell(Tag.avatarBackgroundPickerCell) as? AvatarBackgroundPickerCell
                cell?.setBackground(image: image)
                interactor?.changeBackground(.init(image: image))
            }
        }
    }
}

// MARK: External methods
extension EditCompanyProfileViewController {
    func getContent() {
        displayLoader()
        interactor?.getContent(.init())
    }
    
    func saveChanges() {
        let nameCell = getCell(Tag.nameCell) as? TextFieldTitleCell
        let headlineCell = getCell(Tag.headlineCell) as? TextFieldTitleCell
        let websiteCell = getCell(Tag.websiteCell) as? TextFieldTitleCell
        
        interactor?.saveChanges(.init(
            name: (nameCell?.getText()).orEmpty,
            headline: headlineCell?.getText(),
            website: websiteCell?.getText())
        )
    }
}

// MARK: Private methods
private extension EditCompanyProfileViewController {
    func setupView() {
        setupBackButton()
        setupTableView(for: self)
        
        setupTitleCell()
        setupAvatarBackgroundPickerCell()
        setupNameCell()
        setupHeadlineCell()
        setupWebsiteCell()
        setupImagePicker()
        setupButton("Save changes")
    }
    
    func setupTitleCell() {
        let cell = LargeTitleCell()
        cell.setup(with: "Edit profile", toLeft: true)
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
        cell.setup(with: "Name", and: "Name")
        cell.identifier = Tag.nameCell
        appendCell(cell)
    }
    
    func setupHeadlineCell() {
        let cell = TextFieldTitleCell()
        cell.setup(with: "Headline", and: "Headline")
        cell.identifier = Tag.headlineCell
        appendCell(cell)
    }
    
    func setupWebsiteCell() {
        let cell = TextFieldTitleCell()
        cell.setup(with: "Website", and: "Website")
        cell.identifier = Tag.websiteCell
        appendCell(cell)
    }
    
    func setupImagePicker() {
        imagePicker.delegate = self
//        imagePicker.mediaTypes = ["public.image", "public.movie"]
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
    }
    
    func setupCells(with viewModel: EditCompanyProfile.Content.ViewModel) {
        let pickerCell = getCell(Tag.avatarBackgroundPickerCell) as? AvatarBackgroundPickerCell
        let nameCell = getCell(Tag.nameCell) as? TextFieldTitleCell
        let headlineCell = getCell(Tag.headlineCell) as? TextFieldTitleCell
        let websiteCell = getCell(Tag.websiteCell) as? TextFieldTitleCell
        
        pickerCell?.setAvatar(id: viewModel.profile.company.logo)
        pickerCell?.setBackground(id: viewModel.profile.background)
        nameCell?.setText(viewModel.profile.company.name)
        headlineCell?.setText(viewModel.profile.company.headline)
        websiteCell?.setText(viewModel.profile.website)
    }
}

// MARK: Tags
private enum Tag {
    static let avatarBackgroundPickerCell = "avatarBackgroundPickerCell"
    static let nameCell = "nameCell"
    static let headlineCell = "headlineCell"
    static let websiteCell = "websiteCell"
}

