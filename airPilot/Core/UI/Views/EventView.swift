//
//  EventView.swift
//  airPilot
//
//  Created by Eryk Chrustek on 06/01/2023.
//

import UIKit

protocol EventViewDelegate: AnyObject {
    func showGroup(groupId: Int)
}

enum EventType: String, Codable, CaseIterable {
    case event = "EVENT"
    case offerDuty = "OFFER_DUTY"
    case offerOffDays = "OFFER_OFF_DAYS"
    case offerHomeStandby = "OFFER_HOME_STANDBY"
    case searchDuty = "SEARCH_DUTY"
    case searchOffDays = "SEARCH_OFF_DAYS"
    case searchHomeStandby = "SEARCH_HOME_STANDBY"
    
    var title: String {
        switch self {
            case .event: return "Event"
            case .offerDuty: return "Offer duty"
            case .offerOffDays: return "Offer off days"
            case .offerHomeStandby: return "Offer home standby"
            case .searchDuty: return "Search duty"
            case .searchOffDays: return "Search off days"
            case .searchHomeStandby: return "Search home standby"
        }
    }
}

final class EventView: UIView {
    // MARK: External properties
    weak var delegate: EventViewDelegate?
    
    // MARK: Private properties
    private let categoryView = UIView()
    private let categoryLabel = UILabel()
    
    private let additionalInfoView = UIView()
    private let additionalInfoStackView = UIStackView()
    
    private let containerView = UIView()
    private let eventStackView = UIStackView()
    
    private let eventTitle = UILabel()
    private let eventDescription = UILabel()
    private let eventDate = PostImageLabelView()
    private let eventLocation = PostImageLabelView()
    
    private let dutyLeftContainer = UIView()
    private let dutyPlacesContainer = UIView()
    private let dutyDeparture = UILabel()
    private let dutyArrow = UIImageView()
    private let dutyDestination = UILabel()
    private let dutyTime = UILabel()
    private let dutySeparator = UIView()
    private let dutyRightContainer = UIView()
    private let dutyDaysAndSectors = UILabel()
    private let dutyPosition = UILabel()
    
    // MARK: Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
}

// MARK: External methods
extension EventView {
    func setup(with event: EventModel) {
        switch event.type {
        case .event:
            setupEvent(event)
        case .offerDuty:
            setupOfferDuty(event)
        case .offerHomeStandby:
            setupOfferHomeStandby(event)
        case .offerOffDays:
            setupOfferOffDays(event)
        case .searchDuty:
            setupSearchDuty(event)
        case .searchHomeStandby:
            setupSearchHomeStandby(event)
        case .searchOffDays:
            setupSearchOffDays(event)
        default:
            setupEvent(event)
        }
    }
}

// MARK: Events
private extension EventView {
    @objc func tapGroup() {
//        delegate?.showGroup(groupId: (model?.id).orZero)
    }
}

// MARK: Private
private extension EventView {
    func setupView() {
        setupCategoryView()
        setupCategoryLabel()
        setupAdditionalInfoView()
        setupAdditionalInfoStackView()
        setupContainerView()
    }
    
