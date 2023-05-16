//
//  EditProfileViewController.swift
//  airPilot
//
//  Created by Eryk Chrustek on 21/11/2022.
//  Copyright © 2022 ACC. All rights reserved.
//

import UIKit

protocol EditProfileDisplayable {
    func displayContent(_ viewModel: EditProfile.Content.ViewModel)
    func displayResult(_ response: EditProfile.Result.ViewModel)
}

final class EditProfileViewController: ViewController {
    // MARK: External properties
    var interactor: EditProfileLogic?
    
    // MARK: Private properties
    private let imagePicker = UIImagePickerController()
    private var pickerType: EditProfile.PickerType = .avatar
    
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

// MARK: EditProfileDisplayable
extension EditProfileViewController: EditProfileDisplayable {
    func displayContent(_ viewModel: EditProfile.Content.ViewModel) {
        setupCells(with: viewModel)
        hideLoader(reloadData: true)
    }
    
    func displayResult(_ response: EditProfile.Result.ViewModel) {
        let input = ResultScreen.Input(result: response.result)
        let result = ResultScreen.createScene(input)
        push(result)
        
        result.backCompletion = { [weak self] in
            (self?.getViewController(type: ProfileViewController.self) as? ProfileViewController)?.getContent()
            self?.pop(to: ProfileViewController.self)
        }
    }
}

// MARK: AvatarBackgroundPickerCellDelegate
extension EditProfileViewController: AvatarBackgroundPickerCellDelegate {
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
extension EditProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
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
                interactor?.changeAvatar(.init(image: image))
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

// MARK: EditJobHistoryCellDelegate
extension EditProfileViewController: EditJobHistoryCellDelegate {
    func addHistory() {
        let jobHistoryCreator = JobHistoryCreator.createScene()
        push(jobHistoryCreator)
    }
    
    func removeHistory(id: Int) {
        interactor?.removeJobHistory(.init(id: id))
    }
}

// MARK: External methods
extension EditProfileViewController {
    func getContent() {
        displayLoader()
        interactor?.getContent(.init())
    }
    
    func saveChanges() {
        let firstNameCell = getCell(Tag.firstNameCell) as? TextFieldTitleCell
        let lastNameCell = getCell(Tag.lastNameCell) as? TextFieldTitleCell
        let headlineCell = getCell(Tag.headlineCell) as? TextFieldTitleButtonCell
        let emailCell = getCell(Tag.emailCell) as? TextFieldTitleCell
//        let birthDateCell = getCell(Tag.birthDateCell) as? TextFieldTitleButtonCell
        
        interactor?.saveChanges(.init(
            firstName: firstNameCell?.getText(),
            lastName: lastNameCell?.getText(),
            headline: headlineCell?.getText(),
            email: emailCell?.getText())
        )
    }
}

// MARK: Private methods
private extension EditProfileViewController {
    func setupView() {
        setupBackButton()
        setupTableView(for: self)
        
        setupTitleCell()
        setupAvatarBackgroundPickerCell()
        setupFirstNameCell()
        setupLastNameCell()
        setupHeadlineCell()
        setupEmailCell()
        setupBirthDateCell()
        setupLanguagesCell()
        setupNationalityCell()
        setupEditWorkHistory()
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
    
    func setupFirstNameCell() {
        let cell = TextFieldTitleCell()
        cell.setup(with: "First name", and: "First name")
        cell.identifier = Tag.firstNameCell
        appendCell(cell)
    }
    
    func setupLastNameCell() {
        let cell = TextFieldTitleCell()
        cell.setup(with: "Last name", and: "Last name")
        cell.identifier = Tag.lastNameCell
        appendCell(cell)
    }
    
    func setupHeadlineCell() {
        let cell = TextFieldTitleButtonCell()
        cell.setup(with: "Headline", and: "Headline", type: .text("Get position"), buttonWidth: 120)
        cell.identifier = Tag.headlineCell
        appendCell(cell)
    }
    
    func setupEmailCell() {
        let cell = TextFieldTitleCell()
        cell.setup(with: "Email", and: "Email")
        cell.identifier = Tag.emailCell
        appendCell(cell)
    }
    
    func setupBirthDateCell() {
        let cell = TextFieldTitleButtonCell()
        cell.setup(with: "Date of birth", and: "13 sept. 1980", type: .calendar)
        cell.identifier = Tag.birthDateCell
        appendCell(cell)
    }
    
    func setupImagePicker() {
        imagePicker.delegate = self
//        imagePicker.mediaTypes = ["public.image", "public.movie"]
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
    }
    
    func setupLanguagesCell() {
        let cell = TextFieldTitleCell()
        cell.setup(with: "Languages", and: "e.g. English, Polish...")
        cell.identifier = Tag.languagesCell
        appendCell(cell)
    }
    
    func setupNationalityCell() {
        let cell = TextFieldTitleCell()
        cell.setup(with: "Nationality", and: "e.g. Poland")
        cell.identifier = Tag.nationalityCell
        appendCell(cell)
    }
    
    func setupEditWorkHistory() {
        let cell = EditJobHistoryCell()
        cell.identifier = Tag.editJobHistoryCell
        cell.delegate = self
        appendCell(cell)
    }
    
    func setupCells(with viewModel: EditProfile.Content.ViewModel) {
        let avatarBackgroundPickerCell = getCell(Tag.avatarBackgroundPickerCell) as? AvatarBackgroundPickerCell
        avatarBackgroundPickerCell?.setAvatar(id: viewModel.currentInformations.user?.avatar)
        avatarBackgroundPickerCell?.setBackground(id: viewModel.currentInformations.background)
        let firstNameCell = getCell(Tag.firstNameCell) as? TextFieldTitleCell
        firstNameCell?.setText(viewModel.currentInformations.user?.firstName)
        let lastNameCell = getCell(Tag.lastNameCell) as? TextFieldTitleCell
        lastNameCell?.setText(viewModel.currentInformations.user?.lastName)
        let headlineCell = getCell(Tag.headlineCell) as? TextFieldTitleButtonCell
        headlineCell?.setText(viewModel.currentInformations.user?.headline)
        let emailCell = getCell(Tag.emailCell) as? TextFieldTitleCell
        emailCell?.setText(viewModel.currentInformations.user?.email)
        
        let editJobHistoryCell = getCell(Tag.editJobHistoryCell) as? EditJobHistoryCell
        editJobHistoryCell?.setup(with: viewModel.currentInformations.jobHistory ?? [])
    }
}

// MARK: Tags
private enum Tag {
    static let avatarBackgroundPickerCell = "avatarBackgroundPickerCell"
    static let firstNameCell = "firstNameCell"
    static let lastNameCell = "lastNameCell"
    static let headlineCell = "headlineCell"
    static let emailCell = "emailCell"
    static let birthDateCell = "birthDateCell"
    static let languagesCell = "languagesCell"
    static let nationalityCell = "nationalityCell"
    static let editJobHistoryCell = "editJobHistoryCell"
}
