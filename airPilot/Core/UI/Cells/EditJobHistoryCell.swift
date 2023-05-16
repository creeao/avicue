//
//  EditJobHistoryCell.swift
//  airPilot
//
//  Created by Eryk Chrustek on 21/12/2022.
//

import UIKit

protocol EditJobHistoryCellDelegate: AnyObject {
    func addHistory()
    func removeHistory(id: Int)
}

class EditJobHistoryCell: CustomTableViewCell {
    // MARK: External properties
    weak var delegate: EditJobHistoryCellDelegate?
    
    // MARK: Private properties
    private let titleLabel = UILabel()
    private var jobHistoryViews: [JobHistoryView] = []
    private var stackView = UIStackView()
    private let addHistoryButton = Button()
    
    // MARK: Life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
}

// MARK: External methods
extension EditJobHistoryCell {
    func setup(with job: [JobHistoryModel]) {
        job.forEach { model in
            setupJobHistoryView(with: model)
        }
    }
}

// MARK: JobHistoryViewDelegate
extension EditJobHistoryCell: JobHistoryViewDelegate {
    func openCompany(companyId: Int) {
        
    }
    
    func removeHistory(id: Int) {
//        guard let view = jobHistoryViews.first(where: { $0.getModel()?.id == model.id }) else { return }
//        view.isHidden = true
//        stackView.willRemoveSubview(view)
//        stackView.arrangedSubviews.removeAll(where: { ($0 as? JobHistoryView)?.getModel()?.id == model.id })
    
//        stackView.removeArrangedSubview(view)
        delegate?.removeHistory(id: id)
    }
}

// MARK: Events
private extension EditJobHistoryCell {
    @objc func tapAddHistoryButton() {
        delegate?.addHistory()
    }
}
    
// MARK: Private methods
private extension EditJobHistoryCell {
    func setupView() {
        setupContainerView()
        setupTitleLabel()
        setupJobHistoryViews()
        setupAddHistoryButton()
    }
    
    func setupTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = Font.miniMedium
        titleLabel.textColor = Color.gray.withHardAlpha
        titleLabel.text = "Job history"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Margin.small.leading),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
        ])
    }
    
    func setupJobHistoryViews() {
        containerView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = Margin.mini.space
        stackView.axis = .vertical
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
    
    func setupAddHistoryButton() {
        containerView.addSubview(addHistoryButton)
        addHistoryButton.translatesAutoresizingMaskIntoConstraints = false
        addHistoryButton.set(width: 40, height: 40)
        addHistoryButton.setup(for: .filledImage, and: Image.plusButton)
        addHistoryButton.addTarget(self, action: #selector(tapAddHistoryButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            addHistoryButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: Margin.small.top),
            addHistoryButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            addHistoryButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    func setupJobHistoryView(with job: JobHistoryModel) {
        let jobHistoryView = JobHistoryView()
        jobHistoryView.setup(with: job, inEditView: true)
        jobHistoryView.delegate = self
        
        stackView.addArrangedSubview(jobHistoryView)
        jobHistoryView.translatesAutoresizingMaskIntoConstraints = false
        jobHistoryViews.append(jobHistoryView)
    }
}
