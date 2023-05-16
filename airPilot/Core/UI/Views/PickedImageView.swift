//
//  PickedImageView.swift
//  airPilot
//
//  Created by Eryk Chrustek on 23/12/2022.
//

import UIKit

protocol PickedImageViewDelegate: AnyObject {
    func removePhoto(id: String)
}

final class PickedImageView: UIView {
    // MARK: External properties
    weak var delegate: PickedImageViewDelegate?
    
    // MARK: Private properties
//    private var id: Int = 0
    private var id: String = ""
    private let imageView = UIImageView()
    private let removeButton = Button()
    private var image: UIImage? = nil
    
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
extension PickedImageView {
    func setup(_ image: UIImage, id: String) {
        self.id = id
        self.image = image
        imageView.image = image
    }
    
    func getImage() -> UIImage? {
        return image
    }
    
    func getId() -> String {
        return id
    }
}

// MARK: Events
private extension PickedImageView {
    @objc func tapRemoveButton() {
        delegate?.removePhoto(id: id)
    }
}

// MARK: Private
private extension PickedImageView {
    func setupView() {
        setupImageView()
        setupRemoveButton()
    }
    
    func setupImageView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constants.cornerRadius
        imageView.set(width: 130, height: 130)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupRemoveButton() {
        addSubview(removeButton)
        removeButton.translatesAutoresizingMaskIntoConstraints = false
        removeButton.setup(for: .whiteImage, and: Image.closeButton)
        removeButton.addAction(self, #selector(tapRemoveButton))
        removeButton.set(width: 40, height: 40)
        
        NSLayoutConstraint.activate([
            removeButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            removeButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

extension UIControl {
    func addAction(_ target: Any?, _ action: Selector) {
        addTarget(target, action: action, for: .touchUpInside)
    }
}
