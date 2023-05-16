//
//  Firebase.swift
//  airPilot
//
//  Created by Eryk Chrustek on 05/09/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//
//import Firebase
//import FirebaseCore
//import FirebaseAuth
//import FirebaseFirestore
//import FirebaseFirestoreSwift
//
//class Firebase {
//    static let auth = FirebaseAuth.Auth.auth()
//    static let firestore = Firestore.firestore()
//
//    static let users = firestore.collection(Path.users)
//    static let companies = firestore.collection(Path.companies)
//    static let jobOffers = firestore.collection(Path.jobOffers)
//    static let apartmentOffers = firestore.collection(Path.apartmentOffers)
//    static let planeOffers = firestore.collection(Path.planeOffers)
//    static let posts = firestore.collection(Path.posts)
//}
//
//// MARK: Authentication
//extension Firebase {
//    static func register(email: String, password: String, completion: @escaping (Result<Any, Error>) -> Void) {
//        auth.createUser(withEmail: email, password: password) { (result, error) in
//            if let result = result {
//                completion(.success(result))
//            } else if let error = error {
//                completion(.failure(error))
//            } else {
//                Logger.log("Unknow error.")
//            }
//        }
//    }
//
//    static func login(email: String, password: String, completion: @escaping (Result<Any, Error>) -> Void) {
//        auth.signIn(withEmail: email, password: password) { (result, error) in
//            if let result = result {
//                completion(.success(result))
//            } else if let error = error {
//                completion(.failure(error))
//            } else {
//                Logger.log("Unknow error.")
//            }
//        }
//    }
//}
//
//// MARK: Firestore
//extension Firebase {
//    static func getData(from collection: String, and document: String, completion: @escaping (Result<Any, Error>) -> Void) {
//        firestore.collection(collection).document(document).getDocument(completion: { (result, error) in
//            if let result = result {
//                completion(.success(result))
//            } else if let error = error {
//                completion(.failure(error))
//            } else {
//                Logger.log("Unknow error.")
//            }
//        })
//    }
//}
