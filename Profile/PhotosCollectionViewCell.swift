//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by v.milchakova on 16.12.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell, Themeable {
    private lazy var photoImage: UIImageView = {
        let photoImage = UIImageView()
        photoImage.toAutoLayout()
        photoImage.contentMode = .scaleAspectFit
        return photoImage
    }()
    
    public func configure(image: UIImage){
        photoImage.image = image
        photoImage.contentMode = .scaleToFill
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeTheme(_ theme: UIUserInterfaceStyle) {
        if theme == .dark {
            backgroundColor = .black
            contentView.backgroundColor = .black
        } else {
            backgroundColor = .white
            contentView.backgroundColor = .white
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        switch traitCollection.userInterfaceStyle {
        case .dark:
            changeTheme(.dark)
        case .light:
            changeTheme(.light)
        default:
            changeTheme(.light)
        }
    }
    
    func setupLayout() {
        addSubview(contentView)
        contentView.addSubview(photoImage)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),

            photoImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
        changeTheme(traitCollection.userInterfaceStyle)
    }
}
