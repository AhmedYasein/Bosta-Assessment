//  Bosta Assessment
//  PhotoModel.swift
//
//  Created by Ahmed Yasein on 03/12/2024.
//


import Foundation

// Model for Photo (if needed for album details, assuming this structure is correct)
struct Photo: Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
