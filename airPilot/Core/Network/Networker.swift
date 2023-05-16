//
//  Networker.swift
//  airPilot
//
//  Created by Eryk Chrustek on 31/10/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import Foundation
import Combine
import UIKit

typealias Handler = (Result<Data, Error>) -> Void

enum HTTPMethod {
    static let post: String = "POST"
    static let get: String = "GET"
}

class Token {
    static var shared = Token()
    var token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyVXVpZCI6IjBhNjg2MDJmLTUxZWQtNDNkMy04ZjRiLTZlNmUxNzg1YjNjOSIsImlhdCI6MTY3NjEyNTkzMywiZXhwIjoxNjc4NzE3OTMzfQ.rHzJEeMugTZwTdXB_dDdtpmLQ0nezaea-e2dk4Fk8cQ"
}

protocol Response {
    associatedtype ResponseType
    func response(for data: Data) throws -> ResponseType
}

struct JSONResponse<response: Decodable>: Response {
    typealias ResponseType = response

    func response(for data: Data) throws -> ResponseType {
        let decoder = JSONDecoder()
        return try decoder.decode(ResponseType.self, from: data)
    }
}

class Networker {
    enum Constant {
        static let applicationJson: String = "application/json"
        static let contentType: String = "Content-Type"
        static let accept: String = "Accept"
        static let xApikey: String = "x-apikey"
        static let authorization: String = "Authorization"
        static let formData: String = "multipart/form-data; boundary="
    }
    
