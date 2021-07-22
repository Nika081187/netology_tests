//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by v.milchakova on 05.12.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell, Themeable {
    let baseOffset: CGFloat =  16
    
    public func configure(post: Post){
        nameLabel.text = post.author
        postImage.image = post.image
        descriptionLabel.text = post.description
        likesLabel.text = "Likes: \(post.likes)"
        viewsLabel.text = "Views: \(post.views)"
    }

    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.toAutoLayout()
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        nameLabel.numberOfLines = 2
        return nameLabel
    }()
    
    private lazy var postImage: UIImageView = {
        let postImage = UIImageView()
        postImage.toAutoLayout()
        postImage.contentMode = .scaleAspectFit
        return postImage
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.toAutoLayout()
        descriptionLabel.font = descriptionLabel.font.withSize(14)
        descriptionLabel.numberOfLines = 0
        return descriptionLabel
    }()
    
    private lazy var likesLabel: UILabel = {
        let likesLabel = UILabel()
        likesLabel.toAutoLayout()
        likesLabel.font = descriptionLabel.font.withSize(16)
        return likesLabel
    }()
    
    private lazy var viewsLabel: UILabel = {
        let viewsLabel = UILabel()
        viewsLabel.toAutoLayout()
        viewsLabel.font = descriptionLabel.font.withSize(16)
        return viewsLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        changeTheme(traitCollection.userInterfaceStyle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(postImage)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(viewsLabel)
        contentView.addSubview(likesLabel)
        
        let constraint =  [
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: baseOffset),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: baseOffset),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -(baseOffset)),

            postImage.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
            postImage.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            postImage.heightAnchor.constraint(equalTo: contentView.widthAnchor),
            postImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            descriptionLabel.leadingAnchor.constraint(equalTo: postImage.leadingAnchor, constant: baseOffset),
            descriptionLabel.trailingAnchor.constraint(equalTo: postImage.trailingAnchor, constant: -(baseOffset)),
            descriptionLabel.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: baseOffset),
            
            likesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            likesLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -(baseOffset)),
            
            viewsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            viewsLabel.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            viewsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -(baseOffset))]
        
        NSLayoutConstraint.activate(constraint)
    }
    
    func changeTheme(_ theme: UIUserInterfaceStyle) {
        if theme == .dark {
            nameLabel.textColor = .white
            postImage.backgroundColor = .black
            descriptionLabel.textColor = .white
            likesLabel.textColor = .white
            imageView?.backgroundColor = .black
        } else {
            nameLabel.textColor = .black
            postImage.backgroundColor = .white
            descriptionLabel.textColor = .black
            likesLabel.textColor = .black
            imageView?.backgroundColor = .white
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
}
