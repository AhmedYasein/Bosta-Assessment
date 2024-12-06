//  Bosta Assessment
//  ProfileViewModel.swift
//  Created by Ahmed Yasein on 03/12/2024.
//

import Foundation
import Combine

class ProfileViewModel {
    private var cancellables = Set<AnyCancellable>()
    
    @Published var user: User?
    @Published var albums: [Album] = []
    @Published var isLoading: Bool = false
    
    // Fetch user data from the API
    func fetchUserData() {
        self.isLoading = true
        print("Fetching User Data from API...")

        NetworkManager.shared
            .request([User].self, target: .getUsers)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    AlertManager.showAlertWithButton(title: "Error", message: error.localizedDescription)
                    print("Failed to fetch users: \(error.localizedDescription)")
                case .finished:
                    break
                }
                self?.isLoading = false
            }, receiveValue: { [weak self] users in
                print("Fetched users: \(users)")
                guard let self = self else { return }
                if let randomUser = users.randomElement() {
                    self.user = randomUser
                    print("Selected random user: \(self.user?.name ?? "No user")")
                    self.fetchAlbums(for: randomUser.id)
                }
            })
            .store(in: &cancellables)
    }

    // Fetch albums for a given userId from the API
    private func fetchAlbums(for userId: Int) {
        self.isLoading = true
        print("Fetching Albums for userId: \(userId) from API...")

        NetworkManager.shared
            .request([Album].self, target: .getAlbums(userId: userId))
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    AlertManager.showAlertWithButton(title: "Error", message: error.localizedDescription)
                    print("Failed to fetch albums: \(error.localizedDescription)")
                case .finished:
                    break
                }
                self?.isLoading = false
            }, receiveValue: { [weak self] albums in
                if albums.isEmpty {
                    print("No albums found for user.")
                }
                self?.albums = albums
            })
            .store(in: &cancellables)
    }
}
