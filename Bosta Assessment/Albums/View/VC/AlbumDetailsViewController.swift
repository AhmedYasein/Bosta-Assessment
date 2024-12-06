//  Bosta Assessment
//  AlbumDetailsViewController.swift
//  Created by Ahmed Yasein on 03/12/2024.
//

import UIKit
import Combine
import SDWebImage

class AlbumDetailsViewController: UIViewController, UISearchBarDelegate {
    var albumId: Int = 0
    private var viewModel = AlbumDetailsViewModel()
    private var cancellables = Set<AnyCancellable>()
    var albumTitle: String = ""
    
    private var collectionView: UICollectionView!
    private var searchBar: UISearchBar!
    private var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setupNavigationBar()
        setupTitleLabel()
        setupUI()
        setupCollectionViewLayout()
        setupBindings()
        viewModel.fetchPhotos(albumId: albumId)
    }

    private func setupNavigationBar() {
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.backgroundColor = .white
    }

    private func setupTitleLabel() {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = albumTitle
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        navigationItem.titleView = titleLabel
    }

    private func setupUI() {
        // Setup search bar
        searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = Constants.Search.SearchPhotos
        searchBar.delegate = self
        view.addSubview(searchBar)

        // Setup collection view
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: Constants.CellIdentifiers.photoCell)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)

        // Setup loading indicator
        loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.hidesWhenStopped = true
        view.addSubview(loadingIndicator)

        // Auto Layout constraints for UI components
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 50),

            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func setupCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width / 3 - 10, height: view.frame.width / 3 - 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        collectionView.setCollectionViewLayout(layout, animated: true)
    }

    private func setupBindings() {
        // Observe changes in the search query
        viewModel.$searchQuery
            .sink { [weak self] _ in
                self?.viewModel.filterPhotos()
                
                print("Filtered Photos: \(self?.viewModel.filteredPhotos.count ?? 0)")
            }
            .store(in: &cancellables)
            
        // Observe filtered photos and reload collection view when updated
        viewModel.$filteredPhotos
            .sink { [weak self] _ in
                self?.collectionView.reloadData()  
            }
            .store(in: &cancellables)

        // Observe loading state and show/hide loading indicator
        viewModel.$isLoading
            .sink { [weak self] isLoading in
                DispatchQueue.main.async {
                    if isLoading {
                        self?.loadingIndicator.startAnimating()
                    } else {
                        self?.loadingIndicator.stopAnimating()
                    }
                }
            }
            .store(in: &cancellables)
    }


    // UISearchBarDelegate method to handle text change
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchQuery = searchText
    }
}

extension AlbumDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.filteredPhotos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        let photo = viewModel.filteredPhotos[indexPath.row]
        cell.configure(with: photo)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = viewModel.filteredPhotos[indexPath.row]

        // Create and push ImageViewerViewController
        let imageViewerVC = ImageViewerViewController()
        imageViewerVC.imageUrl = photo.thumbnailUrl
        navigationController?.pushViewController(imageViewerVC, animated: true)
    }
}


