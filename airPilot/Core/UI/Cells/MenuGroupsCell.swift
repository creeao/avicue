//
//  MenuGroupsCell.swift
//  airPilot
//
//  Created by Eryk Chrustek on 30/12/2022.
//

import UIKit

protocol MenuGroupsCellDelegate: AnyObject {
    func showGroup(groupId: Int)
}

final class MenuGroupsCell: CustomTableViewCell {
    // MARK: External properties
    weak var delegate: MenuGroupsCellDelegate?
    
    // MARK: Private properties
    private var stackView = UIStackView()
    private var elements: [MenuGroupView] = []
    
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
extension MenuGroupsCell {
    func setup(with administrator: [GroupModel], and member: [GroupModel]) {
        administrator.forEach { group in
            let element = MenuGroupView()
            element.setup(with: group, and: "Group - Administrator")
            element.delegate = self
            
            elements.append(element)
            stackView.addArrangedSubview(element)
        }
        
        member.forEach { group in
            let element = MenuGroupView()
            element.setup(with: group, and: "Group - Member")
            element.delegate = self
            
            elements.append(element)
            stackView.addArrangedSubview(element)
        }
    }
}

// MARK: MenuGroupViewDelegate
extension MenuGroupsCell: MenuGroupViewDelegate {
    func showGroup(groupId: Int) {
        delegate?.showGroup(groupId: groupId)
    }
}
    
// MARK: Private methods
private extension MenuGroupsCell {
    func setupView() {
        setupContainerView()
        setupStackView()
    }
    
    func setupStackView() {
        containerView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Margin.normal.space
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
}
