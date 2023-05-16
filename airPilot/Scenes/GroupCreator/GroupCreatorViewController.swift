//
//  GroupCreatorViewController.swift
//  airPilot
//
//  Created by Eryk Chrustek on 29/12/2022.
//  Copyright © 2022 ACC. All rights reserved.
//

import UIKit

protocol GroupCreatorDisplayable {
    func displayContent(_ viewModel: GroupCreator.Content.ViewModel)
    func displayResult(_ response: GroupCreator.Result.ViewModel)
}

final class GroupCreatorViewController: ViewController {
    // MARK: External properties
    var interactor: GroupCreatorLogic?
    
    // MARK: Private properties
    private let imagePicker = UIImagePickerController()
    private var pickerType: GroupCreator.PickerType = .avatar
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getContent()
    }
    
    override func setupActionButton() {
        createGroup()
    }
    
    func displayResult(_ response: GroupCreator.Result.ViewModel) {
        let input = ResultScreen.Input(result: response.result)
        let result = ResultScreen.createScene(input)
        push(result)
        
        result.backCompletion = { [weak self] in
            (self?.getViewController(type: MenuViewController.self) as? MenuViewController)?.getContent()
            self?.pop(to: MenuViewController.self)
        }
    }
}

// MARK: GroupCreatorDisplayable
extension GroupCreatorViewController: GroupCreatorDisplayable {
    func displayContent(_ viewModel: GroupCreator.Content.ViewModel) {
        hideLoader(reloadData: true)
    }
}

// MARK: AvatarBackgroundPickerCellDelegate
extension GroupCreatorViewController: AvatarBackgroundPickerCellDelegate {
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
extension GroupCreatorViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
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

// MARK: TextFieldTitleLogoButtonCellDelegate
extension GroupCreatorViewController: TextFieldTitleLogoButtonCellDelegate {
    func tapView() {
        let companies = Companies.createScene()
        push(companies)
    }
}

// MARK: External methods
extension GroupCreatorViewController {
    func getContent() {
        displayLoader()
        interactor?.getContent(.init())
    }
    
    func selectCompany(_ model: CompanyModel) {
        let companyCell = getCell(Tag.companyCell) as? TextFieldTitleLogoButtonCell
        companyCell?.select(with: model)
    }
    
    func createGroup() {
        let nameCell = getCell(Tag.nameCell) as? TextFieldTitleCell
        let headlineCell = getCell(Tag.headlineCell) as? TextFieldTitleCell
        let companyCell = getCell(Tag.companyCell) as? TextFieldTitleLogoButtonCell
        
        interactor?.createGroup(.init(
            name: (nameCell?.getText()).orEmpty,
            headline: headlineCell?.getText(),
            assignedTo: companyCell?.id))
    }
}

// MARK: Private methods
private extension GroupCreatorViewController {
    func setupView() {
        setupBackButton()
        setupTableView(for: self)
        setupTitleCell()
        setupAvatarBackgroundPickerCell()
        setupNameCell()
        setupHeadlineCell()
        setupCompanyCell()
        setupTypeCell()
        setupImagePicker()
        setupButton("Create group")
    }
    
    func setupTitleCell() {
        let cell = LargeTitleCell()
        cell.setup(with: "Create group", toLeft: true)
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
    
    func setupCompanyCell() {
        let cell = TextFieldTitleLogoButtonCell()
        cell.setup(with: "Assigned to company (optional)", and: "Select company")
        cell.identifier = Tag.companyCell
        cell.delegate = self
        appendCell(cell)
    }
    
    func setupTypeCell() {
        
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
    static let companyCell = "companyCell"
    static let typeCell = "typeCell"
}
