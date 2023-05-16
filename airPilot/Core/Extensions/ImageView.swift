//
//  ImageView.swift
//  airPilot
//
//  Created by Eryk Chrustek on 18/06/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFill) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                  let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                  let data = data, error == nil,
                  let image = UIImage(data: data) else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    func getImage(from name: String?, contentMode mode: ContentMode = .scaleAspectFill) {
        guard let name, let url = URL(string: Endpoints.Common.image + name) else {
            image = Image.empty
            contentMode = .scaleAspectFill
            return
        }
        
        downloaded(from: url, contentMode: mode)
    }
}

typealias File = String

extension UIImage {
    var base64JPEG: String? {
        self.jpegData(compressionQuality: 0.45)?.base64EncodedString(options: .endLineWithLineFeed)
    }
    
    func createBase64Image(name: String) -> File? {
        let data: Data? = self.jpegData(compressionQuality: 0.5)
        guard let content = data?.base64EncodedString(options: .endLineWithLineFeed) else { return nil }
        return content
    }
    
    func getFileSize() -> Double {
        guard let data = self.pngData() else { return 0 }
        return Double(data.count) / 1000000
    }
    
    func getSmallerSize(with percentage: CGFloat) -> UIImage? {
        let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
        let format = imageRendererFormat
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
    
    static func getImageInCorrectSize(_ image: UIImage) -> UIImage {
        let size = image.getFileSize()
        if size > 15, let firstSmallerImage = image.getSmallerSize(with: 0.28) {
            if firstSmallerImage.getFileSize() > 2, let secondSmallerImage = firstSmallerImage.getSmallerSize(with: 0.7) {
                if secondSmallerImage.getFileSize() > 2, let thirdSmallerImage = secondSmallerImage.getSmallerSize(with: 0.5) {
                    return thirdSmallerImage
                } else {
                    return secondSmallerImage
                }
            } else {
                return firstSmallerImage
            }
        } else if size > 8, let firstSmallerImage = image.getSmallerSize(with: 0.35) {
            if firstSmallerImage.getFileSize() > 2, let secondSmallerImage = firstSmallerImage.getSmallerSize(with: 0.8) {
                if secondSmallerImage.getFileSize() > 2, let thirdSmallerImage = secondSmallerImage.getSmallerSize(with: 0.7) {
                    return thirdSmallerImage
                } else {
                    return secondSmallerImage
                }
            } else {
                return firstSmallerImage
            }
        } else if size > 4, let firstSmallerImage = image.getSmallerSize(with: 0.5) {
            if firstSmallerImage.getFileSize() > 2, let secondSmallerImage = firstSmallerImage.getSmallerSize(with: 0.8) {
                if secondSmallerImage.getFileSize() > 2, let thirdSmallerImage = secondSmallerImage.getSmallerSize(with: 0.7) {
                    return thirdSmallerImage
                } else {
                    return secondSmallerImage
                }
            } else {
                return firstSmallerImage
            }
        } else if size > 2, let firstSmallerImage = image.getSmallerSize(with: 0.6) {
            return firstSmallerImage
        } else {
            return image
        }
    }
    
    static func getImagesInCorrectSize(_ images: [UIImage]) -> [UIImage] {
        return images.map { image in
            return UIImage.getImageInCorrectSize(image)
        }
    }
}

extension [UIImage]? {
    var orEmpty: [UIImage] {
        return self ?? []
    }
}
