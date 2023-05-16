//
//  EventCreatorViewController.swift
//  airPilot
//
//  Created by Eryk Chrustek on 17/01/2023.
//  Copyright © 2023 ACC. All rights reserved.
//

import UIKit

protocol EventCreatorDisplayable {
    func displayContent(_ viewModel: EventCreator.Content.ViewModel)
    func displayResult(_ response: EventCreator.Result.ViewModel)
}

final class EventCreatorViewController: ViewController {
    // MARK: External properties
    var interactor: EventCreatorLogic?
    
    // MARK: Private properties
    private let pickerView = UIPickerView()
    private var eventType: EventType = .event
    private var group: GroupModel? = nil
    
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

// MARK: EventCreatorDisplayable
extension EventCreatorViewController: EventCreatorDisplayable {
    func displayContent(_ viewModel: EventCreator.Content.ViewModel) {
        if let group = viewModel.group {
            selectGroup(group)
        }
        
        hideLoader(reloadData: true)
    }
    
    func displayResult(_ response: EventCreator.Result.ViewModel) {
        let input = ResultScreen.Input(result: response.result)
        let result = ResultScreen.createScene(input)
        push(result)
        
        result.backCompletion = { [weak self] in
            (self?.getViewControllerFromTabBar(type: CalendarViewController.self) as? CalendarViewController)?.getContent()
            self?.pop(to: TabBarController.self)
        }
    }
}

// MARK: TextFieldTitleLogoButtonCellDelegate
extension EventCreatorViewController: TextFieldTitleLogoButtonCellDelegate {
    func tapView() {
        let groups = Groups.createScene()
        push(groups)
    }
}

// MARK: TextFieldTitleButtonCellDelegate
extension EventCreatorViewController: TextFieldTitleButtonCellDelegate {
    func tapTextFieldTitleButtonCell() {
        pickerView.isHidden = false
        
        UIView.animate(withDuration: .shortAnimationTime) { [weak self] in
            self?.pickerView.alpha = Constants.Alpha.full
        }
    }
}

// MARK: UIPickerViewDelegate, UIPickerViewDataSource
extension EventCreatorViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return EventType.allCases.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return EventType.allCases[row].title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        eventType = EventType.allCases[row]
        setupCells()
        
        (getCell(Tag.categoryCell) as? TextFieldTitleButtonCell)?.setText(eventType.title)
        if let group { (getCell(Tag.groupCell) as? TextFieldTitleLogoButtonCell)?.select(with: group) }
        
        UIView.animate(withDuration: .shortAnimationTime) { [weak self] in
            self?.pickerView.alpha = Constants.Alpha.zero
        } completion: { [weak self] _ in
            self?.pickerView.isHidden = true
        }
    }
}

// MARK: External methods
extension EventCreatorViewController {
    func getContent() {
        displayLoader()
        interactor?.getContent(.init())
    }
    
    func selectGroup(_ model: GroupModel) {
        let groupCell = getCell(Tag.groupCell) as? TextFieldTitleLogoButtonCell
        groupCell?.select(with: model)
        group = model
    }
    
    func createOffer() {
        let groupCell = getCell(Tag.groupCell) as? TextFieldTitleLogoButtonCell
        let categoryCell = getCell(Tag.categoryCell) as? TextFieldTitleButtonCell
        let nameCell = getCell(Tag.nameCell) as? TextFieldTitleCell
        let positionCell = getCell(Tag.positionCell) as? TextFieldTitleCell
        let dateCell = getCell(Tag.dateCell) as? TextFieldTitleButtonCell
        let startDateCell = getCell(Tag.startDateCell) as? TextFieldTitleButtonCell
        let endDateCell = getCell(Tag.endDateCell) as? TextFieldTitleButtonCell
        let locationCell = getCell(Tag.locationCell) as? TextFieldTitleCell
        let descriptionCell = getCell(Tag.descriptionCell) as? TextViewTitleCell
        let departureDestinationsCell = getCell(Tag.departureDestinationCell) as? TextFieldsTitleButtonsCell
        let departurePositionCell = getCell(Tag.departurePositionCell) as? TwoTextFieldsTitleCell

        switch eventType {
        case .event:
            interactor?.createOffer(.init(
                name: nameCell?.getText(),
                postition: nil,
                description: descriptionCell?.getText(),
                location: locationCell?.getText(),
                departureDestinations: nil,
                departure: nil,
                type: .event,
                date: dateCell?.getText(),
                startDate: nil,
                endDate: nil,
                groupId: groupCell?.id))
        case .offerDuty:
            interactor?.createOffer(.init(
                name: nil,
                postition: positionCell?.getText(),
                description: descriptionCell?.getText(),
                location: nil,
                departureDestinations: departureDestinationsCell?.getArray(),
                departure: nil,
                type: .offerDuty,
                date: nil,
                startDate: startDateCell?.getText(),
                endDate: endDateCell?.getText(),
                groupId: groupCell?.id))
        default:
            interactor?.createOffer(.init(
                name: nil,
                postition: departurePositionCell?.getBigText(),
                description: descriptionCell?.getText(),
                location: nil,
                departureDestinations: nil,
                departure: departurePositionCell?.getSmallText(),
                type: eventType,
                date: dateCell?.getText(),
                startDate: nil,
                endDate: nil,
                groupId: groupCell?.id))
        }
    }
}

