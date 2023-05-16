//
//  CalendarViewController.swift
//  airPilot
//
//  Created by Eryk Chrustek on 27/12/2022.
//  Copyright © 2022 ACC. All rights reserved.
//

import UIKit

protocol CalendarDisplayable {
    func displayContent(_ viewModel: Calendar.Content.ViewModel)
}

final class CalendarViewController: ViewController {
    // MARK: External properties
    var interactor: CalendarLogic?
    
    // MARK: Private properties
    private var calendarId: Int? = nil
    
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
        openEventCreator()
    }
}

// MARK: CalendarDisplayable
extension CalendarViewController: CalendarDisplayable {
    func displayContent(_ viewModel: Calendar.Content.ViewModel) {
        calendarId = viewModel.calendarId
        setupCells(with: viewModel.events)
        hideLoader(reloadData: true)
    }
}

// MARK: EventCellDelegate
extension CalendarViewController: EventCellDelegate {
    func tapUser(userUuid: String) {
        let profile = Profile.createScene(.init(userUuid: userUuid))
        push(profile)
    }
    
    func tapSendMessageButton(userUuid: String, eventId: Int) {
        let conversation = Messages.createScene(.init(conversationId: nil, userUuid: userUuid))
        push(conversation)
    }
}

// MARK: External methods
extension CalendarViewController {
    func getContent() {
        displayLoader()
        interactor?.getContent(.init())
    }
    
    func openEventCreator() {
        let eventCreator = EventCreator.createScene(.init(calendarId: calendarId))
        push(eventCreator)
    }
}

// MARK: Private methods
private extension CalendarViewController {
    func setupView() {
        setupBackButton()
        setupRightButton(image: Image.Navigation.calendarAdd)
        setupTableView(for: self)
    }
    
    func setupCells(with events: [EventModel]) {
        events.forEach {
            let cell = EventCell()
            cell.setup(with: $0)
            cell.delegate = self
            appendCell(cell)
        }
    }
}