    static func sendRequest<D: Decodable>(request: Encodable? = nil, response: D.Type, url: String, then completion: @escaping (Result<D?, Error>) -> Void) {
        guard let fullUrl = URL(string: Endpoints.Common.server + url) else {
            return Logger.log("Invalid URL.")
        }
        
        let encoder = JSONEncoder()
        var requestURL = URLRequest(url: fullUrl)
        requestURL.addValue(Endpoints.Common.server, forHTTPHeaderField: Constant.xApikey)
        requestURL.addValue(Token.shared.token, forHTTPHeaderField: Constant.authorization)
        
        if let request {
            requestURL.addValue(Constant.applicationJson, forHTTPHeaderField: Constant.contentType)
            requestURL.addValue(Constant.applicationJson, forHTTPHeaderField: Constant.accept)
            requestURL.httpMethod = HTTPMethod.post
            
            do {
                guard let request = try? request.asDictionary(encoder: encoder) as? [String: Any] else { return }
                requestURL.httpBody = try JSONSerialization.data(withJSONObject: request, options: .prettyPrinted)
            } catch let error {
                Logger.log(error.localizedDescription)
            }
        }

        URLSession.shared.dataTask(with: requestURL) { data, response, error in
            do {
                guard let data = data else {
                    completion(.success(nil))
                    return
                }
                
                Logger.response(
                    for: url,
                    with: try JSONSerialization.jsonObject(
                        with: data,
                        options: JSONSerialization.ReadingOptions()))
                let decoder = try JSONResponse<D>().response(for: data)
                DispatchQueue.main.async {
                    completion(.success(decoder))
                }
            } catch let error {
                Logger.log(error)
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    static func sendRequest<D: Decodable>(request: Encodable? = nil, response: D.Type, isFile: Bool = false, images: [UIImage], url: String, then completion: @escaping (Result<D?, Error>) -> Void) {
        guard let fullUrl = URL(string: Endpoints.Common.server + url) else {
            return Logger.log("Invalid URL.")
        }
        
        let boundary = generateBoundaryString()
        var requestURL = URLRequest(url: fullUrl)
        
        requestURL.addValue((Constant.formData + boundary), forHTTPHeaderField: Constant.contentType)
        requestURL.addValue(Token.shared.token, forHTTPHeaderField: Constant.authorization)
        
        requestURL.httpBody = createBody(for: images, isFile: isFile, with: request, and: boundary)
        requestURL.httpMethod = HTTPMethod.post
        
        URLSession.shared.dataTask(with: requestURL) { data, response, error in
            do {
                guard let data = data else {
                    completion(.success(nil))
                    return
                }
                
                Logger.response(
                    for: url,
                    with: try JSONSerialization.jsonObject(
                        with: data,
                        options: JSONSerialization.ReadingOptions()))
            
                let decoder = try JSONResponse<D>().response(for: data)
                DispatchQueue.main.async {
                    completion(.success(decoder))
                }
            } catch let error {
                Logger.log(error)
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    static func createBody(for images: [UIImage], isFile: Bool, with request: Encodable?, and boundary: String) -> Data {
        let encoder = JSONEncoder()
        var body = Data()
        
        images.forEach { image in
            if let fileData = image.jpegData(compressionQuality: 1) {
                let name = UUID().uuidString
                let filename = "\(name).jpg"
                let mimetype = "image/jpg"
                let paramName = isFile ? "file" : "files"
                
                body.append("--\(boundary)\r\n")
                body.append("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"\(filename)\"\r\n")
                body.append("Content-Type: \(mimetype)\r\n\r\n")
                body.append(fileData)
                body.append("\r\n")
            }
        }
        
        if let params = try? request?.asDictionary(encoder: encoder) as? [String: Any] {
            for param in params {
                let paramName = param.key
                body.append("--\(boundary)\r\n")
                body.append("Content-Disposition:form-data; name=\"\(paramName)\"")
                
                let paramValue = "\(param.value)"
                body.append("\r\n\r\n\(paramValue)\r\n")
            }
        }
        
        body.append("--\(boundary)--\r\n")
        
        return body
    }

//    static func sendRequest<D: Decodable>(request: Encodable? = nil, response: D.Type, with image: UIImage, path: String, then completion: @escaping (Result<D?, Error>) -> Void) {
//        guard let url = URL(string: Endpoints.Common.server + path) else {
//           return Logger.log("Invalid URL.")
//        }
//
//        var request = URLRequest(url: url)
//        let boundary = generateBoundaryString()
//        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
//
//        request.httpMethod = "POST"
//        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//        request.addValue(Token.shared.token, forHTTPHeaderField: "Authorization")
//
//        request.httpBody = createBodyWithParameters(
//            parameters: [:],
//            filePathKey: "file",
//            imageDataKey: imageData,
//            boundary: boundary,
//            imgKey: NSUUID().uuidString)
//
//        URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
//            do {
//                guard let data = data else {
//                completion(.success(nil))
//                return
//            }
//            Logger.response(
//            for: path,
//            with: try JSONSerialization.jsonObject(
//               with: data,options: JSONSerialization.ReadingOptions()))
//
//            let decoder = try JSONResponse<D>().response(for: data)
//            DispatchQueue.main.async {
//                completion(.success(decoder))
//            }
//            } catch let error {
//                Logger.log(error)
//                DispatchQueue.main.async {
//                    completion(.failure(error))
//                }
//            }
//        }.resume()
//    }
//
//    static func sendRequest(with image: UIImage, path: String) {
//        guard let url = NSURL(string: Endpoints.Common.server + path) as? URL else { return }
//        let request = NSMutableURLRequest(url: url)
//        let boundary = generateBoundaryString()
//
//        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
//        request.httpMethod = HTTPMethod.post
//        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//        request.addValue(Token.shared.token, forHTTPHeaderField: "Authorization")
//
//        request.httpBody = createBodyWithParameters(
//            parameters: [:],
//            filePathKey: "file",
//            imageDataKey: imageData,
//            boundary: boundary,
//            imgKey: NSUUID().uuidString)
//
//        let task = URLSession.shared.dataTask(with: request as URLRequest) {
//            data, response, error in
//
//            if error != nil {
//                print("error=\(error!)")
//                return
//            }
//
//            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
//            print("response data = \(responseString!)")
//        }
//
//        task.resume()
//    }
    
//    static func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: Data, boundary: String, imgKey: String) -> Data {
//        var body = Data()
//
//        if parameters != nil {
//            for (key, value) in parameters! {
//                body.append("--\(boundary)\r\n")
//                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
//                body.append("\(value)\r\n")
//            }
//        }
//
//        let filename = "\(imgKey).jpg"
//        let mimetype = "image/jpg"
//
//        body.append("--\(boundary)\r\n")
//        body.append("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
//        body.append("Content-Type: \(mimetype)\r\n\r\n")
//        body.append(imageDataKey)
//        body.append("\r\n")
//
//        body.append("--\(boundary)--\r\n")
//
//        return body
//    }

    static func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
}

extension NSMutableData {
    func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}

extension Encodable {
    func asDictionary(encoder: JSONEncoder) throws -> [AnyHashable: Any] {
        let data = try encoder.encode(self)
        let dictrionary = try JSONSerialization.jsonObject(with: data)
        let result = dictrionary as? [AnyHashable: Any] ?? [:]
        return result
    }
}

public struct MultipartRequest {
    public let boundary: String
    private let separator: String = "\r\n"
    var data: Data

    public init(boundary: String = UUID().uuidString) {
        self.boundary = boundary
        self.data = .init()
    }
    
    private mutating func appendBoundarySeparator() {
        data.append("--\(boundary)\(separator)")
    }
    
    private mutating func appendSeparator() {
        data.append(separator)
    }

    private func disposition(_ key: String) -> String {
        "Content-Disposition: form-data; name=\"\(key)\""
    }

    public mutating func add(
        key: String,
        value: String
    ) {
        appendBoundarySeparator()
        data.append(disposition(key) + separator)
        appendSeparator()
        data.append(value + separator)
    }

    public mutating func add(
        key: String,
        fileName: String,
        fileMimeType: String,
        fileData: Data
    ) {
        appendBoundarySeparator()
        data.append(disposition(key) + "; files=\"\(fileName)\"" + separator)
        data.append("Content-Type: \(fileMimeType)" + separator + separator)
        data.append(fileData)
        appendSeparator()
    }

    public var httpContentTypeHeadeValue: String {
        "multipart/form-data; boundary=\(boundary)"
    }

    public var httpBody: Data {
        var bodyData = data
        bodyData.append("--\(boundary)--")
        return bodyData
    }
}

public extension Data {
    mutating func append(_ string: String, encoding: String.Encoding = .utf8) {
        guard let data = string.data(using: encoding) else { return }
        append(data)
    }
}