    func setupCategoryView() {
        addSubview(categoryView)
        categoryView.translatesAutoresizingMaskIntoConstraints = false
        categoryView.layer.cornerRadius = Constants.smallerCornerRadius
        
        NSLayoutConstraint.activate([
            categoryView.topAnchor.constraint(equalTo: topAnchor),
            categoryView.leadingAnchor.constraint(equalTo: leadingAnchor),
            categoryView.trailingAnchor.constraint(equalTo: trailingAnchor),
            categoryView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupCategoryLabel() {
        categoryView.addSubview(categoryLabel)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.font = Font.littleMedium
        
        NSLayoutConstraint.activate([
            categoryLabel.centerXAnchor.constraint(equalTo: categoryView.centerXAnchor),
            categoryLabel.topAnchor.constraint(equalTo: categoryView.topAnchor, constant: Margin.mini.top)
        ])
    }
    
    func setupAdditionalInfoView() {
        addSubview(additionalInfoView)
        additionalInfoView.translatesAutoresizingMaskIntoConstraints = false
        additionalInfoView.backgroundColor = Color.gray.withFrailAlpha
        additionalInfoView.layer.cornerRadius = Constants.smallerCornerRadius
        
        NSLayoutConstraint.activate([
            additionalInfoView.bottomAnchor.constraint(equalTo: bottomAnchor),
            additionalInfoView.leadingAnchor.constraint(equalTo: leadingAnchor),
            additionalInfoView.trailingAnchor.constraint(equalTo: trailingAnchor),
            additionalInfoView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    func setupAdditionalInfoStackView() {        additionalInfoView.addSubview(additionalInfoStackView)
        additionalInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        additionalInfoStackView.spacing = Margin.mini.space
        additionalInfoStackView.axis = .horizontal
//        additionalInfoStackView.contentMode = .center
//        additionalInfoStackView.distribution = .equalCentering
        additionalInfoStackView.alignment = .center
        
        NSLayoutConstraint.activate([
            additionalInfoStackView.centerXAnchor.constraint(equalTo: additionalInfoView.centerXAnchor),
            additionalInfoStackView.widthAnchor.constraint(lessThanOrEqualTo: additionalInfoView.widthAnchor, constant: -Margin.huge.space),
//            additionalInfoStackView.leadingAnchor.constraint(greaterThanOrEqualTo: additionalInfoView.leadingAnchor),
//            additionalInfoStackView.trailingAnchor.constraint(greaterThanOrEqualTo: additionalInfoView.trailingAnchor),
            additionalInfoStackView.bottomAnchor.constraint(equalTo: additionalInfoView.bottomAnchor, constant: Margin.mini.bottom)
        ])
    }
    
    func setupContainerView() {
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = Color.white
        containerView.layer.cornerRadius = Constants.smallerCornerRadius
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: categoryView.bottomAnchor, constant: Margin.normal.bottom),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: additionalInfoView.topAnchor, constant: Margin.normal.top),
        ])
    }
    
    func setupEventStackView() {
        containerView.addSubview(eventStackView)
        eventStackView.translatesAutoresizingMaskIntoConstraints = false
        eventStackView.axis = .vertical
        
        NSLayoutConstraint.activate([
            eventStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Margin.normal.top),
            eventStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Margin.large.leading),
            eventStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: Margin.large.trailing),
            eventStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: Margin.normal.bottom),
        ])
    }
    
    func setupEventTitle(_ title: String?) {
        eventStackView.addArrangedSubview(eventTitle)
        eventTitle.translatesAutoresizingMaskIntoConstraints = false
        eventTitle.font = Font.normalMedium
        eventTitle.textColor = Color.black
        eventTitle.numberOfLines = 0
        eventTitle.text = title
        
        eventStackView.setCustomSpacing(Margin.mini.space, after: eventTitle)
    }
    
    func setupEventDescription(_ description: String?) {
        eventStackView.addArrangedSubview(eventDescription)
        eventDescription.translatesAutoresizingMaskIntoConstraints = false
        eventDescription.font = Font.normalLight
        eventDescription.textColor = Color.black
        eventDescription.numberOfLines = 0
        eventDescription.text = description
        
        eventStackView.setCustomSpacing(Margin.regular.space, after: eventDescription)
    }
    
    func setupEventDate(_ date: String?) {
        eventStackView.addArrangedSubview(eventDate)
        eventDate.translatesAutoresizingMaskIntoConstraints = false
        eventDate.setup(with: Image.Calendar.calendarClock, and: (date?.getDate).orEmpty)
        eventStackView.setCustomSpacing(Margin.mini.space, after: eventDate)
    }
    
    func setupEventLocation(_ location: String?) {
        eventStackView.addArrangedSubview(eventLocation)
        eventLocation.translatesAutoresizingMaskIntoConstraints = false
        eventLocation.setup(with: Image.Calendar.calendarLocation, and: location.orEmpty)
    }
    
    func setupDutyLeftContainer(_ isOneElement: Bool) {
        containerView.addSubview(dutyLeftContainer)
        dutyLeftContainer.translatesAutoresizingMaskIntoConstraints = false
        dutyLeftContainer.contentMode = .center
        
        NSLayoutConstraint.activate([
            dutyLeftContainer.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Margin.normal.top),
            dutyLeftContainer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            dutyLeftContainer.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: Margin.normal.bottom),
            dutyLeftContainer.widthAnchor.constraint(equalToConstant: 164)
        ])
        
        setupDutyPlacesContainer(isOneElement)
        setupDutyTime()
    }
    
    func setupSeparator() {
        containerView.addSubview(dutySeparator)
        dutySeparator.translatesAutoresizingMaskIntoConstraints = false
        dutySeparator.backgroundColor = Color.gray.withMiniAlpha
        dutySeparator.layer.cornerRadius = 3
        
        NSLayoutConstraint.activate([
            dutySeparator.centerYAnchor.constraint(equalTo: dutyLeftContainer.centerYAnchor),
            dutySeparator.leadingAnchor.constraint(equalTo: dutyLeftContainer.trailingAnchor),
            dutySeparator.heightAnchor.constraint(equalToConstant: 30),
            dutySeparator.widthAnchor.constraint(equalToConstant: 3)
        ])
    }
    
    func setupDutyRightContainer() {
        containerView.addSubview(dutyRightContainer)
        dutyRightContainer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dutyRightContainer.centerYAnchor.constraint(equalTo: dutyLeftContainer.centerYAnchor),
            dutyRightContainer.leadingAnchor.constraint(equalTo: dutySeparator.trailingAnchor),
            dutyRightContainer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
        
        setupDutyDaysAndSectors()
        setupDutyPosition()
    }
    
    func setupDutyPlacesContainer(_ isOneElement: Bool) {
        dutyLeftContainer.addSubview(dutyPlacesContainer)
        dutyPlacesContainer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dutyPlacesContainer.topAnchor.constraint(equalTo: dutyLeftContainer.topAnchor),
            dutyPlacesContainer.centerXAnchor.constraint(equalTo: dutyLeftContainer.centerXAnchor)
        ])
        
        if isOneElement {
            setupOnePlace()
        } else {
            setupDutyDeparture()
            setupDutyArrow()
            setupDutyDestination()
        }
    }
    
    func setupOnePlace() {
        dutyPlacesContainer.addSubview(dutyDeparture)
        dutyDeparture.translatesAutoresizingMaskIntoConstraints = false
        dutyDeparture.font = Font.hugeSemiBold
        dutyDeparture.textColor = Color.black
        
        NSLayoutConstraint.activate([
            dutyDeparture.topAnchor.constraint(equalTo: dutyPlacesContainer.topAnchor),
            dutyDeparture.leadingAnchor.constraint(equalTo: dutyPlacesContainer.leadingAnchor),
            dutyDeparture.trailingAnchor.constraint(equalTo: dutyPlacesContainer.trailingAnchor),
            dutyDeparture.bottomAnchor.constraint(equalTo: dutyPlacesContainer.bottomAnchor)
        ])
    }
    
    func setupDutyDeparture() {
        dutyPlacesContainer.addSubview(dutyDeparture)
        dutyDeparture.translatesAutoresizingMaskIntoConstraints = false
        dutyDeparture.font = Font.hugeSemiBold
        dutyDeparture.textColor = Color.black
        
        NSLayoutConstraint.activate([
            dutyDeparture.topAnchor.constraint(equalTo: dutyPlacesContainer.topAnchor),
            dutyDeparture.leadingAnchor.constraint(equalTo: dutyPlacesContainer.leadingAnchor),
            dutyDeparture.bottomAnchor.constraint(equalTo: dutyPlacesContainer.bottomAnchor)
        ])
    }
    
    func setupDutyArrow() {
        dutyPlacesContainer.addSubview(dutyArrow)
        dutyArrow.translatesAutoresizingMaskIntoConstraints = false
        dutyArrow.image = Image.Calendar.bigArrow
        
        NSLayoutConstraint.activate([
            dutyArrow.centerYAnchor.constraint(equalTo: dutyDeparture.centerYAnchor),
            dutyArrow.leadingAnchor.constraint(equalTo: dutyDeparture.trailingAnchor, constant: Margin.small.leading),
        ])
    }
    
    func setupDutyDestination() {
        dutyPlacesContainer.addSubview(dutyDestination)
        dutyDestination.translatesAutoresizingMaskIntoConstraints = false
        dutyDestination.font = Font.hugeSemiBold
        dutyDestination.textColor = Color.black
        
        NSLayoutConstraint.activate([
            dutyDestination.topAnchor.constraint(equalTo: dutyPlacesContainer.topAnchor),
            dutyDestination.leadingAnchor.constraint(equalTo: dutyArrow.trailingAnchor, constant: Margin.small.leading),
            dutyDestination.trailingAnchor.constraint(equalTo: dutyPlacesContainer.trailingAnchor),
            dutyDestination.bottomAnchor.constraint(equalTo: dutyDeparture.bottomAnchor),
        ])
    }
    
    func setupDutyTime() {
        dutyLeftContainer.addSubview(dutyTime)
        dutyTime.translatesAutoresizingMaskIntoConstraints = false
        dutyTime.font = Font.normalRegular
        dutyTime.textColor = Color.gray
        
        NSLayoutConstraint.activate([
            dutyTime.topAnchor.constraint(equalTo: dutyPlacesContainer.bottomAnchor),
            dutyTime.centerXAnchor.constraint(equalTo: dutyLeftContainer.centerXAnchor),
            dutyTime.bottomAnchor.constraint(equalTo: dutyLeftContainer.bottomAnchor)
        ])
    }
    
    func setupDutyDaysAndSectors() {
        dutyRightContainer.addSubview(dutyDaysAndSectors)
        dutyDaysAndSectors.translatesAutoresizingMaskIntoConstraints = false
        dutyDaysAndSectors.font = Font.littleRegular
        dutyDaysAndSectors.textColor = Color.gray
        dutyDaysAndSectors.textAlignment = .center
        
        NSLayoutConstraint.activate([
            dutyDaysAndSectors.topAnchor.constraint(equalTo: dutyRightContainer.topAnchor),
            dutyDaysAndSectors.leadingAnchor.constraint(equalTo: dutyRightContainer.leadingAnchor),
            dutyDaysAndSectors.trailingAnchor.constraint(equalTo: dutyRightContainer.trailingAnchor)
        ])
    }
    
    func setupDutyPosition() {
        dutyRightContainer.addSubview(dutyPosition)
        dutyPosition.translatesAutoresizingMaskIntoConstraints = false
        dutyPosition.font = Font.normalMedium
        dutyPosition.textColor = Color.black
        dutyPosition.textAlignment = .center
        dutyPosition.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            dutyPosition.topAnchor.constraint(equalTo: dutyDaysAndSectors.bottomAnchor),
            dutyPosition.leadingAnchor.constraint(equalTo: dutyRightContainer.leadingAnchor),
            dutyPosition.trailingAnchor.constraint(equalTo: dutyRightContainer.trailingAnchor),
            dutyPosition.bottomAnchor.constraint(equalTo: dutyRightContainer.bottomAnchor)
        ])
    }
    
    func setupDutyDaysAndSectors(_ model: EventModel) {
        var days: String = String.empty
        var sectors: String = String.empty
        
        sectors = (model.locations?.count).orZero.toString + String.space + "sectors"
        
        let daysBetween = daysBetween(from: model.startDate, to: model.endDate)
        if daysBetween < 2 {
            days = "1 day"
        } else {
            days = daysBetween.toString + String.space + "days"
        }
        
        
        if (model.locations?.count).orZero < 2 {
            dutyDaysAndSectors.text = days
        } else {
            dutyDaysAndSectors.text = days + " | " + sectors
        }
    }
    
    func setupLocationsInAdditionalInfoView(_ model: EventModel) {
        let firstLabel = UILabel()
        firstLabel.font = Font.littleMedium
        firstLabel.textColor = Color.gray
        firstLabel.text = model.locations?.first
        additionalInfoStackView.addArrangedSubview(firstLabel)
        firstLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let locations = model.locations?.dropFirst()
        locations?.forEach { location in
            let arrow = UIImageView()
            arrow.layer.masksToBounds = true
            arrow.image = Image.Calendar.smallArrow
            arrow.contentMode = .scaleAspectFit
            
            let label = UILabel()
            label.text = location
            label.font = Font.littleMedium
            label.textColor = Color.gray
            
            additionalInfoStackView.addArrangedSubview(arrow)
            additionalInfoStackView.addArrangedSubview(label)
            arrow.translatesAutoresizingMaskIntoConstraints = false
            label.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupDescriptionInAdditionalInfoView(_ model: EventModel) {
        if let description = model.description, description.isNotEmpty {
            let label = UILabel()
            label.font = Font.miniRegular
            label.textColor = Color.gray
            label.text = description
            additionalInfoStackView.addArrangedSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
        } else {
            additionalInfoStackView.isHidden = true
            additionalInfoView.isHidden = true
        }
    }
    
    func setupOfferDuty(_ model: EventModel) {
        categoryView.backgroundColor = Color.green.withMiniAlpha
        categoryLabel.textColor = Color.green
        categoryLabel.text = "Offer duty"
        
        setupDutyLeftContainer(model.locations?.count == 1)
        setupSeparator()
        setupDutyRightContainer()
        
        if (model.locations?.count).orZero >= 2 {
            dutyDeparture.text = model.locations?[0]
            dutyDestination.text = model.locations?[1]
        } else if (model.locations?.count).orZero == 1 {
            dutyDeparture.text = model.locations?.first
        }
        
        dutyTime.text = model.startDate?.getDateTime
        dutyPosition.text = model.name
        setupDutyDaysAndSectors(model)
        setupLocationsInAdditionalInfoView(model)
    }
    
    func setupOfferHomeStandby(_ model: EventModel) {
        categoryView.backgroundColor = Color.green.withMiniAlpha
        categoryLabel.textColor = Color.green
        categoryLabel.text = "Offer home standby"
        
        setupDutyLeftContainer(true)
        setupSeparator()
        setupDutyRightContainer()
        
        dutyDeparture.text = model.locations?.first
        dutyTime.text = model.startDate?.getDate
        dutyPosition.text = model.name
        setupDutyDaysAndSectors(model)
        setupDescriptionInAdditionalInfoView(model)
    }
    
    func setupOfferOffDays(_ model: EventModel) {
        categoryView.backgroundColor = Color.green.withMiniAlpha
        categoryLabel.textColor = Color.green
        categoryLabel.text = "Offer off days"
        
        setupDutyLeftContainer(true)
        setupSeparator()
        setupDutyRightContainer()
        
        dutyDeparture.text = model.locations?.first
        dutyTime.text = model.startDate?.getDate
        dutyPosition.text = model.name
        setupDutyDaysAndSectors(model)
        setupDescriptionInAdditionalInfoView(model)
    }
    
    func setupSearchDuty(_ model: EventModel) {
        categoryView.backgroundColor = Color.blue.withMiniAlpha
        categoryLabel.textColor = Color.blue
        categoryLabel.text = "Search duty"
        
        setupDutyLeftContainer(true)
        setupSeparator()
        setupDutyRightContainer()
        
        dutyDeparture.text = model.locations?.first
        dutyTime.text = model.startDate?.getDate
        dutyPosition.text = model.name
        setupDutyDaysAndSectors(model)
        setupDescriptionInAdditionalInfoView(model)
    }
    
    func setupSearchHomeStandby(_ model: EventModel) {
        categoryView.backgroundColor = Color.blue.withMiniAlpha
        categoryLabel.textColor = Color.blue
        categoryLabel.text = "Search home standby"
        
        setupDutyLeftContainer(true)
        setupSeparator()
        setupDutyRightContainer()
        
        dutyDeparture.text = model.locations?.first
        dutyTime.text = model.startDate?.getDate
        dutyPosition.text = model.name
        setupDutyDaysAndSectors(model)
        setupDescriptionInAdditionalInfoView(model)
    }
    
    func setupSearchOffDays(_ model: EventModel) {
        categoryView.backgroundColor = Color.blue.withMiniAlpha
        categoryLabel.textColor = Color.blue
        categoryLabel.text = "Search off days"
        
        setupDutyLeftContainer(true)
        setupSeparator()
        setupDutyRightContainer()
        
        dutyDeparture.text = model.locations?.first
        dutyTime.text = model.startDate?.getDate
        dutyPosition.text = model.name
        setupDutyDaysAndSectors(model)
        setupDescriptionInAdditionalInfoView(model)
    }
    
    func setupEvent(_ model: EventModel) {
        categoryView.backgroundColor = Color.purple.withMiniAlpha
        categoryLabel.textColor = Color.purple
        categoryLabel.text = "Event"
        
        setupEventStackView()
        setupEventTitle(model.name)
        setupEventDescription(model.description)
        setupEventDate(model.startDate)
        setupEventLocation(model.location)
        setupDescriptionInAdditionalInfoView(model)
    }
    
    func daysBetween(from startDate: String?, to endDate: String?) -> Int {
        guard let startDate = startDate?.convertToDate(), let endDate = endDate?.convertToDate() else {
            return 0
        }
        
        return (Foundation.Calendar.current.dateComponents([.day], from: startDate, to: endDate).day).orZero
    }
}
