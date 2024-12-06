//  Bosta Assessment
//  ImageViewerViewController.swift
//  Created by Ahmed Yasein on 03/12/2024.
//

import UIKit
import SDWebImage

class ImageViewerViewController: UIViewController {
    var imageUrl: String!
    private var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageView()
        setupShareButton()
    }

    private func setupImageView() {
        // Setup ScrollView
        let scrollView = UIScrollView(frame: self.view.bounds)
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        scrollView.delegate = self
        self.view.addSubview(scrollView)
        
        // Setup ImageView
        imageView = UIImageView(frame: self.view.bounds)
        imageView.contentMode = .scaleAspectFit
        imageView.sd_setImage(with: URL(string: imageUrl))  // Load image using SDWebImage
        scrollView.addSubview(imageView)
    }
    
    private func setupShareButton() {
        // Add a Share button to the navigation bar
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareImage))
        navigationItem.rightBarButtonItem = shareButton
    }
    
    @objc private func shareImage() {
        // Convert the image to data
        guard let image = imageView.image else {
            print("Image not available for sharing.")
            return
        }

        let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)

        activityVC.excludedActivityTypes = [.addToReadingList, .postToFacebook]

        present(activityVC, animated: true, completion: nil)
    }
}

extension ImageViewerViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView 
    }
}
