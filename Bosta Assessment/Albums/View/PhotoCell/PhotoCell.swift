//
//  PhotoCell.swift
//  Bosta Assessment
//
//  Created by Ahmed Yasein on 03/12/2024.
//


import UIKit
class PhotoCell: UICollectionViewCell {
    var imageView: UIImageView!
    var loader: UIActivityIndicatorView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        
        // Set up AutoLayout for the image view
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        // Add the loader
        loader = UIActivityIndicatorView(style: .medium)
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        contentView.addSubview(loader)
        
        // Center the loader within the cell
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    // Method to update the cell's image and control loader
    func configure(with photo: Photo) {
        loader.startAnimating()
        
        imageView.sd_setImage(with: URL(string: photo.thumbnailUrl), placeholderImage: UIImage(named: Constants.Images.placeholderImage), options: .highPriority) { [weak self] (_, _, _, _) in
            self?.loader.stopAnimating()
        }
    }
}
