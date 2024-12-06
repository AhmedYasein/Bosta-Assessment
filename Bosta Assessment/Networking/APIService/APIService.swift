//
//  APIService.swift
//  Bosta Assessment
//
//  Created by Ahmed Yasein on 03/12/2024.
//

import Foundation
import Moya
import Combine

enum APIService {
    case getUsers
    case getAlbums(userId: Int)
    case getPhotos(albumId: Int)
}

extension APIService: TargetType {
    var baseURL: URL {
        return URL(string: Constants.API.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getUsers:
            return Constants.API.getUsersEndpoint
        case .getAlbums(_):
            return Constants.API.getAlbumsEndpoint
        case .getPhotos(_):
            return Constants.API.getPhotosEndpoint
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .getUsers:
            return .requestPlain
        case .getAlbums(let userId):
            return .requestParameters(parameters: [Constants.ParametersKeys.userId: userId], encoding: URLEncoding.default)
        case .getPhotos(let albumId):
            return .requestParameters(parameters: [Constants.ParametersKeys.albumId: albumId], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return [Constants.Headers.contentTypeKey: Constants.Headers.contentTypeValue]
      }
}
