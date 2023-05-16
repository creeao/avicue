//
//  ViewControllerExample.swift
//  airPilot
//
//  Created by Eryk Chrustek on 16/06/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

// MARK: JobOffer
//final class ViewControllerJobOffer: ViewController {
//    private var jobOffers = [JobOfferModel]()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupTableView(for: self)
//        setupView()
//    }
//
//    func setupView() {
//        tableView.register(JobOfferCell.self)
//        jobOffers = [Mocks.jobOffer]
//        tableView.reloadData()
//    }
//}

//extension ViewControllerJobOffer: TableViewMethods {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return jobOffers.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.getCell(JobOfferCell.self, with: indexPath) as? JobOfferCell else {
//            return UITableViewCell()
//        }
//
//        cell.setup(with: jobOffers[indexPath.row])
//        return cell
//    }
//}

// MARK: ApartmentOffer
final class ViewControllerApartmentOffer: ViewController {
    private var apartmentOffers = [ApartmentOfferModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView(for: self)
        setupView()
    }
    
    func setupView() {
//        tableView.register(ApartmentOfferCell.self)
//        apartmentOffers = [Mocks.apartmentOffer]
        tableView.reloadData()
    }
}

//extension ViewControllerApartmentOffer: TableViewMethods {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return apartmentOffers.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.getCell(ApartmentOfferCell.self, with: indexPath) as? ApartmentOfferCell else {
//            return UITableViewCell()
//        }
//
//        cell.setup(with: apartmentOffers[indexPath.row])
//        return cell
//    }
//}

// MARK: PlaneOffer
final class ViewControllerPlaneOffer: ViewController {
//    private var planeOffers = [PlaneOfferModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView(for: self)
        setupView()
    }
    
    func setupView() {
//        tableView.register(PlaneOfferCell.self)
//        planeOffers = [Mocks.planeOffer]
        tableView.reloadData()
    }
}

//extension ViewControllerPlaneOffer: TableViewMethods {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return planeOffers.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.getCell(PlaneOfferCell.self, with: indexPath) as? PlaneOfferCell else {
//            return UITableViewCell()
//        }
//
//        cell.setup(with: planeOffers[indexPath.row])
//        return cell
//    }
//}

// MARK: Post
final class ViewControllerPost: ViewController {
    private var posts = [PostModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView(for: self)
        setupView()
    }
    
    func setupView() {
        tableView.register(PostCell.self)
//        posts = [Mocks.post]
        tableView.reloadData()
    }
}

//extension ViewControllerPost: TableViewMethods {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return posts.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.getCell(PostCell.self, with: indexPath) as? PostCell else {
//            return UITableViewCell()
//        }
//
//        cell.setup(with: posts[indexPath.row])
//        return cell
//    }
//}

// MARK: Profile
//final class ViewControllerProfile: ViewController {
//    private var profile: Model.Profile?
//    private var profileInformations: [ProfileInformation]?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupTableView(for: self)
//        setupView()
//    }
//
//    func setupView() {
//        tableView.register(ProfileCell.self)
//        tableView.register(ProfileInformationsCell.self)
//
//        profile = Mocks.profile
//        profileInformations = Mocks.profileInformations
//
//        tableView.reloadData()
//    }
//}
//
//extension ViewControllerProfile: TableViewMethods {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 2
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        switch indexPath.row {
//        case 0:
//            guard let cell = tableView.getCell(ProfileCell.self, with: indexPath) as? ProfileCell,
//                  let profile = profile else {
//                return UITableViewCell()
//            }
//
//            cell.setup(with: profile)
//            return cell
//        default:
//            guard let cell = tableView.getCell(ProfileInformationsCell.self, with: indexPath) as? ProfileInformationsCell,
//                  let profile = profileInformations else {
//                return UITableViewCell()
//            }
//
//            cell.setup(with: profile)
//            return cell
//        }
//    }
//}
//
//// MARK: ProfileInformations
//final class ViewControllerProfileInformations: ViewController {
//    private var profileInformations: [InformationModel]?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupTableView(for: self)
//        setupView()
//    }
//
//    func setupView() {
//        tableView.register(ProfileInformationsCell.self)
//        profileInformations = Mocks.profileInformations
//        tableView.reloadData()
//    }
//}
//
//extension ViewControllerProfileInformations: TableViewMethods {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.getCell(ProfileInformationsCell.self, with: indexPath) as? ProfileInformationsCell else {
//            return UITableViewCell()
//        }
//
//        if let profile = profileInformations {
//            cell.setup(with: profile)
//        }
//
//        return cell
//    }
//}
