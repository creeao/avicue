//
//  CompaniesCell.swift
//  airPilot
//
//  Created by Eryk Chrustek on 30/12/2022.
//

import UIKit

protocol MenuCompaniesCellDelegate: AnyObject {
    func showCompany(companyId: Int)
}

final class MenuCompaniesCell: CustomTableViewCell {
    // MARK: External properties
    weak var delegate: MenuCompaniesCellDelegate?
    
    // MARK: Private properties
    private var stackView = UIStackView()
    private var elements: [MenuCompanyView] = []
    
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
extension MenuCompaniesCell {
    func setup(with companies: [CompanyModel]) {
        companies.forEach { company in
            let element = MenuCompanyView()
            element.setup(with: company)
            element.delegate = self
            
            elements.append(element)
            stackView.addArrangedSubview(element)
        }
    }
}

// MARK: MenuCompanyViewDelegate
extension MenuCompaniesCell: MenuCompanyViewDelegate {
    func showCompany(companyId: Int) {
        delegate?.showCompany(companyId: companyId)
    }
}
    
// MARK: Private methods
private extension MenuCompaniesCell {
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
