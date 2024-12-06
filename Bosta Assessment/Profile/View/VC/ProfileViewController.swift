//  Bosta Assessment
//  ProfileViewController.swift
//  Created by Ahmed Yasein on 03/12/2024.
//
import UIKit
import Combine

class ProfileViewController: UIViewController {
    private var viewModel = ProfileViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    // Declare UI components programmatically
    private let nameLabel = UILabel()
    private let addressLabel = UILabel()
    private let albumsTableView = UITableView()
    private let albumsTitleLabel = UILabel()
    private let loadingIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ProfileViewController init")
        setupNavigationBar()
        setupUI()
        setupBindings()
        viewModel.fetchUserData()
    }
    
    // Setup navigation bar with custom title aligned to leading
    private func setupNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = Constants.Titles.profileTitle
        titleLabel.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.sizeToFit()
        
        let leftItem = UIBarButtonItem(customView: titleLabel)
        navigationItem.leftBarButtonItem = leftItem
    }
    // Setup UI components and constraints programmatically
    private func setupUI() {
        view.backgroundColor = .white
        
        // Configure nameLabel
        nameLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        nameLabel.textAlignment = .left
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        // Configure addressLabel
        addressLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        addressLabel.textAlignment = .left
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addressLabel)
        
        // Configure albumsTitleLabel
        albumsTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        albumsTitleLabel.text = Constants.Titles.albumsTitle
        albumsTitleLabel.textAlignment = .left
        albumsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(albumsTitleLabel)
        
        // Configure albumsTableView
        albumsTableView.dataSource = self
        albumsTableView.delegate = self
        albumsTableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.CellIdentifiers.albumCell)
        albumsTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(albumsTableView)
        
        // Configure loadingIndicator
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.hidesWhenStopped = true
        view.addSubview(loadingIndicator)
        
        // Layout using Auto Layout
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            addressLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            albumsTitleLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 20),
            albumsTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            albumsTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            albumsTableView.topAnchor.constraint(equalTo: albumsTitleLabel.bottomAnchor, constant: 10),
            albumsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            albumsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            albumsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // Centering the loading indicator
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    // Setup Combine bindings to update UI when the data changes
    private func setupBindings() {
        // Binding user data to update the labels
        viewModel.$user
            .sink { [weak self] user in
                DispatchQueue.main.async {
                    self?.nameLabel.text = user?.name ?? "No Name"
                    
                    if let address = user?.address {
                        let fullAddress = """
                            \(address.street) \(address.suite)
                            \(address.city), \(address.zipcode)
                            """
                        self?.addressLabel.text = fullAddress
                    } else {
                        self?.addressLabel.text = "No Address"
                    }
                    
                    self?.addressLabel.numberOfLines = 0
                }
            }
            .store(in: &cancellables)


        // Binding album data to reload the table view
        viewModel.$albums
            .sink { [weak self] albums in
                DispatchQueue.main.async {
                    self?.albumsTableView.reloadData()
                }
            }
            .store(in: &cancellables)
        
        // Binding loading state to show/hide the loading indicator
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
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.albums.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.albumCell, for: indexPath)
        let album = viewModel.albums[indexPath.row]
        cell.textLabel?.text = album.title
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let album = viewModel.albums[indexPath.row]
        
        let albumDetailVC = AlbumDetailsViewController()
        albumDetailVC.albumId = album.id 
        albumDetailVC.albumTitle = album.title
        navigationController?.pushViewController(albumDetailVC, animated: true)
    }
}
