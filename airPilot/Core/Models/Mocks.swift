//
//  Mocks.swift
//  airPilot
//
//  Created by Eryk Chrustek on 25/06/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation

struct Mocks {
    static let loremIpsum = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer industry's typesetting."
    
//    static let post = PostModel(
//        text: Mocks.loremIpsum,
//        date: .now,
//        likedBy: ["asdafasf"])
    
//    static let company = CompanyModel(
//        background: Mocks.Images.plane,
//        logo: Mocks.Images.logo,
//        name: "Lufthansa",
//        industry: "Airlines and aviation")
    
//    static let user = UserModel(
//        email: "adela.parkson@gmail.com",
//        firstName: "Adela",
//        lastName: "Parkson",
//        avatar: Mocks.Images.avatar,
//        position: "First Officer B737",
//        company: "Lufthansa")
    
//    static let education = EducationModel(
//        startDate: "asdds",
//        endDate: "asasd",
//        degree: "Bachelor degree",
//        fieldStudy: "Aviation Menagement",
//        name: "Stanford University",
//        place: "USA, Stanford")
//    
//    static let language = LanguageModel(
//        name: "English",
//        level: "C1")
//    
//    static let profile = ProfileModel(
//        background: Mocks.Images.plane,
//        dateBirth: "22.02.1993",
//        posts: 17,
//        friends: 84,
//        followers: 324,
//        education: [Mocks.education],
//        languages: [Mocks.language])
    
    static let profileInformations = [
        InformationModel(
            title: "Education",
            description: "Stanford University"),
        InformationModel(
            title: "Languages",
            description: "English, Spanish, Italian, English, Spanish, Italian"),
        InformationModel(
            title: "Birthday",
            description: "20 July 1986"),
        InformationModel(
            title: "Nationality",
            description: "Poland")]
    
    static let planeInformations = [
        InformationModel(
            title: "Country",
            description: "Greece"),
        InformationModel(
            title: "Location",
            description: "Paleokastritsa 254"),
        InformationModel(
            title: "Price",
            description: "1 200 PLN / 24H")]
    
    static let jobInformations = [
        InformationModel(
            title: "Added",
            description: "2 days ago"),
        InformationModel(
            title: "Company size",
            description: "13 000 employees"),
        InformationModel(
            title: "Applied",
            description: "3 candidates"),
        InformationModel(
            title: "Employment type",
            description: "Full Time")]
    
//    static let planeOffer = PlaneOfferModel(
//        description: "",
//        favourites: [],
//        images: [],
//        location: Locations.second,
//        name: "",
//        ownerId: 1,
//        price: .init(amount: 240, currency: .pln),
//        type: .rent)
    
    struct Locations {
        static let first = Location(
            country: .poland,
            region: "",
            street: "Kraków",
            buildingNumber: nil,
            flatNumber: nil)
        
        static let second = Location(
            country: .greece,
            region: "",
            street: "Corfu",
            buildingNumber: "23",
            flatNumber: "42")
    }

//    static let apartmentOffer = ApartmentOfferModel(
//        description: "",
//        favourites: [],
//        images: [],
//        ownerId: "",
//        location: Locations.second,
//        price: .init(amount: 240, currency: .pln),
//        ratingList: ["someId" : 250.0],
//        type: .daily)
    
//    static let jobOffer = JobOfferModel(
//        company: Mocks.company,
//        category: .stewardess,
//        position: "First Officer A320",
//        salary: .init(
//            min: .init(amount: 12000, currency: .pln),
//            max: .init(amount: 29000, currency: .pln)))
//
//    static let jobDate = JobModel(
//        companyId: "lufthansa",
//        logo: Images.logo,
//        companyName: "Lufthansa",
//        position: "First Officer",
//        salary: nil,
//        createdDate: Date(),
//        startDate: Date(),
//        endDate: Date())
//    
//    static let jobSalary = JobModel(
//        companyId: "lufthansa",
//        logo: Images.logo,
//        companyName: "Lufthansa",
//        position: "First Officer",
//        salary: .init(
//            min: .init(amount: 12000, currency: .pln),
//            max: .init(amount: 29000, currency: .pln)),
//        createdDate: Date(),
//        startDate: Date(),
//        endDate: Date())
    
    struct Images {
        static let logo = "https://www.travelinsightpedia.com/wp-content/uploads/2021/02/9a875657843389.Y3JvcCwxNzU0LDEzNzMsMTg2LDIxNg.jpg"
        static let avatar = "https://dm.henkel-dam.com/is/image/henkel/men_perfect_com_thumbnails_home_pack_400x400-wcms-international?scl=1&fmt=jpg"
        static let secondAvatar = "https://images.ctfassets.net/58lxv11v4e56/6iFigQT9STN3P8JQTF6c4K/348a12501c4b02b7272e3e90b9af3001/psp-fehr-face-mini-hair-remover-kindonskin-sp.jpg"
        static let plane = "https://cdn.mos.cms.futurecdn.net/Tpwmmfo3CiAJvwd4vXGzvn-1920-80.jpg"
        static let apartment = "https://handluggageonly.co.uk/wp-content/uploads/2014/12/10636356_10152316584452301_6059307931680542623_o.jpg"
    }
}