// MARK: Private methods
private extension EventCreatorViewController {
    func setupView() {
        setupBackButton()
        setupTableView(for: self)
        setupTitleCell()
        setupCategoryCell()
        setupButton("Create event")
        setupPickerView()
    }
    
    func setupCells() {
        switch eventType {
        case .event:
            setupEvent()
        case .offerDuty:
            setupOfferDuty()
        case .offerHomeStandby:
            setupOfferSearch()
        case .offerOffDays:
            setupOfferSearch()
        case .searchDuty:
            setupOfferSearch()
        case .searchHomeStandby:
            setupOfferSearch()
        case .searchOffDays:
            setupOfferSearch()
        }
        
        hideLoader(reloadData: true)
    }
    
    func setupEvent() {
        removeCells()
        setupTitleCell()
        setupCategoryCell()
        setupGroupCell()
        setupNameCell()
        setupDateCell()
        setupLocationCell()
        setupDescriptionCell()
    }
    
    func setupOfferDuty() {
        removeCells()
        setupTitleCell()
        setupCategoryCell()
        setupGroupCell()
        setupDepartureDestinationCell()
        setupStartDateCell()
        setupEndDateCell()
        setupPositionCell()
        setupDescriptionCell()
    }
    
    func setupOfferSearch() {
        removeCells()
        setupTitleCell()
        setupCategoryCell()
        setupGroupCell()
        setupDeparturePositionCell()
        setupDateCell()
        setupDescriptionCell()
    }
    
    func setupTitleCell() {
        let cell = LargeTitleCell()
        cell.setup(with: "Create event", toLeft: true)
        appendCell(cell)
    }
    
    func setupCategoryCell() {
        let cell = TextFieldTitleButtonCell()
        cell.setup(with: "Category", and: "Select event category", withGesture: true)
        cell.identifier = Tag.categoryCell
        cell.delegate = self
        appendCell(cell)
    }
    
    func setupGroupCell() {
        let cell = TextFieldTitleLogoButtonCell()
        cell.setup(with: "Assigned to group", and: "Select group")
        cell.identifier = Tag.groupCell
        cell.delegate = self
        appendCell(cell)
    }
    
    func setupNameCell() {
        let cell = TextFieldTitleCell()
        cell.setup(with: "Name", and: "e.g. Family picnic")
        cell.identifier = Tag.nameCell
        appendCell(cell)
    }

    func setupPositionCell() {
        let cell = TextFieldTitleCell()
        cell.setup(with: "Position", and: "e.g. First Officer")
        cell.identifier = Tag.positionCell
        appendCell(cell)
    }
    
    func setupDepartureDestinationCell() {
        let cell = TextFieldsTitleButtonsCell()
        cell.setup(with: "Depature and destinations")
        cell.identifier = Tag.departureDestinationCell
        appendCell(cell)
    }
    
    func setupDeparturePositionCell() {
        let cell = TwoTextFieldsTitleCell()
        cell.setup(with: "Departure and position", "WAW", "e.g. First Officer")
        cell.identifier = Tag.departurePositionCell
        appendCell(cell)
    }
    
    func setupDateCell() {
        let cell = TextFieldTitleButtonCell()
        cell.setup(with: "Date (optional)", and: "13 sept. 2023", type: .calendar)
        cell.identifier = Tag.dateCell
        appendCell(cell)
    }
    
    func setupStartDateCell() {
        let cell = TextFieldTitleButtonCell()
        cell.setup(with: "Start date - C/I UTC", and: "13 sept. 2023 - 15:25", type: .calendar)
        cell.identifier = Tag.startDateCell
        appendCell(cell)
    }
    
    func setupEndDateCell() {
        let cell = TextFieldTitleButtonCell()
        cell.setup(with: "End date - C/O UTC", and: "15 sept. 2023 - 12:15", type: .calendar)
        cell.identifier = Tag.endDateCell
        appendCell(cell)
    }
    
    func setupLocationCell() {
        let cell = TextFieldTitleCell()
        cell.setup(with: "Location (optional)", and: "e.g. Poland, Cracov, Michalowska 12B")
        cell.identifier = Tag.locationCell
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
}

// MARK: Tags
private enum Tag {
    static let groupCell = "groupCell"
    static let categoryCell = "categoryCell"
    static let nameCell = "nameCell"
    static let positionCell = "positionCell"
    static let dateCell = "dateCell"
    static let startDateCell = "startDateCell"
    static let endDateCell = "endDateCell"
    static let locationCell = "locationCell"
    static let descriptionCell = "descriptionCell"
    static let departureDestinationCell = "departureDestinationCell"
    static let departurePositionCell = "departurePositionCell"
}
