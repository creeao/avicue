//
//  ImagesPickerCell.swift
//  airPilot
//
//  Created by Eryk Chrustek on 17/11/2022.
//

import UIKit

protocol ImagesPickerCellDelegate: AnyObject {
    func addPhotos()
}

class ImagesPickerCell: CustomTableViewCell {
    // MARK: External properties
    weak var delegate: ImagesPickerCellDelegate?
    
    // MARK: Private properties
    private let nonePhotosStackView = UIStackView()
    private let iconView = UIImageView()
    private let firstLabel = UILabel()
    private let secondLabel = UILabel()
    
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private var pickedImages: [PickedImageView] = []
    
    private let pickerInListContainer = UIView()
    private let pickerInListStackView = UIStackView()
    private let pickerInListIconView = UIImageView()
    private let pickerInListLabel = UILabel()
    
    // MARK: Life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        containerView.setupDashedBorder()
        pickerInListContainer.setupDashedBorder()
    }
}

// MARK: External methods
extension ImagesPickerCell {
    func appendPhotos(_ images: [UIImage]) {
        images.forEach { image in
            let pickedImage = PickedImageView()
            pickedImage.delegate = self
            pickedImage.setup(image, id: image.description)
            pickedImages.append(pickedImage)
            stackView.addArrangedSubview(pickedImage)
        }
        
        handleView()
    }
    
    func getImages() -> [UIImage] {
        return pickedImages.compactMap { $0.getImage() }
    }
}

extension ImagesPickerCell: PickedImageViewDelegate {
    func removePhoto(id: String) {
        pickedImages.removeAll(where: { $0.getId() == id })
        stackView.arrangedSubviews
            .filter({ ($0 as? PickedImageView)?.getId() == id })
            .forEach({ $0.removeFromSuperview() })
        
        handleView()
    }
}

// MARK: Events
private extension ImagesPickerCell {
    @objc func addPhotos() {
        delegate?.addPhotos()
    }
}

// MARK: Private methods
private extension ImagesPickerCell {
    func setupView() {
        setupContainerView()
        setupNonePhotosStackView()
        
        setupScrollView()
        setupStackView()
        setupPickerInListContainer()
        handleView()
    }
    
    func setupNonePhotosStackView() {
        containerView.addSubview(nonePhotosStackView)
        nonePhotosStackView.translatesAutoresizingMaskIntoConstraints = false
        nonePhotosStackView.axis = .vertical
        nonePhotosStackView.alignment = .center
        
        let action = UITapGestureRecognizer(target: self, action: #selector(addPhotos))
        nonePhotosStackView.addGestureRecognizer(action)
        nonePhotosStackView.isUserInteractionEnabled = true
        
        NSLayoutConstraint.activate([
            nonePhotosStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Margin.big.top),
            nonePhotosStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Margin.normal.leading),
            nonePhotosStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: Margin.normal.trailing),
            nonePhotosStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: Margin.big.bottom)
        ])
        
        setupIconView()
        setupFirstLabel()
        setupSecondLabel()
    }
    
    func setupIconView() {
        nonePhotosStackView.addArrangedSubview(iconView)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        
        let action = UITapGestureRecognizer(target: self, action: #selector(addPhotos))
        iconView.addGestureRecognizer(action)
        iconView.isUserInteractionEnabled = true
        
        iconView.image = Image.addPhoto
        iconView.set(width: 30, height: 30)
        nonePhotosStackView.setCustomSpacing(Margin.small.space, after: iconView)
    }
    
    func setupFirstLabel() {
        nonePhotosStackView.addArrangedSubview(firstLabel)
        firstLabel.translatesAutoresizingMaskIntoConstraints = false
        
        firstLabel.font = Font.bigSemiBold
        firstLabel.textColor = Color.black
        firstLabel.text = "Add photos"
        nonePhotosStackView.setCustomSpacing(Margin.mini.space, after: firstLabel)
    }
    
    func setupSecondLabel() {
        nonePhotosStackView.addArrangedSubview(secondLabel)
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        
        secondLabel.font = Font.smallMedium
        secondLabel.textColor = Color.gray
        secondLabel.text = "Maximum number of photos is 8"
    }
    
    func setupScrollView() {
        contentView.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentInset = Insets.setup(
            left: Margin.normal.space,
            right: Margin.normal.space)
        scrollView.scrollIndicatorInsets = Insets.setup(
            left: Margin.normal.space,
            right: Margin.normal.space)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setupStackView() {
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = Margin.small.space
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    func handleView() {
        stackView.isHidden = pickedImages.isEmpty
        scrollView.isHidden = pickedImages.isEmpty
        containerView.isHidden = pickedImages.isNotEmpty
    }
    
    func setupPickerInListContainer() {
        pickerInListContainer.set(width: 130, height: 130)
        pickerInListContainer.addSubview(pickerInListStackView)
        pickerInListStackView.translatesAutoresizingMaskIntoConstraints = false
        pickerInListStackView.axis = .vertical
        pickerInListStackView.alignment = .center
        
        let action = UITapGestureRecognizer(target: self, action: #selector(addPhotos))
        pickerInListContainer.addGestureRecognizer(action)
        pickerInListContainer.isUserInteractionEnabled = true
        
        pickerInListStackView.addGestureRecognizer(action)
        pickerInListStackView.isUserInteractionEnabled = true
        
        NSLayoutConstraint.activate([
            pickerInListStackView.centerYAnchor.constraint(equalTo: pickerInListContainer.centerYAnchor),
            pickerInListStackView.centerXAnchor.constraint(equalTo: pickerInListContainer.centerXAnchor)
        ])
        
        setupPickerInListIcon()
        setupPickerInListLabel()
        
        stackView.addArrangedSubview(pickerInListContainer)
    }
    
    func setupPickerInListIcon() {
        pickerInListStackView.addArrangedSubview(pickerInListIconView)
        pickerInListIconView.translatesAutoresizingMaskIntoConstraints = false
        
        pickerInListIconView.image = Image.addPhoto
        pickerInListIconView.set(width: 30, height: 30)
        pickerInListStackView.setCustomSpacing(Margin.small.space, after: pickerInListIconView)
        
//        let action = UITapGestureRecognizer(target: self, action: #selector(addPhotos))
        
        pickerInListIconView.addGesture(self, #selector(addPhotos))
        
//        pickerInListIconView.addGestureRecognizer(action)
//        pickerInListIconView.isUserInteractionEnabled = true
    }
    
    func setupPickerInListLabel() {
        pickerInListStackView.addArrangedSubview(pickerInListLabel)
        pickerInListLabel.translatesAutoresizingMaskIntoConstraints = false
        
        pickerInListLabel.font = Font.bigSemiBold
        pickerInListLabel.textColor = Color.black
        pickerInListLabel.text = "Add photos"
    }
}
