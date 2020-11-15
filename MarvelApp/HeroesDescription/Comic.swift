//
//  Comic.swift
//  MarvelApp
//
//  Created by juan ramon gonzalez on 14/11/20.
//

import Foundation

struct Comic: Decodable {
    let title: String
    let thumbnail: Thumbnail
}

struct ComicData: Decodable {
    let results: [Comic]
    let total: Int
}

struct ComicBase: Decodable {
    let data: ComicData
}
