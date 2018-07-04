//
//  PhotoCell.swift
//  FlickrSample
//
//  Created by Dylan Bruschi on 7/2/18.
//  Copyright © 2018 Dylan Bruschi. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    var userAuthorized = false
    
    var photo: PhotoData.Photo? {
        didSet {
            guard let photoImageUrl = photo?.media?.image  else { return }
            photoImageView.loadImage(urlString: photoImageUrl)
            
            usernameLabel.text = photo?.author
            
            tagsView.text = photo?.tags
            
            setupAttributedCaption()
        }
    }
    
    lazy var photoImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(handlePhotoImageViewTapped))
        iv.addGestureRecognizer(tap)
        return iv
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    lazy var optionsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("•••", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(handleOptionsButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var tagsButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .darkGreen
        button.setTitle("Set Tags", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 7
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleTagsButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let tagsView: UITextView = {
        let tv = UITextView()
        tv.layer.borderColor = UIColor.darkGreen.cgColor
        tv.layer.borderWidth = 1.0
        tv.layer.cornerRadius = 7
        tv.clipsToBounds = true
        tv.backgroundColor = .white
        tv.isEditable = false
        tv.textColor = .gray
        return tv
    }()
    
    let descriptionTimeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .lightGreen
        
        addSubview(usernameLabel)
        addSubview(photoImageView)
        addSubview(optionsButton)
     
        
        usernameLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: optionsButton.leftAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 40)
        
        optionsButton.anchor(top: topAnchor, left: nil, bottom: photoImageView.topAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 44, height: 0)
        
        photoImageView.anchor(top: usernameLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        photoImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        
        
        
        

        let tagsStackView = UIStackView(arrangedSubviews: [tagsButton, tagsView])

        tagsStackView.axis = .horizontal
        tagsStackView.distribution = .fill
        tagsStackView.spacing = 8
        
        let detailsStackView = UIStackView(arrangedSubviews: [descriptionTimeLabel, tagsStackView])
        
        detailsStackView.axis = .vertical
        detailsStackView.distribution = .fillEqually
        detailsStackView.spacing = 4
        
        addSubview(detailsStackView)


        tagsButton.widthAnchor.constraint(equalToConstant: 64).isActive = true

        detailsStackView.anchor(top: photoImageView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 4, paddingLeft: 8, paddingBottom: 8, paddingRight: 8, width: 0, height: 0)
        

        if userAuthorized {
            tagsButton.isHidden = false
        } else {
        tagsButton.isHidden = true
        }
    
    }
    
    fileprivate func setupAttributedCaption() {
        guard let photo = photo else { return }
        
        let author = photo.author ?? ""
        
        let attributedText = NSMutableAttributedString(string: author, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
        
        let title = photo.title ?? ""
        
        attributedText.append(NSAttributedString(string: " \(title)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]))
        
        attributedText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 4)]))
        
        let dateFormatter = ISO8601DateFormatter()
        
        let publishDateString = photo.published ?? ""
        
        if let publishDate = dateFormatter.date(from: publishDateString) {
        
        let timeAgoDisplay = publishDate.timeAgoDisplay()
        attributedText.append(NSAttributedString(string: timeAgoDisplay, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.gray]))
        }
            
        descriptionTimeLabel.attributedText = attributedText
    }
    
    @objc func handleTagsButtonTapped() {
        print("Tags button tapped")
    }
    
    @objc func handlePhotoImageViewTapped() {
        
        UIView.animate(withDuration: 0.25, delay: 0.1, usingSpringWithDamping: 0.4, initialSpringVelocity: 5, options: .curveEaseIn, animations: {
            self.photoImageView.transform = CGAffineTransform(scaleX: 0.65, y: 0.65)
        }) { (finished) in
            
            UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 5, options: .curveEaseOut, animations: {
                self.photoImageView.transform = CGAffineTransform.identity
            }, completion: nil)
        }
    }
    
    @objc func handleOptionsButtonTapped() {
        print("Options button tapped")
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
