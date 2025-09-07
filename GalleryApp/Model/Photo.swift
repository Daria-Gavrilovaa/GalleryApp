//
//  Photo.swift
//  GalleryApp
//
//  Created by MAC on 07.09.25.
//
struct Photo: Decodable {
    let id: String
    let description: String?
    let urls: Urls
    let user: User
}
