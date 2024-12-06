//  Bosta Assessment
//  Constants.swift
//  Created by Ahmed Yasein on 03/12/2024.
//


struct Constants {
    // Cell Identifiers
    struct CellIdentifiers {
        static let albumCell = "AlbumCell"
        static let photoCell = "PhotoCell"
    }
    
    // UI Titles
    struct Titles {
        static let profileTitle = "Profile"
        static let albumsTitle = "Albums"
    }
    
    // Placeholder Images
    struct Images {
        static let placeholderImage = "placeholder"
    }
    
    // API Endpoints
    struct API {
        static let baseURL = "https://jsonplaceholder.typicode.com"
        static let getUsersEndpoint = "/users"
        static let getAlbumsEndpoint = "/albums"
        static let getPhotosEndpoint = "/photos"
    }
    
    // API ParametersKeys
    struct ParametersKeys {
        static let userId = "userId"
        static let albumId = "albumId"
    }
    
    // API Headers
    struct Headers {
        static let contentTypeKey = "Content-Type"
        static let contentTypeValue = "application/json"
    }
    struct Search {
        static let SearchPhotos = "Search Photos"
    }
   
}
