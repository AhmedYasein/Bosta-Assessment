//  Bosta Assessment
//  AlbumDetailsViewModel.swift
//  Created by Ahmed Yasein on 03/12/2024.
//
import Foundation
import Combine
import Moya
import CombineMoya

class AlbumDetailsViewModel: ObservableObject {
    @Published var photos: [Photo] = []
    @Published var filteredPhotos: [Photo] = []
    @Published var error: String? = nil
    @Published var isLoading: Bool = false
    @Published var searchQuery: String = ""
    
    private var cancellables = Set<AnyCancellable>()

    // Fetch photos for the given album ID
    func fetchPhotos(albumId: Int) {
        self.isLoading = true

        NetworkManager.shared.request([Photo].self, target: .getPhotos(albumId: albumId))
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.error = error.localizedDescription
                case .finished:
                    break
                }
                self?.isLoading = false
            }, receiveValue: { [weak self] photos in
                DispatchQueue.main.async {
                    self?.photos = photos
                    self?.filteredPhotos = photos
                    self?.filterPhotos()
                }
            })
            .store(in: &cancellables)
    }

    // Filter photos by title based on search query
    func filterPhotos() {
        print("Filtering photos with query: \(searchQuery)")
        if searchQuery.isEmpty {
            filteredPhotos = photos
        } else {
            filteredPhotos = photos.filter { $0.title.lowercased().contains(searchQuery.lowercased()) }
        }
        print("Filtered Photos Count: \(filteredPhotos.count)")
    }

}
